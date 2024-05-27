//
//  AddTopic.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import Foundation
import SwiftUI

struct AddTopic: View {
    @State private var topicName: String = ""
    @State private var selectedTopics: [String] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var shouldDismiss = false
    @State private var dragAmount = CGSize.zero
    @Namespace private var namespace
    //MARK: Core Data
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    //MARK: End of Core Data
    // topicData dideklarasikan disini
    var topicData: Kencan?
    
    init(topicData: Kencan? = nil) {
        self.topicData = topicData
        if let topicData = topicData {
            _topicName = State(initialValue: topicData.topicName ?? "")
            _selectedTopics = State(initialValue: (topicData.topicList ?? "").components(separatedBy: ","))
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 25, pinnedViews: [.sectionHeaders]) {
                            Section {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Topic Name")
                                        .font(.callout.bold())
                                        .foregroundColor(.primary)
                                    TextField("", text: $topicName)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .shadow(radius: 2)
                                        )
                                    Spacer()
                                    Text("Select your topics for your date!")
                                        .font(.title3.bold())
                                    Text("You only can choose 3 topics, no more, no less")
                                        .font(.caption)
                                    Spacer()
                                    // ! is not operator
                                    // selectedTopics tidak kosong
                                    if (!selectedTopics.isEmpty) {
                                        Text("Selected Topics")
                                            .font(.callout.bold())
                                    }
                                    LazyVStack(spacing: 10) {
                                        ForEach(selectedTopics.indices, id: \.self) { index in
                                            HStack {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .padding(.leading)
                                                    .foregroundColor(.black)
                                                if let emoji = TopicModel(rawValue: selectedTopics[index])?.emoji {
                                                    Text(emoji)
                                                        .padding(.trailing,12)
                                                }
                                                Text(selectedTopics[index])
                                                    .fontWeight(.semibold)
                                                Spacer()
                                                Button(action: {
                                                    selectedTopics.remove(at: index)
                                                    print(selectedTopics)
                                                }, label: {
                                                    Image(systemName: "minus.circle.fill")
                                                        .padding(.trailing)
                                                        .foregroundColor(.red)
                                                })
                                            }
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.white)
                                                    .shadow(radius: 2)
                                            )
                                        }
                                    }
                                    Text("Available Topics")
                                        .font(.callout.bold())
                                    Spacer(minLength: 0)
                                    LazyVStack(spacing: 10) {
                                        ForEach(TopicModel.allCases.filter { !selectedTopics.contains($0.rawValue) }, id: \.self) { topic in
                                            HStack {
                                                Button(action: {
                                                    print("\(topic.topicName) selected")
                                                    if selectedTopics.count < 3 {
                                                        selectedTopics.append(topic.topicName)
                                                    } else {
                                                        showAlert = true
                                                        alertMessage = "You can only select three topics."
                                                    }
                                                    print(selectedTopics)
                                                }, label: {
                                                    Image(systemName: "plus.circle.fill")
                                                        .padding(.leading)
                                                        .foregroundColor(.green)
                                                })
                                                Text(topic.emoji)
                                                    .padding(.trailing, 12)
                                                Text(topic.topicName)
                                                    .fontWeight(.semibold)
                                                Spacer()
                                            }
                                            .matchedGeometryEffect(id: topic.rawValue, in: namespace)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.white)
                                                    .shadow(radius: 2)
                                            )
                                        }
                                    }
                                }
                                .padding(15)
                            }
                        }
                    }
                }
                .navigationTitle(topicData == nil ? "Add Topic" : "Edit Topic")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    // Perform save action here
                    saveData()
                }) {
                    Text("Save")
                })
            }
        }
        
        .animation(.easeInOut, value: selectedTopics)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Selection Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onChange(of: shouldDismiss) { newValue in
            if newValue {
                dismiss()
            }
        }
    }
    func saveData() {
        if topicName.isEmpty {
            showAlert = true
            alertMessage = "You title can't be empty."
        } else if selectedTopics.count != 3 {
            showAlert = true
            alertMessage = "You can't save less than three topics."
        } else {
            let topicSet: Kencan
            if let existingTopicSet = topicData {
                topicSet = existingTopicSet
            } else {
                topicSet = Kencan(context: self.viewContext)
            }
            topicSet.topicName = topicName
            topicSet.topicList = selectedTopics.joined(separator: ",")
            do {
                try self.viewContext.save()
                shouldDismiss = true
            } catch {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    AddTopic()
}
