From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 11 Apr 2019 17:18:50 +0000
Subject: Re: [PATCH -next] fbdev: mxsfb: remove set but not used variable 'line_count'
Message-Id: <4d27a641-b5a7-fcdc-ec24-fcfc77c5f6dc@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190403071310epcas5p27253455539df3e8728d6fe7cb9d7aef9@epcas5p2.samsung.com>
 <20190403072425.42902-1-yuehaibing@huawei.com>
In-Reply-To: <20190403072425.42902-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, Melchior Franz <melchior.franz@ginzinger.com>, Shawn Guo <shawnguo@kernel.org>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org


On 04/03/2019 09:24 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/mxsfb.c: In function 'mxsfb_restore_mode':
> drivers/video/fbdev/mxsfb.c:633:11: warning:
>  variable 'line_count' set but not used [-Wunused-but-set-variable]
> 
> It's never used since introduction in commit f0a523b5e5e2 ("video: Add i.MX23/28
> framebuffer driver") and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for v5.2 with minor change in the patch summary
("video: fbdev: mxsfb: remove set but not used variable 'line_count'"),
thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
