From: Marek Vasut <marek.vasut@gmail.com>
Date: Fri, 15 Jun 2018 23:29:31 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <22e2aecc-3735-8ad6-3f36-75ae2b8f2498@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <CAOMZO5DJju6oBRLakkTx4np7w9nMwPm6TMkGGYjbMLUPDUugYw@mail.gmail.com>
In-Reply-To: <CAOMZO5DJju6oBRLakkTx4np7w9nMwPm6TMkGGYjbMLUPDUugYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "marcofrk@gmail.com" <marcofrk@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>

On 06/16/2018 12:22 AM, Fabio Estevam wrote:
> On Fri, Jun 15, 2018 at 6:36 PM, Marek Vasut <marex@denx.de> wrote:
> 
>> Having two drivers in the kernel with different set of bugs is always bad.
> 
> Sure, but breaking dtb's is also bad.

You picked only the first part of my argument, the less important one ;-)

> Can the mxsfb driver be modified to handle the old style bindings?

Maybe, but do we care ? Cfr my comment about the amount of users who
will be affected by this.

> The IPU drm driver is capable of handling both the old style where the
> display timing is passed in dts and the new drm style.
> 
> For example:
> 
> arch/arm/boot/dts/imx6qdl-sabresd.dtsi uses the drm style binding
> arch/arm/boot/dts/imx6qdl-sabreauto.dtsi uses the old style of passing
> the display timings in dts
> 
> Both formats are accepted by the ipu drm driver.
> 
> Can't mxsfb drm driver support both? Then we don't need to worry about
> breaking dtb's and could safely remove the mxs fbdev driver.

This might be a way forward, but again, does it justify the effort ?
We will be adding compatibility code which we will have to maintain for
maybe a handful of users I think.

-- 
Best regards,
Marek Vasut
