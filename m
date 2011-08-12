From: Greg KH <gregkh@suse.de>
Date: Fri, 12 Aug 2011 15:56:02 +0000
Subject: Re: [PATCH] Add support for SMSC UFX6000/7000 USB display adapters
Message-Id: <20110812155602.GA11273@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1313150823-2527-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Aug 12, 2011 at 01:07:03PM +0100, Steve Glendinning wrote:
> This patch adds framebuffer suport for SMSC's UFX6000 (USB 2.0) and
> UFX7000 (USB 3.0) display adapters.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>

Very nice job, I only have one very minor suggestion for this code from
a USB/driver core standpoint (I can't verify that the framebuffer api is
being used properly as I don't know that at all.):

> +/* sets analog bit PLL configuration values */
> +static int ufx_config_pix_clk(struct ufx_data *dev, u32 pixclock)
> +{
> +	struct pll_values asic_pll = {0};
> +	u32 value, clk_pixel, clk_pixel_pll;
> +	int status;
> +
> +	/* convert pixclock (in ps) to frequency (in Hz) */
> +	clk_pixel = PICOS2KHZ(pixclock) * 1000;
> +	pr_info("pixclock %d ps = clk_pixel %d Hz", pixclock, clk_pixel);

Use call pr_info() a bunch, (especially in your probe() call chain)
which will get noisy in the kernel log.  How about using dev_dbg()
instead, which allows you to dynamically turn on/off messages like this,
and it provides the needed information so that the reader of the
messages can tell exactly which device is sending the messages (very
helpful when you attach more than one.)

You can do the same for your calls to pr_debug() and other pr_* calls.
If you note in the header file for those functions, it suggests that
drivers should always call the dev_* versions instead of teh "raw" pr_*
functions, as you do have access to a struct device within your driver.

thanks,

greg k-h
