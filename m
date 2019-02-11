From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 11 Feb 2019 10:22:15 +0000
Subject: Re: [PATCH v2 2/2] video: lcd: Remove useless BACKLIGHT_CLASS_DEVICE dependencies
Message-Id: <20190211102215.pou72sfjmyc5ar6v@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
 <CGME20190117133426epcas3p2f42a17f65cc8e9ab350090310b8c66b5@epcas3p2.samsung.com>
 <20190117133336.19737-2-shc_work@mail.ru>
 <97b6dc7d-ef89-e417-cccb-094ec53a4bdf@samsung.com>
In-Reply-To: <97b6dc7d-ef89-e417-cccb-094ec53a4bdf@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org, Alexander Shiyan <shc_work@mail.ru>

On Fri, Feb 08, 2019 at 06:20:14PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> On 01/17/2019 02:33 PM, Alexander Shiyan wrote:
> > This patch removes dependencies on BACKLIGHT_CLASS_DEVICE for items
> > that are already placed under #if BACKLIGHT_CLASS_DEVICE.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Sorry... looks like I sent neither an ack nor a nitpick about the #if
(#if is no more part of Kconfig syntax than #ifdef was).

However patch is perfectly clear so:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
