using CommunityToolkit.Maui;
using MauiReactor;
using Ratsbucks.Pages;
using Microsoft.Extensions.Logging;
using Ratsbucks.Resources.Styles;
using Ratsbucks.Services;
using SkiaSharp.Views.Maui.Controls.Hosting;

namespace Ratsbucks;

public static class MauiProgramExtensions
{
    public static MauiAppBuilder UseSharedMauiApp(this MauiAppBuilder builder)
    {
        builder
            .UseMauiCommunityToolkit()
            .UseMauiReactorApp<MainPage>(app =>
            {
                app.UseTheme<ApplicationTheme>();
            }, unhandledExceptionAction: args =>
            {
                Console.WriteLine(args.ExceptionObject);
            })
            .UseSkiaSharp()
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
            })
            .Services.AddSingleton<IncrementService>();

#if DEBUG
        builder.Logging.AddDebug();
#endif

        return builder;
    }
}