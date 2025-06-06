import SwiftUI

struct SecondRegistrationView: View {
    @EnvironmentObject private var registrationViewModel: RegistrationViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: GedSpacing.medium) {
            Text(getString(.selectSchoolLevel))
                .font(.title3)
            
            HStack {
                Text(getString(.level))
                
                Spacer()
                
                Picker(
                    getString(.selectSchoolLevel),
                    selection: $registrationViewModel.schoolLevel
                ) {
                    ForEach(registrationViewModel.schoolLevels, id: \.self) { level in
                        Text(level)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(.inputBackground)
            .cornerRadius(GedSpacing.small)
            
            Spacer()
            
            NavigationLink(
                destination: ThirdRegistrationView()
                    .environmentObject(registrationViewModel)
            ) {
                Text(getString(.next))
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.gedPrimary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .onAppear {
            registrationViewModel.clearEmail()
            registrationViewModel.clearPassword()
            registrationViewModel.resetState()
        }
        .registrationToolbar(step: 2, maxStep: 3)
    }
}

#Preview {
    NavigationStack {
        SecondRegistrationView()
            .environmentObject(
                AuthenticationInjection.shared.resolveWithMock().resolve(RegistrationViewModel.self)!
            )
    }
}
