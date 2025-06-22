namespace Ratsbucks.Pages;

public class ImagePage : Component
{
    public override VisualNode Render()
    {
        return ContentPage(
            "Image",
            Image("dotnet_bot.png")
                .Shadow(Shadow()
                    .Brush(Brush.Purple)
                    .Offset(20, 20)
                    .Radius(40)
                    .Opacity(0.8f)
                )
                .VCenter()
                .HCenter()
        );
    }
}