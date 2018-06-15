From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Jun 2018 19:47:48 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
In-Reply-To: <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leonard Crestez <leonard.crestez@nxp.com>, Stefan Agner <stefan@agner.ch>
Cc: Marek Vasut <marex@denx.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Marco Franchi <marcofrk@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>

Hi Leonard,

On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The FBDEV driver uses the same name and both can't be registered at the
> same time. Fix this by renaming the drm driver to mxsfb-drm
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Stefan sent the same patch a few days ago:
https://www.spinics.net/lists/dri-devel/msg179489.html
