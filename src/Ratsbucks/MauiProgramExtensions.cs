using CommunityToolkit.Maui;
using MauiReactor;
using Ratsbucks.Pages;
using Microsoft.Extensions.Logging;
using Ratsbucks.Resources.Styles;
using SkiaSharp.Views.Maui.Controls.Hosting;

namespace Ratsbucks;

public static class MauiProgramExtensions
{
    public static MauiAppBuilder UseSharedMauiApp(this MauiAppBuilder builder)
    {
        builder
            .UseMauiReactorApp<MainPage>(app =>
            {
                app.UseTheme<ApplicationTheme>();
            })
            .UseMauiCommunityToolkit()
            .UseSkiaSharp()
#if DEBUG
            //.EnableMauiReactorHotReload()
#endif

            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
            });

#if DEBUG
        builder.Logging.AddDebug();
#endif

        return builder;
    }
}