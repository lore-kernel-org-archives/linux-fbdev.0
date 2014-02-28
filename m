From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Feb 2014 19:31:46 +0000
Subject: Re: [PATCH 2/3] imx-drm: ipu-dc: Use usleep_range instead of msleep
Message-Id: <20140228193146.GY21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393328624-28013-3-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1393328624-28013-3-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Feb 25, 2014 at 12:43:42PM +0100, Philipp Zabel wrote:
> Since msleep(2) can sleep up to 20ms anyway, make this explicit by using
> usleep_range(2000, 20000).
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/staging/imx-drm/ipu-v3/ipu-dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> index d0e3bc3..d5de8bb 100644
> --- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> +++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> @@ -262,7 +262,7 @@ void ipu_dc_disable_channel(struct ipu_dc *dc)
>  
>  	/* Wait for DC triple buffer to empty */
>  	while ((readl(priv->dc_reg + DC_STAT) & val) != val) {
> -		msleep(2);
> +		usleep_range(2000, 20000);
>  		timeout -= 2;
>  		if (timeout <= 0)
>  			break;

Umm, something which Greg may have missed.

timeout is 50.  It gets decremented by two each time around this loop,
so we could end up waiting between 100ms and 1s here, yes?  The exact
delay here would depend on the kernel HZ value (which is configurable,
up to 1kHz.)

So... we're using a sleeping function here (msleep or usleep_range),
and so interrupts can't be disabled here, nor can spinlocks be held,
so I'm left wondering why the code doesn't do:

	timeout = jiffies + msecs_to_jiffies(100);
	do {
		if (readl(priv->dc_reg + DC_STAT) & val) = val)
			break;
		usleep_range(2000, 20000);
	} while (time_is_after_jiffies(timeout));

here.  (Note that whether we succeed or timeout appears to have no
effect on the following code.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
