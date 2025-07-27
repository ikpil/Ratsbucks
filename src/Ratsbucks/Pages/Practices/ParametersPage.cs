using MauiReactor.Parameters;

namespace Ratsbucks.Pages.Practices;


public partial class ParametersPage : Component
{
    [Param]
    private IParameter<ParametersPageParam> _customParameter;

    public override VisualNode Render()
    {
        return ContentPage("Parameters Sample", VStack(spacing: 10,
                Button("Increment from parent", () => _customParameter.Set(p => p.Numeric += 1))
                    .AutomationId("Increment_Button"),
                Label(_customParameter.Value.Numeric)
                    .HCenter()
                    .VCenter()
                    .AutomationId("Increment_Label"),
                Button("Open child page", () => Navigation?.PushAsync<ParameterChildComponent>())
            )
            .VCenter()
            .HCenter()
        );
    }
}