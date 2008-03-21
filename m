From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2 v2] Driver for Freescale 8610 and 5121 DIU
Date: Fri, 21 Mar 2008 11:12:30 -0500
Message-ID: <47E3DE6E.2050801@freescale.com>
References: <12059526271941-git-send-email-yorksun@freescale.com>	<12059526274026-git-send-email-yorksun@freescale.com> <20080320152708.23c6c734.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758508AbYCUQNp@vger.kernel.org>
In-Reply-To: <20080320152708.23c6c734.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, Peter Zijlstra <a.p.zijlstra@chello.nl>

Andrew Morton wrote:

>> +static struct diu_hw dr = {
>> +	.mode = MFB_MODE1,
>> +	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
>> +};
> 
> I'm not clear on what's supposed to happen with __SPIN_LOCK_UNLOCKED().  I
> do know that its documentation is crap.

Yes, "__SPIN_LOCK_UNLOCKED(old_style_spin_init)" is wrong.  We'll fix it.

>  static struct diu_hw dr = {
>  	.mode = MFB_MODE1,
> -	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
> +	.reg_lock = __SPIN_LOCK_UNLOCKED(diu_hw.reg_lock),
>  };

Yes, this is better.  Did you already make this change when you applied it to
your -mm repo?

> GFP_DMA implies GFP_ATOMIC, but it's appropriate for documentation purposes.

So does that mean that "GFP_DMA | GFP_KERNEL" is always wrong?  If so, this
combination is used a lot in the kernel today.

>> +	if (virt) {
>> +		*phys = virt_to_phys(virt);
>> +		pr_debug("virt %p, phys=%llx\n", virt, (uint64_t) *phys);
>> +		memset(virt, 0, size);
> 
> Could have used __GFP_ZERO, I guess.

I had completely forgotten about __GFP_ZERO.  Thanks.

>> +	virt = (void *) rh_alloc(&diu_ops.diu_rh_info, size, "DIU");
> 
> hm, I'd have expected checkpatch to whine about the space after the cast
> there.  Whatever.

I thought a space after a cast is the right thing to do?

> please take a look, and please use checkpatch on all future patches.

Sorry, we forgot to run it again after our second version of the patch.

>> +static void free_irq_local(int irq)
>> +{
>> +	struct diu *hw = dr.diu_reg;
>> +
>> +	/* Disable all LCDC interrupt */
>> +	out_be32(&(hw->int_mask), 0x1f);
>> +
>> +	free_irq(irq, 0);
>> +}
> 
> and the free_irq() will go splat?

Sorry, but I don't understand what's wrong with this code.

We'll make the other changes you've suggested and repost.

-- 
Timur Tabi
Linux kernel developer at Freescale
