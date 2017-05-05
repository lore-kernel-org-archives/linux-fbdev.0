From: Rob Herring <robh@kernel.org>
Date: Fri, 05 May 2017 19:57:24 +0000
Subject: Re: [PATCH v5 02/14] dt/bindings: Document gpio-ingenic
Message-Id: <20170505195724.mph4uov3vd52hscm@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-3-paul@crapouillou.net>
In-Reply-To: <20170428200824.10906-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Apr 28, 2017 at 10:08:12PM +0200, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bindings of the
> gpio-ingenic driver, which handles GPIOs of the Ingenic SoCs
> currently supported by the Linux kernel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/gpio/ingenic,gpio.txt      | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> 
>  v2: New patch
>  v3: No changes
>  v4: Update for the v4 version of the gpio-ingenic driver
>  v5: Remove gpio-bank-... compatible strings, and add 'reg' property

Acked-by: Rob Herring <robh@kernel.org>
