From: Marek Vasut <marex@denx.de>
Date: Mon, 22 Apr 2013 09:16:17 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: Fix colors display on lower color depth
Message-Id: <201304221116.18080.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366618310-7068-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Dear Maxime Ripard,

> The current code always registers as a 32 bits display, and uses the
> hardware to drop the MSB of each color to abjust to the interface width
> used by the panel.
> 
> This results on 18 bits (and probably 16 bits display as well) in colors
> being displayed poorly, because the MSB are obviously the most important
> bits for each color definition.
> 
> The default controller behaviour when using an interface width smaller
> than the color depth is to drop the LSBs of each color, which makes more
> sense because you lose the least important part of the color definition.
> 
> So, to fix the colors display, just get back to the default controller
> behaviour.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Did you receive my latest email? Check M28EVK (imx28-m28evk.dts), it uses 18bit 
LCD and works without this patch I think.

Best regards,
Marek Vasut
