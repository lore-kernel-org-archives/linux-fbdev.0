From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2 v2] Driver for Freescale 8610
	and 5121 DIU
Date: Fri, 21 Mar 2008 11:12:28 -0700
Message-ID: <20080321111228.95a7d9ab.akpm@linux-foundation.org>
References: <12059526271941-git-send-email-yorksun@freescale.com>
	<12059526274026-git-send-email-yorksun@freescale.com>
	<20080320152708.23c6c734.akpm@linux-foundation.org>
	<47E3DE6E.2050801@freescale.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jclk3-00085C-2P for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Mar 2008 11:13:23 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jclk2-0001GQ-JL
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Mar 2008 11:13:22 -0700
In-Reply-To: <47E3DE6E.2050801@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Peter Zijlstra <a.p.zijlstra@chello.nl>, galak@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, York Sun <yorksun@freescale.com>

On Fri, 21 Mar 2008 11:12:30 -0500 Timur Tabi <timur@freescale.com> wrote:

> Andrew Morton wrote:
> 
> >> +static struct diu_hw dr = {
> >> +	.mode = MFB_MODE1,
> >> +	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
> >> +};
> > 
> > I'm not clear on what's supposed to happen with __SPIN_LOCK_UNLOCKED().  I
> > do know that its documentation is crap.
> 
> Yes, "__SPIN_LOCK_UNLOCKED(old_style_spin_init)" is wrong.  We'll fix it.
> 
> >  static struct diu_hw dr = {
> >  	.mode = MFB_MODE1,
> > -	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
> > +	.reg_lock = __SPIN_LOCK_UNLOCKED(diu_hw.reg_lock),
> >  };
> 
> Yes, this is better.  Did you already make this change when you applied it to
> your -mm repo?

I did:

--- a/drivers/video/fsl-diu-fb.c~fbdev-driver-for-freescale-8610-and-5121-diu-fix
+++ a/drivers/video/fsl-diu-fb.c
@@ -274,7 +274,7 @@ static struct mfb_info mfb_template[] = 
 
 static struct diu_hw dr = {
 	.mode = MFB_MODE1,
-	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
+	.reg_lock = __SPIN_LOCK_UNLOCKED(dr.reg_lock),
 };
 
 static struct diu_pool pool;

> > GFP_DMA implies GFP_ATOMIC, but it's appropriate for documentation purposes.
> 
> So does that mean that "GFP_DMA | GFP_KERNEL" is always wrong?

No, that's OK too.  It's just that GFP_DMA|GFP_ATOMIC is a bit redundant
and misleading.  GFP_DMA is already atomic; the only effect of adding
GFP_ATOMIC to GFP_DMA is to add __GFP_HIGH.

Don't wory about it ;)

>  If so, this
> combination is used a lot in the kernel today.
> 
> >> +	if (virt) {
> >> +		*phys = virt_to_phys(virt);
> >> +		pr_debug("virt %p, phys=%llx\n", virt, (uint64_t) *phys);
> >> +		memset(virt, 0, size);
> > 
> > Could have used __GFP_ZERO, I guess.
> 
> I had completely forgotten about __GFP_ZERO.  Thanks.
> 
> >> +	virt = (void *) rh_alloc(&diu_ops.diu_rh_info, size, "DIU");
> > 
> > hm, I'd have expected checkpatch to whine about the space after the cast
> > there.  Whatever.
> 
> I thought a space after a cast is the right thing to do?

Last time I grepped, no-space is a lot more common.

> > please take a look, and please use checkpatch on all future patches.
> 
> Sorry, we forgot to run it again after our second version of the patch.
> 
> >> +static void free_irq_local(int irq)
> >> +{
> >> +	struct diu *hw = dr.diu_reg;
> >> +
> >> +	/* Disable all LCDC interrupt */
> >> +	out_be32(&(hw->int_mask), 0x1f);
> >> +
> >> +	free_irq(irq, 0);
> >> +}
> > 
> > and the free_irq() will go splat?
> 
> Sorry, but I don't understand what's wrong with this code.

You snipped a bit.  Earlier, request_irq() failures were ignored.  So I
think there's a code path where free_irq_local() can free an IRQ which this
driver never owned.

> We'll make the other changes you've suggested and repost.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
