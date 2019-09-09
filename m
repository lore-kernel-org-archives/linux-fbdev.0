From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2019 09:56:25 +0000
Subject: Re: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
Message-Id: <20190909095625.GB17624@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190909012605.15051-1-srrmvlt@gmail.com>
In-Reply-To: <20190909012605.15051-1-srrmvlt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sreeram Veluthakkal <srrmvlt@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, payal.s.kshirsagar.98@gmail.com

On Sun, Sep 08, 2019 at 08:26:05PM -0500, Sreeram Veluthakkal wrote:
> This patch fixes the issue:
> FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> +       udelay(20);
> 
> Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>
> ---
>  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> index eeeeec97ad27..2dece71fd3b5 100644
> --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
>  	dev_dbg(par->info->device, "%s()\n", __func__);
>  
>  	gpiod_set_value(par->gpio.reset, 0);
> -	udelay(20);
> +	usleep_range(20, 40);

Is it "safe" to wait 40?  This kind of change you can only do if you
know this is correct.  Have you tested this with hardware?

thanks,

greg k-h
