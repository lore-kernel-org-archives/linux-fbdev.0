From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 18 Jun 2020 08:43:23 +0000
Subject: Re: [PATCH 4/6] video: backlight: tosa_lcd: convert to use i2c_new_client_device()
Message-Id: <20200618084323.GB954398@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
 <20200615075816.2848-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200615075816.2848-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Mon, 15 Jun 2020, Wolfram Sang wrote:

> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> 
> I'd like to push it via I2C for 5.8-rc2.

Go for it:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
