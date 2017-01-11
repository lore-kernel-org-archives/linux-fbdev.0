From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 11 Jan 2017 12:50:29 +0000
Subject: Re: [PATCH v2] video: fbdev: sh_mobile_lcdcfb: use designated initializers
Message-Id: <4446544.3TN0Epkxz7@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20161220201053epcas1p3440c5c2973397422318bae039948af8e@epcas1p3.samsung.com>
 <20161220201049.GA18463@beast>
In-Reply-To: <20161220201049.GA18463@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-fbdev@vger.kernel.org


Hi,

On Tuesday, December 20, 2016 12:10:49 PM Kees Cook wrote:
> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, queued for 4.11.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> v2:
> - vertical columns, Bartlomiej Zolnierkiewicz
> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index 82c0a8caa9b8..93469f94c09d 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -439,9 +439,9 @@ static unsigned long lcdc_sys_read_data(void *handle)
>  }
>  
>  static struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
> -	lcdc_sys_write_index,
> -	lcdc_sys_write_data,
> -	lcdc_sys_read_data,
> +	.write_index	= lcdc_sys_write_index,
> +	.write_data	= lcdc_sys_write_data,
> +	.read_data	= lcdc_sys_read_data,
>  };
>  
>  static int sh_mobile_lcdc_sginit(struct fb_info *info,

