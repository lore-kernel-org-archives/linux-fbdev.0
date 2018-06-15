From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Jun 2018 21:05:50 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <CAOMZO5BnOpaCzK1Sq=CUPaO6Yh8bE6v=8dmN5pxTKpwqjM1Qfw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
In-Reply-To: <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "marex@denx.de" <marex@denx.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "marcofrk@gmail.com" <marcofrk@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 15, 2018 at 5:58 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> In that thread there is a proposal for removing the old fbdev/mxsfb
> driver entirely.
>
> That would break old DTBs, isn't this generally considered bad? Also,
> are we sure the removal of fbdev/mxsfb wouldn't lose any features?

Yes, I also think we should not break old dtb's.

> What my series does is make both drivers work with the same kernel
> image and turns the choice into a board-level dtb decision. Supporting
> everything at once seems desirable to me and it allows for a very
> smooth upgrade path.
>
> The old driver could be removed later, after all users are converted.

Agreed.

Maybe the mxs fbdev driver needs to warn users saying that that the
driver is deprecated and the bindings need to be updated to the DRM
bindings style.
