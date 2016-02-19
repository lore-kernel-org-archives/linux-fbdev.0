From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Feb 2016 08:46:27 +0000
Subject: Re: [02/11] video: ARM CLCD: support DT signal inversion flags
Message-Id: <CACRpkdbGCidu_3qbTYf7WSoAhafU4Z5W0jDs4CGtH5XwSf14aA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-3-git-send-email-linus.walleij@linaro.org>
 <0cebf93a-ee0a-3637-3242-8aed266df091@broadcom.com>
In-Reply-To: <0cebf93a-ee0a-3637-3242-8aed266df091@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 17, 2016 at 7:10 PM, Ray Jui <ray.jui@broadcom.com> wrote:

> A somewhat related question, how do you see the CLKSEL bit in the TIM2
> register will be supported in the future? There are some cases where the
> CLKSEL bit needs to be set, and therefore the "CLCDCLK" instead of "HCLK"
> reference clock source is selected.

I think it's very simple:

The DT node usually looks like so:

display@10120000 {
        compatible = "arm,pl110", "arm,primecell";
(...)
        clocks = <&oscclk4>, <&pclk>;
        clock-names = "clcd", "apb_pclk";

Just add a custom attribute pointing to the
reference clock in this array:

clcd-reference-clock = <0>;

If this is set to <1> "apb_pclk" (i.e. HCLK) is
the reference, and that bit in TIM2 gets set.

Do you have a system that needs this?

Yours,
Linus Walleij
