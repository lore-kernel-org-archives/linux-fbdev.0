From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Fri, 28 Dec 2012 19:01:04 +0000
Subject: Re: [PATCH fix-3.8] video: vt8500: Fix X crash when initializing framebuffer.
Message-Id: <50DDFA3D.1000506@mvista.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1356567943-3836-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1356567943-3836-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 12/27/2012 03:25 AM, Tony Prisk wrote:

> This patch adds support for .fb_check_var which is required when
> X attempts to initialize the framebuffer. The only supported
> resolution is the native resolution of the LCD panel, so we test
> against the resolution supplied from the DT panel definition.

> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/video/wm8505fb.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

> diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
> index 77539c1..c84e376 100644
> --- a/drivers/video/wm8505fb.c
> +++ b/drivers/video/wm8505fb.c
[...]
> @@ -248,8 +256,21 @@ static int wm8505fb_blank(int blank, struct fb_info *info)
>  	return 0;
>  }
>  
> +static int wm8505fb_check_var(struct fb_var_screeninfo *var,
> +			      struct fb_info *info)
> +{
> +	struct wm8505fb_info *fbi = to_wm8505fb_info(info);
> +        if (!fbi) return -EINVAL;
> +
> +	if (info->var.bits_per_pixel != fbi->lcd_params.color_depth) return -EINVAL;
> +	if (info->var.xres != fbi->lcd_params.pixel_width) return -EINVAL;
> +	if (info->var.yres != fbi->lcd_params.pixel_height) return -EINVAL;
> +	return 0;
> +}
> +

[...]

$ scripts/checkpatch.pl
patches/video-vt8500-Fix-X-crash-when-initializing-framebuffer.patch
ERROR: code indent should use tabs where possible
#42: FILE: drivers/video/wm8505fb.c:263:
+        if (!fbi) return -EINVAL;$

WARNING: please, no spaces at the start of a line
#42: FILE: drivers/video/wm8505fb.c:263:
+        if (!fbi) return -EINVAL;$

ERROR: trailing statements should be on next line
#42: FILE: drivers/video/wm8505fb.c:263:
+        if (!fbi) return -EINVAL;

WARNING: line over 80 characters
#44: FILE: drivers/video/wm8505fb.c:265:
+	if (info->var.bits_per_pixel != fbi->lcd_params.color_depth) return -EINVAL;

ERROR: trailing statements should be on next line
#44: FILE: drivers/video/wm8505fb.c:265:
+	if (info->var.bits_per_pixel != fbi->lcd_params.color_depth) return -EINVAL;

ERROR: trailing statements should be on next line
#45: FILE: drivers/video/wm8505fb.c:266:
+	if (info->var.xres != fbi->lcd_params.pixel_width) return -EINVAL;

ERROR: trailing statements should be on next line
#46: FILE: drivers/video/wm8505fb.c:267:
+	if (info->var.yres != fbi->lcd_params.pixel_height) return -EINVAL;

total: 5 errors, 2 warnings, 49 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

patches/video-vt8500-Fix-X-crash-when-initializing-framebuffer.patch has style
problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.

WBR, Sergei

