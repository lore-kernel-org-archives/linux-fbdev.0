From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 27 Jan 2017 15:27:56 +0000
Subject: Re: [PATCH v2 01/14] Documentation: dt/bindings: Document  pinctrl-ingenic
Message-Id: <08e9505d2d366557950f8e6a4e81f57a@mail.crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
 <20170122144947.16158-2-paul@crapouillou.net>
 <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com>
In-Reply-To: <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

Hi,

> So I still don't understand these properties.
> 
> Does this mean that there is a pull-up *inside* the SoC or *outside*
> on the board where it is mounted?

The pull-up resistors are inside the SoCs.

> In the former case, if this pertains to the *inside* of the SoC:
> is it just different between jz4740 and jz4780?
> In that case, just code this into the driver as .data to the 
> .compatible
> in the DT match. No special DT properties needed.

Well, I've been taught that devicetree is for describing the hardware, 
and
the driver code is for functionality. So that's why I put it in 
devicetree.

That's also the reason why I put the list of functions and groups in
devicetree and not in the driver code.

> Standard bindings use just "pins". Why the custom ingenic,
> prefix?

I can change that.

Regards,
-Paul
