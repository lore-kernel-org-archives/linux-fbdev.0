From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 16 Apr 2018 14:42:43 +0000
Subject: Re: [PATCHv4 07/10] mfd: ti-lmu: register one backlight device per channel
Message-Id: <20180416144243.3xslyuzgbfz7dc2j@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-8-sebastian.reichel@collabora.co.uk>
In-Reply-To: <20180330172414.26575-8-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> All LMU devices support multiple channels, that can be controlled
> independently. This registers one backlight sub-device per channel.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/ti-lmu.c       | 62 +++++++++++++++++++++++++++++++++++++---------
>  include/linux/mfd/ti-lmu.h |  4 +++
>  2 files changed, 54 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
> index f43b8acc30e1..f4311d215dfa 100644
> --- a/drivers/mfd/ti-lmu.c
> +++ b/drivers/mfd/ti-lmu.c
> @@ -56,8 +56,16 @@ static void ti_lmu_disable_hw(void *data)
>  
>  static const struct mfd_cell lm3532_devices[] = {
>  	{
> -		.name          = "ti-lmu-backlight",
> -		.id            = LM3532,
> +		.name          = "ti-lmu-led-backlight",
> +		.id            = 0,

What's the reason for you manually setting .id?

> +	},
> +	{
> +		.name          = "ti-lmu-led-backlight",
> +		.id            = 1,
> +	},
> +	{
> +		.name          = "ti-lmu-led-backlight",
> +		.id            = 2,
>  	},
>  };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
