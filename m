From: Marek Vasut <marex@denx.de>
Date: Thu, 18 Apr 2013 14:00:27 +0000
Subject: Re: [PATCH] video: mxsfb: Fix colors display on lower color depth
Message-Id: <201304181600.27813.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <516EBCA4.1020609@free-electrons.com>
 <1366277032-671-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1366277032-671-1-git-send-email-maxime.ripard@free-electrons.com>
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

Isn't this what M28EVK is doing already? This was last tested on 3.9-rc3 I 
think:

bits-per-pixel = <16>;
bus-width = <18>;

But it's also true we have all 24 data lines routed to the LCD.

Best regards,
Marek Vasut
