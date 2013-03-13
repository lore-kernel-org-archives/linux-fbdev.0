From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 13 Mar 2013 23:15:02 +0000
Subject: Re: [PATCH v2] video: backlight: add ili922x lcd driver
Message-Id: <20130313161502.d089ea17cb695415ec9b01d8@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363178617-21940-1-git-send-email-agust@denx.de>
In-Reply-To: <1363178617-21940-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 13 Mar 2013 13:43:37 +0100 Anatolij Gustschin <agust@denx.de> wrote:

> From: Stefano Babic <sbabic@denx.de>
> 
> Add LCD driver for Ilitek ILI9221/ILI9222 controller.
> The driver uses SPI interface for controller access
> and configuration and RGB interface for graphics data
> transfer.
> 
> ...
>
> +#define START_BYTE(id, rs, rw)	\
> +	(0x70 | (((id) & 0x01) << 2) | (((rs) & 0x01) << 1) | ((rw) & 0x01))
> +#define CHECK_FREQ_REG(s, x)	\
> +	do {			\
> +		if (s->max_speed_hz > ILITEK_MAX_FREQ_REG)	\
> +			((struct spi_transfer *)x)->speed_hz =	\
> +					ILITEK_MAX_FREQ_REG;	\
> +	} while (0)
> +#define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
> +#define set_tx_byte(b)		(tx_invert ? ~(b) : b)

All of the above could have been implemented as regular old C
functions, and would be better if they were!

It otherwise all looks nice.
