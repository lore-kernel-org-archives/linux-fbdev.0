From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 11 Apr 2019 15:12:51 +0000
Subject: Re: [PATCH] video: amba-clcd: Decomission Versatile and Nomadik
Message-Id: <ac93f762-f70a-3556-f70f-fcfd258aab70@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190320093355epcas4p2806447a1e70035d07b92b245f7278c34@epcas4p2.samsung.com>
 <20190320093331.11251-1-linus.walleij@linaro.org>
In-Reply-To: <20190320093331.11251-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org


On 03/20/2019 10:33 AM, Linus Walleij wrote:
> These board families are now handled in the DRM subsystem
> where we can have reusable panel drivers and some other
> stuff. The PL111 there is now the driver used in the
> defconfig for Versatile and Nomadik so no need to keep
> this code around.
> 
> There are a few minor machines in arch/arm/ such as
> mach-netx still using the old driver, so we need to keep
> the core fbdev driver around for some time.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
