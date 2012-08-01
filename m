From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 01 Aug 2012 05:24:26 +0000
Subject: Re: [PATCH 1/4] video: Add support for the Solomon SSD1307 OLED Controller
Message-Id: <20120801052424.GD1672@S2100-06.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343730576-20494-1-git-send-email-maxime.ripard@free-electrons.com>
 <1343730576-20494-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1343730576-20494-2-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 31, 2012 at 12:29:33PM +0200, Maxime Ripard wrote:
> +Optional properties:
> +  - oled-reset-active-low: Is the reset gpio is active on physical low?

You may want to take a look at commit c1cb438 (bindings: update imx and
mxs #gpio-cells) which got merged recently.  In case the driver will
only work on mxs, this optional property can just be dropped.

Regards,
Shawn

