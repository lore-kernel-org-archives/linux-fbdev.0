From: Rob Herring <robh@kernel.org>
Date: Fri, 03 Mar 2017 06:21:30 +0000
Subject: Re: [PATCH v2] video: fbdev: imxfb: support AUS mode
Message-Id: <20170303062130.eu5i6kcusxuodoea@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
 <1488312337-32154-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1488312337-32154-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Kaiser <martin@kaiser.cx>
Cc: linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Sascha Hauer <kernel@pengutronix.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 28, 2017 at 09:04:16PM +0100, Martin Kaiser wrote:
> Some displays require setting AUS mode in the LDCD AUS Mode Control
> Register to work with the imxfb driver. Like the value of the Panel
> Configuration Register, the AUS Mode Control Register's value depends on
> the display mode.
> 
> Allow setting this register from the device tree. Make the device tree
> node optional to keep the DT ABI stable. This register is available only
> on imx21 and compatible chipsets. Update the device tree bindings with
> this info.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>   re-sending DT bindings and code changes as one patch

The opposite is what is prefered.

> 
>  .../devicetree/bindings/display/imx/fsl,imx-fb.txt    |  2 ++
>  drivers/video/fbdev/imxfb.c                           | 19 +++++++++++++++++++
>  include/linux/platform_data/video-imxfb.h             |  1 +
>  3 files changed, 22 insertions(+)
