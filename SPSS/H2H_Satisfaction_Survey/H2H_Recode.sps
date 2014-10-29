

GET DATA  /TYPE=TXT
  /FILE="/Users/williamliu/GitHub/surveys/pivoted_survey.csv"
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  respondent_id F10.0
  V01 A
  V02 A
  V03 A
  V04 A
  V05 A
  V06 A
  V07 A
  V08 A
  V09 A
  V10 A
  V11 A
  V12 A
  V13 A
  V14 A
  V15 A
  V16 A
  V17 A
  V18 A
  V19 A
  V20 A
  V21 A
  V22 A
  V23 A
  V24 A
  V25 A
  V26 A
  V27 A
  V28 A
  V29 A
  V30 A
  V31 A
  V32 A
  V33 A
  V34 A
  V35 A
  V36 A
  V37 A
  V38 A
  V39 A
  V40 A
  V41 A
  V42 A
  V43 A
  V44 A
  V45 A
  V46 A
  V47 A
  V48 A
  V49 A
  V50 A
  V51 A
  V52 A
  V53 A
  V54 A
  V55 A
  V56 A
  V57 A
  V58 A
  V59 A
  V60 A
  V61 A
  V62 A
  V63 A
  V64 A
  V65 A
  V66 A
  V67 A
  V68 A
  V69 A
  V70 A
  V71 A
  V72 A
  V73 A
  V74 A
  V75 A
  V76 A
  V77 A
  V78 A
  V79 A
  V80 A
  V81 A
  V82 A
  V83 A
  V84 A
  V85 A
  V86 A
  V87 A
  V88 A
  V89 A
  V90 A
  V91 A
  V92 A
  V93 A
  V94 A
  V95 A
  V96 A
  V97 A.
CACHE.

AUTORECODE VARIABLES=V01  V02  V03 V04  V05  V06  V07  V08  V09  V10  V11  V12  V13  V14  V15  V16  V17  V18  V19  V20  V21  V22  V23  V24  V25  V26  V27  V28  V29  V30  V31  V32  V33  V34  V35  V36  V37  V38  V39  V40
  V41  V42  V43  V44  V45  V46  V47  V48  V49  V50  V51  V52  V53  V54  V55  V56  V57  V58  V59  V60  V61  V62  V63  V64  V65  V66  V67  V68  V69  V70  V71  V72  V73  V74  V75  V76  V77  V78  V79  V80
  V81 V82 V83 V84 V85 V86 V87 V88 V89 V90 V91 V92 V93 V94 V95 V96 V97
  /INTO Z01_I_am_between Z02_I_have_been_employed_at_MHA_for Z03_I_have_other_employment_outside_MHA Z04_I_work_outside_of_MHA_in_a_clinicaltherapeutic_capacity Z05_I_am_happy 
  Z06_I_am_preoccupied_with_more_than_one_person_I_help Z07_I_get_satisfaction_from_being_able_to_help_people Z08_I_feel_connected_to_others Z09_I_jump_or_am_startled_by_unexpected_sounds 
  Z10_I_feel_invigorated_after_working_with_those_I_help Z11_I_find_it_difficult_to_separate_my_personal_life_from_my_lif Z12_I_am_not_as_productive_at_work_because_I_am_losing_sleep_ov 
  Z13_I_think_that_I_might_have_been_affected_by_the_traumatic_str Z14_I_feel_trapped_by_my_job_as_a_counselor Z15_Because_of_my_counseling_I_have_felt_on_edge_about_various_t 
  Z16_I_like_my_work_as_a_counselor Z17_I_feel_depressed_because_of_the_traumatic_experiences_of_the Z18_I_feel_as_though_I_am_experiencing_the_trauma_of_someone_I_h 
  Z19_I_have_beliefs_that_sustain_me Z20_I_am_pleased_with_how_I_am_able_to_keep_up_with_counseling_t Z21_I_am_the_person_I_always_wanted_to_be Z22_My_work_makes_me_feel_satisfied 
  Z23_I_feel_worn_out_because_of_my_work_as_a_counselor Z24_I_have_happy_thoughts_and_feelings_about_those_I_help_and_ho Z25_I_feel_overwhelmed_because_my_casework_load_seems_endless 
  Z26_I_believe_I_can_make_a_difference_through_my_work Z27_I_avoid_certain_activities_or_situations_because_they_remin Z28_I_am_proud_of_what_I_can_do_to_help 
  Z29_As_a_result_of_my_helping_I_have_intrusive_frightening_thou Z30_I_feel_bogged_down_by_the_system Z31_I_have_thoughts_that_I_am_a_success_as_a_counselor 
  Z32_I_cant_recall_important_parts_of_my_work_with_trauma_victims Z33_I_am_a_very_caring_person Z34_I_am_happy_that_I_chose_to_do_this_work Z35_I_am_fairly_compensated 
  Z36_I_am_happy_with_my_work_shift Z37_I_am_learning_from_my_peers Z38_I_am_learning_from_my_supervisors Z39_I_have_opportunities_for_growth_within_the_organization Z40_I_have_opportunities_for_professional_developme
  Z41_I_receive_individual_clinical_supervision_with Z42_My_supervisor_was_approachable Z43_My_supervisor_was_respectful_of_my_views_and_ideas Z44_My_supervisor_gave_me_feedback_in_a_way_that_felt_safe 
  Z45_My_supervisor_was_enthusiastic_about_supervising_me Z46_I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor Z47_My_supervisor_was_nonjudgemental_in_supervision 
  Z48_My_supervisor_was_openminded_in_supervision Z49_My_supervisor_gave_me_positive_feedback_on_my_performance Z50_My_supervisor_had_a_collaborative_approach_in_supervision 
  Z51_My_supervisor_encouraged_me_to_reflect_on_my_practice Z52_My_supervisor_paid_attention_to_my_unspoken_feelings_and_anx Z53_My_supervisor_drew_flexibly_from_a_number_of_theoretical_mod 
  Z54_My_supervisor_paid_close_attention_to_the_process_of_supervi Z55_My_supervisor_helped_me_identify_my_own_learningtraining_nee Z56_Supervision_sessions_were_focused Z57_Supervision_sessions_were_structured 
  Z58_My_supervision_sessions_were_disorganised Z59_My_supervisor_made_sure_that_our_supervision_sessions_were_k Z60_I_receive_individual_clinical_supervision_with Z61_My_supervisor_was_approachable 
  Z62_My_supervisor_was_respectful_of_my_views_and_ideas Z63_My_supervisor_gave_me_feedback_in_a_way_that_felt_safe Z64_My_supervisor_was_enthusiastic_about_supervising_me 
  Z65_I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor Z66_My_supervisor_was_nonjudgemental_in_supervision Z67_My_supervisor_was_openminded_in_supervision 
  Z68_My_supervisor_gave_me_positive_feedback_on_my_performance Z69_My_supervisor_had_a_collaborative_approach_in_supervision Z70_My_supervisor_encouraged_me_to_reflect_on_my_practice 
  Z71_My_supervisor_paid_attention_to_my_unspoken_feelings_and_anx Z72_My_supervisor_drew_flexibly_from_a_number_of_theoretical_mod Z73_My_supervisor_paid_close_attention_to_the_process_of_supervi 
  Z74_My_supervisor_helped_me_identify_my_own_learningtraining_nee Z75_Supervision_sessions_were_focused Z76_Supervision_sessions_were_structured Z77_My_supervision_sessions_were_disorganised 
  Z78_My_supervisor_made_sure_that_our_supervision_sessions_were_k Z79_I_receive_group_clinical_supervision_with Z80_My_supervisor_was_approachable Z81_My_supervisor_was_respectful_of_my_views_and_ideas 
  Z82_My_supervisor_gave_me_feedback_in_a_way_that_felt_safe Z83_My_supervisor_was_enthusiastic_about_supervising_me Z84_I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor 
  Z85_My_supervisor_was_nonjudgemental_in_supervision Z86_My_supervisor_was_openminded_in_supervision Z87_My_supervisor_gave_me_positive_feedback_on_my_performance 
  Z88_My_supervisor_had_a_collaborative_approach_in_supervision Z89_My_supervisor_encouraged_me_to_reflect_on_my_practice Z90_My_supervisor_paid_attention_to_my_unspoken_feelings_and_anx 
  Z91_My_supervisor_drew_flexibly_from_a_number_of_theoretical_mod Z92_My_supervisor_paid_close_attention_to_the_process_of_supervi Z93_My_supervisor_helped_me_identify_my_own_learningtraining_nee 
  Z94_Supervision_sessions_were_focused Z95_Supervision_sessions_were_structured Z96_My_supervision_sessions_were_disorganised Z97_My_supervisor_made_sure_that_our_supervision_sessions_were_k
  /BLANK=MISSING.

DELETE VARIABLES V01  V02  V03 V04  V05  V06  V07  V08  V09  V10  V11  V12  V13  V14  V15  V16  V17  V18  V19  V20  V21  V22  V23  V24  V25  V26  V27  V28  V29  V30  V31  V32  V33  V34  V35  V36  V37  V38  V39  V40
  V41  V42  V43  V44  V45  V46  V47  V48  V49  V50  V51  V52  V53  V54  V55  V56  V57  V58  V59  V60  V61  V62  V63  V64  V65  V66  V67  V68  V69  V70  V71  V72  V73  V74  V75  V76  V77  V78  V79  V80
  V81 V82 V83 V84 V85 V86 V87 V88 V89 V90 V91 V92 V93 V94 V95 V96 V97.

/* Autorecode doesn't set the order correctly, need to manually adjust

VARIABLE LABELS
Z01_I_am_between Z02_I_have_been_employed_at_MHA_for Z03_I_have_other_employment_outside_MHA Z04_I_work_outside_of_MHA_in_a_clinicaltherapeutic_capacity Z05_I_am_happy 
  Z06_I_am_preoccupied_with_more_than_one_person_I_help Z07_I_get_satisfaction_from_being_able_to_help_people Z08_I_feel_connected_to_others Z09_I_jump_or_am_startled_by_unexpected_sounds 
  Z10_I_feel_invigorated_after_working_with_those_I_help Z11_I_find_it_difficult_to_separate_my_personal_life_from_my_lif Z12_I_am_not_as_productive_at_work_because_I_am_losing_sleep_ov 
  Z13_I_think_that_I_might_have_been_affected_by_the_traumatic_str Z14_I_feel_trapped_by_my_job_as_a_counselor Z15_Because_of_my_counseling_I_have_felt_on_edge_about_various_t 
  Z16_I_like_my_work_as_a_counselor Z17_I_feel_depressed_because_of_the_traumatic_experiences_of_the Z18_I_feel_as_though_I_am_experiencing_the_trauma_of_someone_I_h 
  Z19_I_have_beliefs_that_sustain_me Z20_I_am_pleased_with_how_I_am_able_to_keep_up_with_counseling_t Z21_I_am_the_person_I_always_wanted_to_be Z22_My_work_makes_me_feel_satisfied 
  Z23_I_feel_worn_out_because_of_my_work_as_a_counselor Z24_I_have_happy_thoughts_and_feelings_about_those_I_help_and_ho Z25_I_feel_overwhelmed_because_my_casework_load_seems_endless 
  Z26_I_believe_I_can_make_a_difference_through_my_work Z27_I_avoid_certain_activities_or_situations_because_they_remin Z28_I_am_proud_of_what_I_can_do_to_help 
  Z29_As_a_result_of_my_helping_I_have_intrusive_frightening_thou Z30_I_feel_bogged_down_by_the_system Z31_I_have_thoughts_that_I_am_a_success_as_a_counselor 
  Z32_I_cant_recall_important_parts_of_my_work_with_trauma_victims Z33_I_am_a_very_caring_person Z34_I_am_happy_that_I_chose_to_do_this_work Z35_I_am_fairly_compensated 
  Z36_I_am_happy_with_my_work_shift Z37_I_am_learning_from_my_peers Z38_I_am_learning_from_my_supervisors Z39_I_have_opportunities_for_growth_within_the_organization Z40_I_have_opportunities_for_professional_developme
  Z41_I_receive_individual_clinical_supervision_with Z42_My_supervisor_was_approachable Z43_My_supervisor_was_respectful_of_my_views_and_ideas Z44_My_supervisor_gave_me_feedback_in_a_way_that_felt_safe 
  Z45_My_supervisor_was_enthusiastic_about_supervising_me Z46_I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor Z47_My_supervisor_was_nonjudgemental_in_supervision 
  Z48_My_supervisor_was_openminded_in_supervision Z49_My_supervisor_gave_me_positive_feedback_on_my_performance Z50_My_supervisor_had_a_collaborative_approach_in_supervision 
  Z51_My_supervisor_encouraged_me_to_reflect_on_my_practice Z52_My_supervisor_paid_attention_to_my_unspoken_feelings_and_anx Z53_My_supervisor_drew_flexibly_from_a_number_of_theoretical_mod 
  Z54_My_supervisor_paid_close_attention_to_the_process_of_supervi Z55_My_supervisor_helped_me_identify_my_own_learningtraining_nee Z56_Supervision_sessions_were_focused Z57_Supervision_sessions_were_structured 
  Z58_My_supervision_sessions_were_disorganised Z59_My_supervisor_made_sure_that_our_supervision_sessions_were_k Z60_I_receive_individual_clinical_supervision_with Z61_My_supervisor_was_approachable 
  Z62_My_supervisor_was_respectful_of_my_views_and_ideas Z63_My_supervisor_gave_me_feedback_in_a_way_that_felt_safe Z64_My_supervisor_was_enthusiastic_about_supervising_me 
  Z65_I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor Z66_My_supervisor_was_nonjudgemental_in_supervision Z67_My_supervisor_was_openminded_in_supervision 
  Z68_My_supervisor_gave_me_positive_feedback_on_my_performance Z69_My_supervisor_had_a_collaborative_approach_in_supervision Z70_My_supervisor_encouraged_me_to_reflect_on_my_practice 
  Z71_My_supervisor_paid_attention_to_my_unspoken_feelings_and_anx Z72_My_supervisor_drew_flexibly_from_a_number_of_theoretical_mod Z73_My_supervisor_paid_close_attention_to_the_process_of_supervi 
  Z74_My_supervisor_helped_me_identify_my_own_learningtraining_nee Z75_Supervision_sessions_were_focused Z76_Supervision_sessions_were_structured Z77_My_supervision_sessions_were_disorganised 
  Z78_My_supervisor_made_sure_that_our_supervision_sessions_were_k Z79_I_receive_group_clinical_supervision_with Z80_My_supervisor_was_approachable Z81_My_supervisor_was_respectful_of_my_views_and_ideas 
  Z82_My_supervisor_gave_me_feedback_in_a_way_that_felt_safe Z83_My_supervisor_was_enthusiastic_about_supervising_me Z84_I_felt_able_to_openly_discuss_my_concerns_with_my_supervisor 
  Z85_My_supervisor_was_nonjudgemental_in_supervision Z86_My_supervisor_was_openminded_in_supervision Z87_My_supervisor_gave_me_positive_feedback_on_my_performance 
  Z88_My_supervisor_had_a_collaborative_approach_in_supervision Z89_My_supervisor_encouraged_me_to_reflect_on_my_practice Z90_My_supervisor_paid_attention_to_my_unspoken_feelings_and_anx 
  Z91_My_supervisor_drew_flexibly_from_a_number_of_theoretical_mod Z92_My_supervisor_paid_close_attention_to_the_process_of_supervi Z93_My_supervisor_helped_me_identify_my_own_learningtraining_nee 
  Z94_Supervision_sessions_were_focused Z95_Supervision_sessions_were_structured Z96_My_supervision_sessions_were_disorganised Z97_My_supervisor_made_sure_that_our_supervision_sessions_were_k.

VALUE LABELS
Z01_I_am_between
1 '18-25 years old'
2 '26-33 years old'
3 '34-41 years old'
4 '42 and above'.

VALUE LABELS
Z02_I_have_been_employed_at_MHA_for
1 '<2 years'
2 '3-5 years'
3 '5-7 years'
4 '8- 10 years'
5 '>10 years'.

VALUE LABELS
Z03_I_have_other_employment_outside_MHA Z04_I_work_outside_of_MHA_in_a_clinicaltherapeutic_capacity
1 'No'
2 'Yes (Part-Time)'
3 'Yes (Full-Time)'.

VALUE LABELS
Z05_I_am_happy  to  Z34_I_am_happy_that_I_chose_to_do_this_work Z35_I_am_fairly_compensated
1 'Never'
2 'Rarely'
3 'Sometimes'
4 'Often'
5 'Very Often'.

VALUE LABELS
Z35_I_am_fairly_compensated  to  Z40_I_have_opportunities_for_professional_developme
1 'Strongly Disagree'
2 'Disagree'
3 'Neither Agree Nor Disagree'
4 'Agree'
5 'Strongly Agree'.

VALUE LABELS
Z42_My_supervisor_was_approachable  to  Z59_My_supervisor_made_sure_that_our_supervision_sessions_were_k
1 'Strongly Disagree'
2 'Disagree'
3 'Slightly Disagree'
4 'Neight Agree Nor Disagree'
5 'Slightly Agree'
6 'Agree'
7 'Strongly Agree'.

VALUE LABELS
Z61_My_supervisor_was_approachable  to  Z78_My_supervisor_made_sure_that_our_supervision_sessions_were_k
1 'Strongly Disagree'
2 'Disagree'
3 'Slightly Disagree'
4 'Neight Agree Nor Disagree'
5 'Slightly Agree'
6 'Agree'
7 'Strongly Agree'.

VALUE LABELS
Z80_My_supervisor_was_approachable  to  Z97_My_supervisor_made_sure_that_our_supervision_sessions_were_k
1 'Strongly Disagree'
2 'Disagree'
3 'Slightly Disagree'
4 'Neight Agree Nor Disagree'
5 'Slightly Agree'
6 'Agree'
7 'Strongly Agree'.

VALUE LABELS
Z41_I_receive_individual_clinical_supervision_with Z60_I_receive_individual_clinical_supervision_with Z79_I_receive_group_clinical_supervision_with 
1 'TheJoker'
2 'Wonderwoman'
3 'Superman'
4 'Grumpy'
5 'Spiderman'
6 'Robin'
7 'PiedPiper'
8 'Batman'
9 'Sleepy'
10 'I do not receive any additional individual clinical supervision (Skip to Next Page)'
11 'I do not receive clinical supervision (Skip to Next Page)'
12 'I do not receive group clinical supervision (Skip to Next Page)'.    

MISSING VALUES
Z01_I_am_between  to  Z97_My_supervisor_made_sure_that_our_supervision_sessions_were_k (999).

EXECUTE.

DATASET NAME DataSet1 WINDOW=FRONT.





