From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Dec 2016 13:11:33 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: use designated initializers
Message-Id: <4605973.6cdfMDcWfH@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161217010203.GA140420@beast>
In-Reply-To: <20161217010203.GA140420@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


Hi,

On Friday, December 16, 2016 05:02:03 PM Kees Cook wrote:
> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

I have same request as Ingo for x86/floppy patch:

please align the two columns vertically while at it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index 82c0a8caa9b8..42499a1afa07 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -439,9 +439,9 @@ static unsigned long lcdc_sys_read_data(void *handle)
>  }
>  
>  static struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
> -	lcdc_sys_write_index,
> -	lcdc_sys_write_data,
> -	lcdc_sys_read_data,
> +	.write_index = lcdc_sys_write_index,
> +	.write_data = lcdc_sys_write_data,
> +	.read_data = lcdc_sys_read_data,
>  };
>  
>  static int sh_mobile_lcdc_sginit(struct fb_info *info,

