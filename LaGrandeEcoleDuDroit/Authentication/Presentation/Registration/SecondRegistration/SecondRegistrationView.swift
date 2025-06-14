import SwiftUI

struct SecondRegistrationDestination: View {
    @StateObject private var viewModel: SecondRegistrationViewModel = AuthenticationInjection.shared.resolve(SecondRegistrationViewModel.self)
    let firstName: String
    let lastName: String
    let onNextClick: (SchoolLevel) -> Void
    
    var body: some View {
        SecondRegistrationView(
            firstName: firstName,
            lastName: lastName,
            schoolLevel: $viewModel.schoolLevel,
            schoolLevels: viewModel.schoolLevels,
            onNextClick: { onNextClick(viewModel.schoolLevel) }
        )
    }
}

private struct SecondRegistrationView: View {
    let firstName: String
    let lastName: String
    @Binding var schoolLevel: SchoolLevel
    let schoolLevels: [SchoolLevel]
    let onNextClick: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: GedSpacing.medium) {
            Text(getString(.selectSchoolLevel))
                .font(.title3)
            
            HStack {
                Text(getString(.level))
                
                Spacer()
                
                Picker(
                    getString(.selectSchoolLevel),
                    selection: $schoolLevel
                ) {
                    ForEach(SchoolLevel.allCases) { level in
                        Text(level.rawValue).tag(level)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.outline, lineWidth: 1)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(getString(.registration))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: {
                        onNextClick()
                    },
                    label: {
                        Text(getString(.next))
                            .foregroundStyle(.gedPrimary)
                            .fontWeight(.semibold)
                    }
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        SecondRegistrationView(
            firstName: "",
            lastName: "",
            schoolLevel: .constant(SchoolLevel.ged1),
            schoolLevels: SchoolLevel.allCases,
            onNextClick: {}
        )
    }
}
