using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ratsbucks.Resources;

class ApplicationTheme
{
    public static Color AccentColor { get; } = Color.FromUint(0xFF5E9EFF);
    public static Color Shadow { get; } = Color.FromUint(0xFF4A5367);
    public static Brush ShadowBrush { get; } = new SolidColorBrush(Shadow);
    public static Color ShadowDark { get; } = Color.FromUint(0xFF000000);
    public static Brush ShadowDarkBrush { get; } = new SolidColorBrush(Shadow);
    public static Color Background { get; } = Color.FromUint(0xFFF2F6FF);
    public static Color BackgroundDark { get; } = Color.FromUint(0xFF25254B);
    public static Color Background2 { get; } = Color.FromUint(0xFF17203A);
    
}
