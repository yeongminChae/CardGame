//
//  ContentView.swift
//  Memorize_Assingment
//
//  Created by 채영민 on 2023/08/18.
//

import SwiftUI

enum Theme {
    case Vehicle
    case Halloween
    case Country
}

struct ContentView: View {
    @State private var selectedTheme: Theme = .Vehicle
    let columns = [GridItem(.adaptive(minimum: 65))]

    var currentThemeArr: [String] {
        switch selectedTheme {
        case .Vehicle :
            return ["✈️","🚗","🚙","🚌","🚐","🚛","🚑","🚒","🚕","🚓"]
        case .Halloween:
            return ["💀","🎃","👻","😈","🍭","🍬","🕯️","🦇","🙀","😱"]
        case .Country:
            return ["🇺🇸","🇬🇧","🇨🇦","🇰🇷","🇫🇮","🇩🇪","🇫🇷","🇮🇹","🇪🇸","🇵🇹"]
        }
    }

    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle).fontWeight(.semibold)
            Spacer()
            Text(selectedTheme == .Vehicle ? "Vehicle" : selectedTheme == .Halloween ? "Halloween" : "Country")
                .font(.subheadline).fontWeight(.semibold)
            cards
            Spacer()
            themeChooseSection
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            let doubledVehicleArr = (currentThemeArr + currentThemeArr).shuffled()

            ForEach (doubledVehicleArr.indices, id: \.self) { index in
                CardView(content: doubledVehicleArr[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(selectedTheme == .Vehicle ? .red : selectedTheme == .Halloween ? .purple : .mint)
    }

    var themeChooseSection: some View {
        HStack(spacing: 40) {
            themeChooseFunc(symbol: "car", title: "Vehicle", theme: .Vehicle)
            themeChooseFunc(symbol: "syringe", title: "Halloween", theme: .Halloween)
            themeChooseFunc(symbol: "globe", title: "Country", theme: .Country)
        }
    }

    func themeChooseFunc(symbol: String, title: String, theme: Theme) -> some View {
        Button(action: {
            selectedTheme = theme
        }, label : {
            VStack(alignment: .center, spacing: 1) {
                Spacer()
                Image(systemName: symbol)
                    .font(.title2).fontWeight(.semibold)
                Text(title)
                    .font(.system(size: 15))
            }
            .foregroundColor(.blue)
        })
    }
}

struct CardView : View {
    let content: String
    let baseRectangle = RoundedRectangle(cornerRadius: 12)
    @State private var isClicked: Bool = false

    var body: some View {
        ZStack {
            Group {
                baseRectangle.foregroundColor(.white)
                baseRectangle.strokeBorder(lineWidth: 2)
                Text(content).font(.system(size: 35))
            }
            .opacity(!isClicked ? 0 : 1)
            baseRectangle.fill().opacity(isClicked ? 0 : 1)
        }
        .onTapGesture {
            isClicked.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isClicked.toggle()
            }
        }
        .animation(.easeInOut, value: isClicked)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
