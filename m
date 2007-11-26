From: =?ISO-8859-15?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add missing code to support
	palette formats
Date: Mon, 26 Nov 2007 14:58:57 +0100
Message-ID: <20071126145857.765e625a@dilbert.local>
References: <20071123122616.30bd242c@bluebox.local>
	<f17812d70711240028l295887asfc7ffeedaf9809c4@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IweUl-0007VU-Cj for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 05:59:31 -0800
Received: from www.tglx.de ([62.245.132.106])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IweUi-0006Tr-Nt
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 05:59:31 -0800
In-Reply-To: <f17812d70711240028l295887asfc7ffeedaf9809c4@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Am Sat, 24 Nov 2007 16:28:55 +0800
schrieb "eric miao" <eric.y.miao@gmail.com>:

> On Nov 23, 2007 7:26 PM, Hans J. Koch <hjk@linutronix.de> wrote:
> > Subject: pxafb: Add missing code to support palette formats
> > Date: Fri, 23 Nov 2007 10:33:24 +0100
> > From: Hans J Koch <hjk@linutronix.de>
> >
> > A few lines of code are missing to support different palette
> > formats in pxafb. This patch adds them, code was tested on PXA270.
> >
> > Signed-off-by: Hans J Koch <hjk@linutronix.de>
> >
> > ---
> >  drivers/video/pxafb.c |   12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > Index: linux-2.6.24-rc/drivers/video/pxafb.c
> > ===================================================================
> > --- linux-2.6.24-rc.orig/drivers/video/pxafb.c  2007-11-22
> > 23:03:28.000000000 +0100 +++
> > linux-2.6.24-rc/drivers/video/pxafb.c   2007-11-22
> > 23:43:07.000000000 +0100 @@ -745,8 +745,14 @@ fbi->reg_lccr1 =
> > new_regs.lccr1; fbi->reg_lccr2 = new_regs.lccr2;
> >         fbi->reg_lccr3 = new_regs.lccr3;
> > -       fbi->reg_lccr4 = LCCR4 & (~LCCR4_PAL_FOR_MASK);
> > -       fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
> > +
> > +       if (((read_cpuid(CPUID_ID) >> 4) & 0x1f) == 0x11) {
> > +               /* PXA 27x only */
> > +               fbi->reg_lccr4 = LCCR4 & (~LCCR4_PAL_FOR_MASK);
> > +               fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
> > +       } else
> > +               fbi->reg_lccr4 = 0;
> > +
> 
> I don't see what's wrong with the original code. Can you explain this
> a bit more?

The patch fixes two problems:

1. Register LCCR4 exists on PXA27x only.
2. The original code never writes to LCCR4. It sets fbi->reg_lccr4 only.


> 
> And there are already cpu_is_pxa27x() and friends in the kernel, so
> use those instead of your own please.

Right.

Thanks for your hints, Eric! Here's an updated version:

Subject: pxafb: Add missing code to support palette formats
Date: Fri, 23 Nov 2007 10:33:24 +0100
From: Hans J Koch <hjk@linutronix.de>

A few lines of code are missing to support different palette formats in pxafb.
This patch adds them, code was tested on PXA270.

Signed-off-by: Hans J Koch <hjk@linutronix.de>

---
 drivers/video/pxafb.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6.24-rc/drivers/video/pxafb.c
===================================================================
--- linux-2.6.24-rc.orig/drivers/video/pxafb.c	2007-11-22 23:03:28.000000000 +0100
+++ linux-2.6.24-rc/drivers/video/pxafb.c	2007-11-26 14:46:34.000000000 +0100
@@ -745,8 +745,13 @@
 	fbi->reg_lccr1 = new_regs.lccr1;
 	fbi->reg_lccr2 = new_regs.lccr2;
 	fbi->reg_lccr3 = new_regs.lccr3;
-	fbi->reg_lccr4 = LCCR4 & (~LCCR4_PAL_FOR_MASK);
-	fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
+
+	if (cpu_is_pxa27x()) {
+		fbi->reg_lccr4 = LCCR4 & (~LCCR4_PAL_FOR_MASK);
+		fbi->reg_lccr4 |= (fbi->lccr4 & LCCR4_PAL_FOR_MASK);
+	} else
+		fbi->reg_lccr4 = 0;
+
 	set_hsync_time(fbi, pcd);
 	local_irq_restore(flags);
 
@@ -838,6 +843,8 @@
 	clk_enable(fbi->clk);
 
 	/* Sequence from 11.7.10 */
+	if (cpu_is_pxa27x())
+		LCCR4 = fbi->reg_lccr4;
 	LCCR3 = fbi->reg_lccr3;
 	LCCR2 = fbi->reg_lccr2;
 	LCCR1 = fbi->reg_lccr1;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
