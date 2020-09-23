//
//  LocalizableProjectStrings.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 17/09/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation


enum HabitDetailStrings: String, Localizable {
    case currentStreak = "HabitDetailStrings_currentStreak"
    case bestStreak = "HabitDetailStrings_bestStreak"
    case daysTracked = "HabitDetailStrings_daysTracked"
    case startedAt = "HabitDetailStrings_startedAt"
}

enum AddOrEditHabitStrings: String, Localizable {
    case fieldTitle = "AddOrEditHabitStrings_fieldTitle"
    case fieldType = "AddOrEditHabitStrings_fieldType"
    case fieldAction = "AddOrEditHabitStrings_fieldAction"
    case fieldMetric = "AddOrEditHabitStrings_fieldMetric"
    case fieldNumber = "AddOrEditHabitStrings_fieldNumber"
    case fieldUnit = "AddOrEditHabitStrings_fieldUnit"
    case goalQuestion = "AddOrEditHabitStrings_goalQuestion"
    case successfullPhrasePrefix = "AddOrEditHabitStrings_successfullPhrasePrefix"
    case placeholderTitle = "AddOrEditHabitStrings_placeholderTitle"
    case placeholderAction = "AddOrEditHabitStrings_placeholderAction"
    case placeholderNumber = "AddOrEditHabitStrings_placeholderNumber"
    case placeholderUnit = "AddOrEditHabitStrings_placeholderUnit"
    case addModeTitle = "AddOrEditHabitStrings_addModeTitle"
    case editModeTitle = "AddOrEditHabitStrings_editModeTitle"
}

enum HabitsTableView: String, Localizable {
    case navigationTitle = "HabitsTableView_navigationTitle"
}

enum AddNumericCompletion: String, Localizable {
    case navigationTitle = "AddNumericCompletion_navigationTitle"
    case labelComment = "AddNumericCompletion_labelComment"
    case labelDate = "AddNumericCompletion_labelDate"
    case labelGoal = "AddNumericCompletion_labelGoal"
}

enum HabitsTableViewCellStrings: String, Localizable {
    case streakLabel = "HabitsTableViewCell_streakLabel"
}

enum AlertMessages: String, Localizable{
    case habitDataDeletion = "AlertMessages_habitDataDeletion"
    case completionDataDeletion = "AlertMessages_completionDataDeletion"
}

enum AlertTitles: String, Localizable{
    case confirmation = "AlertTitles_confirmation"
}

enum AlertButtons: String, Localizable {
    case delete = "AlertButtons_delete"
    case cancel = "AlertButtons_cancel"
    
}
