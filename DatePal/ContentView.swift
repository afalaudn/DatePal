//
//  ContentView.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

// Batas // Udah cek sampai line 264 kanan
import SwiftUI
import CoreData

struct HomePage: View {
    // MARK: Fetch Data
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TopicSet.topicName, ascending: true)])
    private var topicSets: FetchedResults<TopicSet>
    
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: For Animation
    @Namespace private var animation
    @State private var filterList = ["All", "Light Talks", "Deep Talks"]
    @State private var selectedFilter = "All"
    
    // MARK: Editing Conditional
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            NavigationStack {
                ScrollView {
                    LazyVStack(spacing: 25, pinnedViews: [.sectionHeaders]) {
                        Section {
                            HStack(alignment: .center, spacing: 8) {
                                NavigationLink {
                                    AddTopic()
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Get ready for date?")
                                            .font(.title2.bold())
                                            .foregroundColor(.primary)
                                        Text("Set and Pair with Apple Watch")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                                    .shadow(radius: 2)
                            )

                            if !topicSets.isEmpty {
                                Text("Your Customized Topic Set")
                                    .font(.callout.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                VStack(alignment: .leading, spacing: 20) {
                                    ForEach(topicSets, id: \.self) { topicData in
                                        NavigationLink {
                                            AddTopic(topicData: topicData)
                                        } label: {
                                            SwipeAction(cornerRadius: 10, direction: .trailing) {
                                                VStack(alignment: .leading, spacing: 8) {
                                                    Text(topicData.topicName ?? "")
                                                        .font(.subheadline.bold())
                                                        .foregroundColor(.primary)
                                                    Text(topicData.topicList ?? "")
                                                        .font(.subheadline.bold())
                                                        .foregroundColor(.primary)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding()
                                            } actions: {
                                                Action(tint: .red, icon: "trash") {
                                                    deleteData(topicData)
                                                    dismiss()
                                                }
                                            }
                                        }
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .shadow(radius: 2)
                                        )
                                    }
                                }
                                .padding(.top, -10)
                                .padding(.bottom, -10)
                            }

                            VStack(alignment: .leading, spacing: 20) {
                                Text("Conversation Ideas")
                                    .font(.callout.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Picker("", selection: $selectedFilter) {
                                    ForEach(filterList, id: \.self) { filter in
                                        Text(filter)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .shadow(radius: 2)
                                )

                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                    ForEach(TopicModel.allCases, id: \.self) { topic in
                                        if selectedFilter == "All" || (selectedFilter == "Light Talks" && topic.topicCategory == .lightTalks) || (selectedFilter == "Deep Talks" && topic.topicCategory == .deepTalks) {
                                            VStack(spacing: 10) {
                                                Text(topic.emoji)
                                                Text(topic.topicName)
                                                    .font(.subheadline)
                                                    .foregroundStyle(Color.primary)
                                            }
                                            .padding()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.white)
                                                    .shadow(radius: 2)
                                            )
                                            .frame(width: (size.width - 40) / 2, height: 80)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 8)
                        } header: {
                            HeaderView(size: size)
                        }
                    }
                    .padding(15)
                }
                .background(Color.gray.opacity(0.15))
                .onAppear {
                    sendItemsToWatch()
                }
            }
        }
    }

    // MARK: Function Area
    @ViewBuilder
    func HeaderView(size: CGSize) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Your Topics")
                    .font(.title.bold())
            }
            .scaleEffect(1, anchor: .topLeading)
            Spacer(minLength: 0)
        }
        .padding(.bottom, 10)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Material.ultraThin)
                Divider()
            }
            .opacity(1)
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }

    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }

    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.4
        return 1 + scale
    }

    func deleteData(_ topicData: TopicSet) {
        viewContext.delete(topicData)
        do {
            try viewContext.save()
            sendItemsToWatch()
            print("Delete Successful")
        } catch {
            print("Failed \(error.localizedDescription)")
        }
    }
    
    private func addItem(topicName: String, topicList: String) {
        withAnimation {
            let newTopic = TopicSet(context: viewContext)
            newTopic.topicName = topicName
            newTopic.topicList = topicList
            
            do {
                try viewContext.save()
                sendItemsToWatch()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func sendItemsToWatch() {
        WatchSessionManager.shared.sendCoreDataUpdate(topicSets: Array(topicSets))
    }
}

#Preview {
    HomePage()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}




