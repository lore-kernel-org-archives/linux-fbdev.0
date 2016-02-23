From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Feb 2016 13:49:23 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CAFEAcA-Y7rE_9CiOphgmae3FDApRznoBS7vsVN_+9hBqvAzEEA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com>
In-Reply-To: <56CC546A.9070705@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 23 February 2016 at 12:45, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> So, true, there's probing going on, but it's all board specific,
> requiring a board specific driver to support it in the kernel. And I
> think that makes the bootloader much better place for supporting it.

This doesn't seem to me like a reason to put the requirement
in the bootloader. A huge part of the purpose of the kernel
is to support the hardware (whether that's completely generic
and probeable, like PCI, or generic but not probeable, or
completely specific to a particular board). The kernel has to
support the hardware, and just because it happens to be board
specific hardware rather than generic hardware doesn't seem to
me to imply that the kernel gets to drop part of its core purpose.

> I think one of the core questions here is: do we want to start adding
> board specific drivers to the kernel, instead of dealing with it in the
> bootloader when possible? My understanding is that we've been trying to
> reduce board specific code from the kernel.

I think there's a difference between "reduce board specific code
in the kernel by replacing it with the combination of generic
or parameterisable code in the kernel plus a kernel data structure
(DT) that supplies the parameterisation needed", and "reduce
board specific code in the kernel by forcing the bootloader to
do the kernel's job for it".

thanks
-- PMM
