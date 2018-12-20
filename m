From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 16:55:19 +0000
Subject: Re: [PATCH -next] video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"
Message-Id: <a24ef622-d811-dd6e-450f-a75bf4392215@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181116110325epcas4p1a18c4e9d98ede25027bc198065d988dd@epcas4p1.samsung.com>
        <20181116110255.19736-1-yuehaibing@huawei.com>
In-Reply-To: <20181116110255.19736-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: daniel@zonque.org, robert.jarzmik@free.fr, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


On 11/16/2018 12:02 PM, YueHaibing wrote:
> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
> 
> This gives this error message:
>   ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
