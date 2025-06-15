using MauiReactor;
using MauiReactor.Parameters;

namespace Ratsbucks.Pages;

public partial class ParameterChildComponent : Component
{
    [Param]
    private IParameter<ParametersPageParam> _customParameter;

    public override VisualNode Render()
    {
        return ContentPage(VStack(spacing: 10,
            Button("Increment from child", () => _customParameter.Set(p => p.Numeric += 1)),
            Label(_customParameter.Value.Numeric)
        ));
    }
}