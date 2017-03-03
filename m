From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Mar 2017 08:53:29 +0000
Subject: Re: [PATCH v2] video: fbdev: imxfb: support AUS mode
Message-Id: <4163470.X1j77etRtO@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
 <CGME20170303062135epcas4p378b4158904ba20a06ea308331dca05ec@epcas4p3.samsung.com>
 <20170303062130.eu5i6kcusxuodoea@rob-hp-laptop>
In-Reply-To: <20170303062130.eu5i6kcusxuodoea@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Martin Kaiser <martin@kaiser.cx>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday, March 03, 2017 12:21:30 AM Rob Herring wrote:
> On Tue, Feb 28, 2017 at 09:04:16PM +0100, Martin Kaiser wrote:
> > Some displays require setting AUS mode in the LDCD AUS Mode Control
> > Register to work with the imxfb driver. Like the value of the Panel
> > Configuration Register, the AUS Mode Control Register's value depends on
> > the display mode.
> > 
> > Allow setting this register from the device tree. Make the device tree
> > node optional to keep the DT ABI stable. This register is available only
> > on imx21 and compatible chipsets. Update the device tree bindings with
> > this info.
> > 
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> > v2:
> >   re-sending DT bindings and code changes as one patch
> 
> The opposite is what is prefered.

Do you mean that you want to have code adding bindings
and its documentation in separate patches (because that
is like it was before)?  This doesn't sound good for me
from kernel changes integrity POV but if this is what
you prefer I can live with that. ;)

> >  .../devicetree/bindings/display/imx/fsl,imx-fb.txt    |  2 ++
> >  drivers/video/fbdev/imxfb.c                           | 19 +++++++++++++++++++
> >  include/linux/platform_data/video-imxfb.h             |  1 +
> >  3 files changed, 22 insertions(+)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

