From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 16:57:42 +0000
Subject: Re: [PATCH v2 -next] video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"
Message-Id: <bb0e51ad-eb6d-7adf-34e5-8e9959081c26@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181119013711epcas5p1a247965989728e7b28b90ca0a3947229@epcas5p1.samsung.com>
        <20181119013642.18080-1-yuehaibing@huawei.com>
In-Reply-To: <20181119013642.18080-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: daniel@zonque.org, robert.jarzmik@free.fr, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, stable@kernel.org


On 11/19/2018 02:36 AM, YueHaibing wrote:
> 'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.
> 
> This gives this error message:
>   ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data
> 
> Fixes: c8f96304ec8b4 ("video: fbdev: pxafb: switch to devm_* API")
> Cc: stable@kernel.org [v4.19+]
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Daniel Mack <daniel@zonque.org>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
