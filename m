From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 02 Sep 2019 09:06:46 +0000
Subject: Re: [PATCH] video: backlight: tosa_lcd: drop check because i2c_unregister_device() is NULL safe
Message-Id: <20190902090646.GE32232@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On Tue, 20 Aug 2019, Wolfram Sang wrote:

> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/video/backlight/tosa_lcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
