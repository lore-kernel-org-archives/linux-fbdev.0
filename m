From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 09 Jan 2012 02:36:47 +0000
Subject: Re: [PATCH] grvga: fix section mismatch warnings
Message-Id: <4F0A52BF.8020408@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12/27/2011 09:57 PM, Sam Ravnborg wrote:
>>From 7368b53b755a66c69b2b5ede30e2effe960ad59a Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 27 Dec 2011 22:55:49 +0100
> Subject: [PATCH] grvga: fix section mismatch warnings
> 
> Fix following section mismatch warnings:
> 
> WARNING: drivers/video/built-in.o(.devinit.text+0x110): Section mismatch in reference from the function grvga_probe() to the function .init.text:grvga_parse_custom()
> The function __devinit grvga_probe() references
> a function __init grvga_parse_custom().
> If grvga_parse_custom is only used by grvga_probe then
> annotate grvga_parse_custom with a matching annotation.
> 
> WARNING: drivers/video/built-in.o(.devinit.text+0x1f8): Section mismatch in reference from the function grvga_probe() to the variable .init.data:grvga_fix
> The function __devinit grvga_probe() references
> a variable __initdata grvga_fix.
> If grvga_fix is only used by grvga_probe then
> annotate grvga_fix with a matching annotation.
> 
> WARNING: drivers/video/built-in.o(.devinit.text+0x204): Section mismatch in reference from the function grvga_probe() to the variable .init.data:grvga_fix
> The function __devinit grvga_probe() references
> a variable __initdata grvga_fix.
> If grvga_fix is only used by grvga_probe then
> annotate grvga_fix with a matching annotation.
> 
> grvga_fix is used in a function annotated __devinit - so
> match this using a __devinitdata annotation on grvga_fix.
> 
> grvga_parse_custom() is used in a function annotated
> __devinit - so match this by annotating grvga_parse_custom()
> with __devinit too.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Kristoffer Glembo <kristoffer@gaisler.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Applied this patch.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/grvga.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
> index f37e025..da066c2 100644
> --- a/drivers/video/grvga.c
> +++ b/drivers/video/grvga.c
> @@ -70,7 +70,7 @@ static const struct fb_videomode grvga_modedb[] = {
>      }
>   };
>  
> -static struct fb_fix_screeninfo grvga_fix __initdata = {
> +static struct fb_fix_screeninfo grvga_fix __devinitdata = {
>  	.id =		"AG SVGACTRL",
>  	.type =		FB_TYPE_PACKED_PIXELS,
>  	.visual =       FB_VISUAL_PSEUDOCOLOR,
> @@ -267,7 +267,7 @@ static struct fb_ops grvga_ops = {
>  	.fb_imageblit	= cfb_imageblit
>  };
>  
> -static int __init grvga_parse_custom(char *options,
> +static int __devinit grvga_parse_custom(char *options,
>  				     struct fb_var_screeninfo *screendata)
>  {
>  	char *this_opt;

