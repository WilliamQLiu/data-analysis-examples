var dataset = [15,20,25,30,35,40,35,30,45,50];

/* Learn to load data from csv into objects */
d3.csv("demographics.csv", function(error, data){
    if (error){
      console.log(error);
    } else{
      console.log(data);
    }
    dataset = data;
});

/* Learn to create new HTML elements based on dataset*/
d3.select("body").select("myjstext")
   .data(dataset)
   .enter()
   .append("p")
   .text(function(d){
       return "This is " + d;
   });

/* Learn to create bar charts using divs */
d3.select("body").selectAll("div")
   .data(dataset)
   .enter()
   .append("div")
   .attr("class", "bar")
   .style("height", function(d){
     var barHeight = d * 5; //Scale up height by a factor of 5
    return barHeight + "px";
   });

/* Create bar chart using svgs and multivalue map */
mywidth = 500;
myheight = 100;
mypadding = 1;
var svg = d3.select("body")
    .append("svg")
    .attr("width", mywidth)
    .attr("height", myheight);

svg.selectAll("rect")
   .data(dataset)
   .enter()
   .append("rect")
   .attr({
     x: function(d, i) { return i * (mywidth / dataset.length); }, // width is now tied to svg and number of values
     y: function(d) { return myheight - (d * 2); }, // Need to flip height calc (cause starts upper left), also increase by factor 4
     width: mywidth / dataset.length - mypadding, // Width is fraction of the svg and the padding
     height: function(d) { return d * 2; }, // 
     fill: function(d) { return "rgb(0,0, " + (d * 10) + ")"; } // Custom function for color

   });

/* Added text labels to graph and made them centered */
svg.selectAll("test")
   .data(dataset)
   .enter()
   .append("text")
   .text(function(d){
        return d;
   })
   .attr("x", function(d, i){
       return i * (mywidth / dataset.length) + (mywidth / dataset.length - mypadding) / 2;
   })
   .attr("y", function(d){
       return myheight - (d * 2) + 15;
   })
   .attr("font-family", "sans-serif")
   .attr("font-size", "11px")
   .attr("fill", "white")
   .attr("text-anchor", "middle");

   