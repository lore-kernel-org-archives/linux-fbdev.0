From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 03 Apr 2019 10:10:18 +0000
Subject: Re: [PATCH v2 2/2] video: lcd: Remove useless BACKLIGHT_CLASS_DEVICE dependencies
Message-Id: <20190403101018.GN11301@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
 <20190117133336.19737-2-shc_work@mail.ru>
In-Reply-To: <20190117133336.19737-2-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, 17 Jan 2019, Alexander Shiyan wrote:

> This patch removes dependencies on BACKLIGHT_CLASS_DEVICE for items
> that are already placed under #if BACKLIGHT_CLASS_DEVICE.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/video/backlight/Kconfig | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Will fix up Daniel's nit about the #if.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
