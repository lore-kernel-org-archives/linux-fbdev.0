From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 26 Jan 2015 12:59:05 +0000
Subject: Re: [PATCH] video: treat signal like timeout as failure
Message-Id: <20150126125905.GI26493@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
In-Reply-To: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 20, 2015 at 06:23:50AM +0100, Nicholas Mc Guire wrote:
> if(!wait_for_completion_interruptible_timeout(...))
> only handles the timeout case - this patch adds handling the
> signal case the same as timeout and cleans up.
> 
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
> 
> Only the timeout case was being handled, return of 0 in 
> wait_for_completion_interruptible_timeout, the signal case (-ERESTARTSYS)
> was treated just like the case of successful completion, which is most 
> likely not reasonable.
> 
> Note that exynos_mipi_dsi_wr_data/exynos_mipi_dsi_rd_data return values
> are not checked at the call sites in s6e8ax0.c (cmd_read/cmd_write)!
> 
> This patch simply treats the signal case the same way as the timeout case,
> by releasing locks and returning 0 - which might not be the right thing to
> do - this needs a review by someone knowing the details of this driver.
> 
> Patch is against 3.19.0-rc5 -next-20150119
> 
> Patch was only compile-tested with exynos_defconfig
> 
>  drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
> index 2358a2f..55a7a45 100644
> --- a/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
> +++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi_common.c
> @@ -157,6 +157,7 @@ int exynos_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
>  	const unsigned char *data0, unsigned int data_size)
>  {
>  	unsigned int check_rx_ack = 0;
> +	long timeout;
>  
>  	if (dsim->state = DSIM_STATE_ULPS) {
>  		dev_err(dsim->dev, "state is ULPS.\n");
> @@ -244,9 +245,11 @@ int exynos_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
>  		exynos_mipi_dsi_wr_tx_header(dsim, data_id, data_size & 0xff,
>  			(data_size & 0xff00) >> 8);
>  
> -		if (!wait_for_completion_interruptible_timeout(&dsim_wr_comp,
> -							MIPI_FIFO_TIMEOUT)) {
> -			dev_warn(dsim->dev, "command write timeout.\n");
> +		timeout = wait_for_completion_interruptible_timeout(
> +					&dsim_wr_comp, MIPI_FIFO_TIMEOUT);
> +		if (timeout <= 0) {
> +			dev_warn(dsim->dev,
> +				"command write timed-out/interrupted.\n");

This is really silly.  Let's say that the program which results in
this function called is using signals (eg, alarm() with SIGALRM, or
asynchronous IO with SIGIO, etc).

Why should having a SIGALRM raised print a kernel message?  If this
happens a lot, it will result in the kernel log being flooded with
these messages.

Signals should not be seen as exceptional conditions.  For some programs,
they are merely asynchronous events which are a normal part of the
programs operation (eg, SIGIO, SIGALRM, etc.)

Please, if you are going to handle signals, then handle them properly.
If you're not going to handle them properly, don't use a wait that
caters for them - use wait_for_completion_killable_timeout() which
doesn't finish waiting on a signal unless the signal is going to result
in the death of the program.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
