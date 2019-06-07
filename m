From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Jun 2019 12:33:12 +0000
Subject: Re: [PATCH] video: fbdev: cyber2000fb: remove superfluous CONFIG_PCI ifdef
Message-Id: <2bacb06a-eb78-50fa-3e11-76ce20d89d6b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <214f05e0-a448-b1cf-7475-4fa7eeaa9949@samsung.com>
        <CGME20190607123310eucas1p17702bc47693555b2e3d4354c2d997d03@eucas1p1.samsung.com>
In-Reply-To: <214f05e0-a448-b1cf-7475-4fa7eeaa9949@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 5/21/19 3:44 PM, Bartlomiej Zolnierkiewicz wrote:
> This is a PCI driver and FB_CYBER2000 depends on PCI in Kconfig so
> there is no need to check for PCI inside the driver code.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
