namespace Ratsbucks.Pages;

public class AnimatedButtonPage : Component
{
    public override VisualNode Render()
    {
        return new ContentPage("Animated image sample")
        {
            new VStack(spacing: 20)
                {
                    new AnimatedComponent
                        {
                            new Image("tab_home.png"),
                        }
                        .OnTapped(OnTapped),

                    new Image("tab_home.png")
                        .OnTappedWithAnimation(OnTapped),

                    new AnimatedComponent2
                        {
                            new Image("tab_home.png"),
                        }
                        .OnTapped(OnTapped)
                }
                .VCenter()
        };
    }

    async Task OnTapped()
    {
        if (ContainerPage != null)
        {
            await ContainerPage.DisplayAlert("MauiReactor", "Tapped!", "OK");
        }
    }
}

class AnimatedComponent : Component
{
    private Func<Task>? _action;
    private MauiControls.Grid? _containerGrid;

    public AnimatedComponent OnTapped(Func<Task> action)
    {
        _action = action;
        return this;
    }

    public override VisualNode Render()
    {
        return new Grid(grid => _containerGrid = grid)
            {
                Children()
            }
            .OnTapped(async () =>
            {
                if (_containerGrid != null && _action != null)
                {
                    await MauiControls.ViewExtensions.ScaleTo(_containerGrid, 0.7);
                    await _action.Invoke();
                    await MauiControls.ViewExtensions.ScaleTo(_containerGrid, 1.0);
                }
            });
    }
}

static class AnimatedButtonExtensions
{
    public static T OnTappedWithAnimation<T>(this T view, Func<Task> action) where T : IView
    {
        view.OnTapped(async (sender, args) =>
        {
            var visualElement = (MauiControls.VisualElement?)sender;
            if (visualElement == null)
            {
                return;
            }

            await MauiControls.ViewExtensions.ScaleTo(visualElement, 0.7);
            await action.Invoke();
            await MauiControls.ViewExtensions.ScaleTo(visualElement, 1.0);
        });
        return view;
    }
}

class AnimatedComponent2 : Component
{
    private Func<Task>? _action;

    public AnimatedComponent2 OnTapped(Func<Task> action)
    {
        _action = action;
        return this;
    }

    public override VisualNode Render()
    {
        var child = Children().FirstOrDefault();
        if (child == null)
        {
            return null!;
        }

        if (child is IView viewChild)
        {
            viewChild.OnTapped(async (sender, args) =>
            {
                var visualElement = (MauiControls.VisualElement?)sender;
                if (visualElement == null)
                {
                    return;
                }

                if (_action != null)
                {
                    await MauiControls.ViewExtensions.ScaleTo(visualElement, 0.7);
                    await _action.Invoke();
                    await MauiControls.ViewExtensions.ScaleTo(visualElement, 1.0);
                }
            });
        }

        return child;
    }
}