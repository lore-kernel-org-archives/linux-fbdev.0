From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Date: Tue, 28 Mar 2017 17:25:59 +0000
Subject: Re: [PATCH] video: ARM CLCD: fix dma allocation size
Message-Id: <1490721959.24147.3.camel@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170308145805.1325-1-slemieux.tyco@gmail.com>
In-Reply-To: <20170308145805.1325-1-slemieux.tyco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ping

On Wed, 2017-03-08 at 09:58 -0500, Sylvain Lemieux wrote:
> From: Liam Beguin <lbeguin@tycoint.com>
> 
> This patch forces the frambuffer size to be aligned on kernel pages.
> 
> During the board startup, the splash screed did appear;
> the "ts_test" program or our application were not able to start.
> 
> The following error message was reported:
> error: failed to map framebuffer device to memory.
> LinuxFB: driver cannot connect
> 
> The issue was discovered, on the LPC32xx platform, during the migration
> of the LCD definition from the board file to the device tree.
> 
> Signed-off-by: Liam Beguin <lbeguin@tycoint.com>
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
>  drivers/video/fbdev/amba-clcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
> index 0fab92c62828..ffc2c33c6cef 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -881,8 +881,8 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
>  	if (err)
>  		return err;
>  
> -	framesize = fb->panel->mode.xres * fb->panel->mode.yres *
> -			fb->panel->bpp / 8;
> +	framesize = PAGE_ALIGN(fb->panel->mode.xres * fb->panel->mode.yres *
> +			fb->panel->bpp / 8);
>  	fb->fb.screen_base = dma_alloc_coherent(&fb->dev->dev, framesize,
>  			&dma, GFP_KERNEL);
>  	if (!fb->fb.screen_base)


