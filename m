From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 02 Sep 2019 08:40:24 +0000
Subject: Re: [PATCH resend] video: backlight: Drop default m for {LCD,BACKLIGHT_CLASS_DEVICE}
Message-Id: <20190902084024.GR4804@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190813115853.30329-1-geert@linux-m68k.org>
In-Reply-To: <20190813115853.30329-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Geert Uytterhoeven wrote:

> When running "make oldconfig" on a .config where
> CONFIG_BACKLIGHT_LCD_SUPPORT is not set, two new config options
> ("Lowlevel LCD controls" and "Lowlevel Backlight controls") appear, both
> defaulting to "m".
> 
> Drop the "default m", as options should default to disabled, and because
> several driver config options already select LCD_CLASS_DEVICE or
> BACKLIGHT_CLASS_DEVICE when needed.
> 
> Fixes: 8c5dc8d9f19c7992 ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/backlight/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
