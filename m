From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH] pxafb: Add missing code to support palette formats
Date: Sat, 24 Nov 2007 16:28:55 +0800
Message-ID: <f17812d70711240028l295887asfc7ffeedaf9809c4@mail.gmail.com>
References: <20071123122616.30bd242c@bluebox.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20071123122616.30bd242c@bluebox.local>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
To: "Hans J. Koch" <hjk@linutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Nov 23, 2007 7:26 PM, Hans J. Koch <hjk@linutronix.de> wrote:
> Subject: pxafb: Add missing code to support palette formats
> Date: Fri, 23 Nov 2007 10:33:24 +0100
> From: Hans J Koch <hjk@linutronix.de>
>
> A few lines of code are missing to support different palette formats in
> pxafb. This patch adds them, code was tested on PXA270.
>
> Signed-off-by: Hans J Koch <hjk@linutronix.de>
>
> ---
>  drivers/video/pxafb.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> Index: linux-2.6.24-rc/drivers/video/pxafb.c
> ===================================================================
> --- linux-2.6.24-rc.orig/drivers/video/pxafb.c  2007-11-22
> 23:03:28.000000000 +0100 +++
> linux-2.6.24-rc/drivers/video/pxafb.c   2007-11-22
> 23:43:07.000000000 +0100 @@ -745,8 +745,14 @@ fbi->reg_lccr1 =
> new_regs.lccr1; fbi->reg_lccr2 = new_regs.lccr2;
>         fbi->reg_lccr3 = new_regs.lccr3;
> -       fbi->reg_lccr4 = LCCR4 & (~LCCR4_PAL_FOR_MASK);
> -       fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
> +
> +       if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) == 0x11) {
> +               /* PXA 27x only */
> +               fbi->reg_lccr4 = LCCR4 & (~LCCR4_PAL_FOR_MASK);
> +               fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
> +       } else
> +               fbi->reg_lccr4 = 0;
> +

I don't see what's wrong with the original code. Can you explain this
a bit more?

And there are already cpu_is_pxa27x() and friends in the kernel, so
use those instead of your own please.

>         set_hsync_time(fbi, pcd);
>         local_irq_restore(flags);
>
> @@ -838,6 +844,8 @@
>         clk_enable(fbi->clk);
>
>         /* Sequence from 11.7.10 */
> +       if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) == 0x11)
> +               LCCR4 = fbi->reg_lccr4; /* PXA 27x only */
>         LCCR3 = fbi->reg_lccr3;
>         LCCR2 = fbi->reg_lccr2;
>         LCCR1 = fbi->reg_lccr1;
>

Ditto.

> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>

-- 
Cheers
- eric

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
