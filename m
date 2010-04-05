From: James Simmons <jsimmons@infradead.org>
Date: Mon, 05 Apr 2010 14:04:43 +0000
Subject: Re: [PATCH 23/24] video/matrox: fix dangling pointers
Message-Id: <alpine.LFD.2.00.1004051504200.16108@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-24-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1269094385-16114-24-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Petr Vandrovec <vandrove-hnqZr3NxcozrBKCeMvbIDA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>


On Sat, 20 Mar 2010, Wolfram Sang wrote:

> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the structure
> was freed already.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
> ---

Acked-by: James Simmons <jsimmons@infradead.org>
 
> Found using coccinelle, then reviewed. Full patchset is available via
> kernel-janitors, linux-i2c, and LKML.
> ---
>  drivers/video/matrox/matroxfb_maven.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
> index 91af915..e7b0ec3 100644
> --- a/drivers/video/matrox/matroxfb_maven.c
> +++ b/drivers/video/matrox/matroxfb_maven.c
> @@ -1254,6 +1254,7 @@ static int maven_probe(struct i2c_client *client,
>  		goto ERROR4;
>  	return 0;
>  ERROR4:;
> +	i2c_set_clientdata(client, NULL);
>  	kfree(data);
>  ERROR0:;
>  	return err;
> -- 
> 1.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
