From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 19 Nov 2012 23:26:51 +0000
Subject: Re: [PATCH] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <20121119152651.ed30cb7a.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352993527-9113-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1352993527-9113-2-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 15 Nov 2012 16:32:07 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> This patch adds support for the Solomon SSD1307 OLED
> controller found on the Crystalfontz CFA10036 board.
> 
> This controller can drive a display with a resolution up
> to 128x39 and can operate over I2C or SPI.
> 
> The current driver has only been tested on the CFA-10036,
> that is using this controller over I2C to driver a 96x16
> OLED screen.
>
> ...
>
> +static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
> +		size_t count, loff_t *ppos)
> +{
> +	struct ssd1307fb_par *par = info->par;
> +	unsigned long total_size;
> +	unsigned long p = *ppos;
> +	u8 __iomem *dst;
> +	int err = 0;
> +
> +	total_size = info->screen_size;
> +
> +	if (total_size = 0)
> +		total_size = info->fix.smem_len;
> +
> +	if (p > total_size)
> +		return -EFBIG;
> +
> +	if (count > total_size) {
> +		err = -EFBIG;
> +		count = total_size;
> +	}
> +
> +	if (count + p > total_size) {
> +		if (!err)
> +			err = -ENOSPC;
> +
> +		count = total_size - p;
> +	}
> +
> +	dst = (void __force *) (info->screen_base + p);
> +
> +	if (copy_from_user(dst, buf, count))
> +		err = -EFAULT;
> +
> +	if  (!err)
> +		*ppos += count;
> +
> +	ssd1307fb_update_display(par);
> +
> +	return (err) ? err : count;
> +}

There are a lot of things not to like about this function ;)

EFBIG means "file too large" and ENOSPC means "No space left on
device".  A video driver has no business returning these errors.  If
these errors occur then our poor user might end up running around
checking his disk free space and looking for huge files.  Because we
misled him.  These errors are due to invalid syscall arguments, so
how's about we tell the truth and use EINVAL?

Also, the function will under some circumstances return an error, but
it has done the write anyway!  What is userspace supposed to do?  If it
was well written it may retry the write, or report the error and
terminate.  A write() should return the number of bytes written on
success.  It's quite OK for that return value to be less than the
number of bytes the user requested, and I suggest that's what you
should do here.  Or you could just abort the write altogther and return
-EINVAL if there are any invalid arguments.

>
> ...
>
> +	par->reset = of_get_named_gpio(client->dev.of_node,
> +					 "reset-gpios", 0);

It appears that this driver will be unusable if CONFIG_OF=n, yet we
permit it to be configured on such systems.  I think it would be better
to make CONFIG_FB_SSD1307 depend on CONFIG_OF so users don't end up
compiling and bundling unusable drivers?

(otoh, there is a maintainability argument in favor of permitting a
driver to be compiled with x86 allmodconfig)

> +	if (!gpio_is_valid(par->reset)) {
> +		ret = -EINVAL;
> +		goto reset_oled_error;
> +	}
> +
>
> ...
>
> +	gpio_set_value(par->reset, 0);

A Kconfig dependency on CONFIG_GPIO might also be needed, for the same
reasons.

> +	udelay(4);
> +	gpio_set_value(par->reset, 1);
> +	udelay(4);
>
> ...
>

