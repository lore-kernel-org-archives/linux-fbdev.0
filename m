From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 17 Apr 2020 10:14:46 +0000
Subject: Re: [PATCH 1/1] video: backlight: tosa_lcd: convert to use i2c_new_client_device()
Message-Id: <20200417101446.GB3737@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200326210959.13111-1-wsa+renesas@sang-engineering.com>
 <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200326210959.13111-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Thu, 26 Mar 2020, Wolfram Sang wrote:

> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/video/backlight/tosa_lcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
