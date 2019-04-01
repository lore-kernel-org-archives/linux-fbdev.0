From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 11:44:15 +0000
Subject: Re: [PATCH] fbdev: mxsfb: implement FB_PRE_INIT_FB option
Message-Id: <b2cae305-77e8-9209-d144-5db7b19be3d6@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190206101522epcas5p34bb82638cabf533f54e4b64cbbfc286e@epcas5p3.samsung.com>
        <20190206101444.26594-1-martin.kepplinger@ginzinger.com>
In-Reply-To: <20190206101444.26594-1-martin.kepplinger@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Melchior Franz <melchior.franz@ginzinger.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>


On 02/06/2019 11:14 AM, Martin Kepplinger wrote:
> From: Melchior Franz <melchior.franz@ginzinger.com>
> 
> The FB_PRE_INIT_FB option keeps the kernel from reinitializing the display
> and prevents flickering during the transition from a bootloader splash
> screen to the kernel logo screen.
> 
> Make this option available for the mxsfb driver.
> 
> Signed-off-by: Melchior Franz <melchior.franz@ginzinger.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
