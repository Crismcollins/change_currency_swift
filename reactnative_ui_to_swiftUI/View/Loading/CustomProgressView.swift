//
//  CustomProgressView.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 10-08-23.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .scaleEffect(2)
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
