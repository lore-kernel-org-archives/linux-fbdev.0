From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Aug 2012 09:21:32 +0000
Subject: Re: [rtc-linux] [PATCHv3 8/9] arm: vt8500: gpio: Devicetree support for arch-vt8500
Message-Id: <CACRpkdZnQyLSRQ6cRpFBurAv2cv44einGAsT86FLCqsj1euDMA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <1345582058-2291-9-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1345582058-2291-9-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 21, 2012 at 10:47 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Converted the existing arch-vt8500 gpio to a platform_device.
> Added support for WM8505 and WM8650 GPIO controllers.
(...)
> +       unsigned val;

I asked about the datatype for this "val", it sure isn't "unsigned".

I suspected the registers were only 8bit and so it should be u8.
But atleast use u32 if you must use all these bits.

(...)
> +       val = readl(vt8500_chip->base + vt8500_chip->regs->en);
> +       val |= BIT(offset);
> +       writel(val, vt8500_chip->base + vt8500_chip->regs->en);

BTW: have you considered [readl|writel]_relaxed?

Yours,
Linus Walleij
