From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 29 Apr 2020 12:25:38 +0000
Subject: Re: [PATCH] video: fbdev: pxa3xx_gcu: Fix some resource leak in an error handling path in 'pxa3xx_gc
Message-Id: <20200429122538.GO2014@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200429043438.96212-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200429043438.96212-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-fbdev@vger.kernel.org, eric.y.miao@gmail.com, arnd@arndb.de, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, zhenzhong.duan@gmail.com, daniel@caiaq.de, mpe@ellerman.id.au, tglx@linutronix.de

On Wed, Apr 29, 2020 at 06:34:38AM +0200, Christophe JAILLET wrote:
> If an error occurs in the loop where we call 'pxa3xx_gcu_add_buffer()',
> any resource already allocated should be freed.
> 
> In order to fix it, add a call to 'pxa3xx_gcu_free_buffers()' in the error
> handling path, as already done in the remove function.
> 
> Fixes: 364dbdf3b6c3 ("video: add driver for PXA3xx 2D graphics accelerator")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/fbdev/pxa3xx-gcu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> index 4279e13a3b58..68d9c7a681d4 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -675,6 +675,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
>  
>  err_disable_clk:
>  	clk_disable_unprepare(priv->clk);
> +	pxa3xx_gcu_free_buffers(dev, priv);

The error handling in this function makes no sense and is buggy.  It
should be that it unwinds in the reverse order from the allocation.  The
goto should be "goto free_most_recently_allocated_resource;".  Since the
unwind is done in the wrong order it causes a couple bugs.

These buffers are the last thing which we allocated so they should be
the first thing which we free.  In this case, calling
pxa3xx_gcu_free_buffers() before the buffers are allocated is confusing
but harmless.  The clk_disable_unprepare() is done on some paths where
the clock was not enabled and that will trigger a WARN() so that's a
bug.  Syzcaller will complain and if you have reboot on WARN then it's
annoying.

The second bug is that we don't deregister the misc device or release
the DMA memory on failure when we allocate the buffers in the loop.

regards,
dan carpenter
