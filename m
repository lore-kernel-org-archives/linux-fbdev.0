From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 12 Nov 2009 22:21:11 +0000
Subject: Re: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
Message-Id: <20091112222111.GE12308@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012p7ff6d07dv7e37433f43757647@mail.gmail.com>
	<7c34ac520911111820y5581951dya17ab06b904ff63f@mail.gmail.com>
In-Reply-To: <7c34ac520911111820y5581951dya17ab06b904ff63f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 12, 2009 at 10:20:20AM +0800, Jun Nie wrote:
> +static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int spi_gpio_cs, unsigned int spi_gpio_reset, int on)
> +{
> +	int err = 0;
> +
> +	if (on) {
> +		if (spi_gpio_reset != -1) {
> +			err = gpio_request(spi_gpio_reset, "TPO_LCD_SPI_RESET");
> +			if (err) {
> +				printk("failed to request GPIO for TPO LCD RESET\n");
> +				return -1;

Do you really mean -EPERM here?  If not, use a proper error code such as
the one you got from gpio_request().  (Never, ever, use a literal "-1" as
an error indicator in the kernel.)
