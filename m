From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Large framebuffers and HIGHMEM systems
Date: Fri, 12 Sep 2003 20:19:56 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030913031956.59595.qmail@web14909.mail.yahoo.com>
References: <Pine.LNX.4.44.0309122329220.5017-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19y0x2-0001c8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 20:19:56 -0700
Received: from web14909.mail.yahoo.com ([216.136.225.61])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19y0x2-0001ZN-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 20:19:56 -0700
In-Reply-To: <Pine.LNX.4.44.0309122329220.5017-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- James Simmons <jsimmons@infradead.org> wrote:
> > Fbdev needs to come up with a general solution for mapping large
> framebuffers
> > on systems with over 1GB memory. For example my system does not have 64MB
> of
> > free address space below 1GB, this causes my framebuffer drivers to fail
> when
> > loading. With RAM prices at $200 for 1GB memory 1GB systems will be common
> > during the 2.6 timeframe.
> > 
> > There are many possible solutions...
> > 1) add reserve=XXXX to the kernel at boot. Drawback to this is reserving
> > 256-512MB takes this memory out of lowmem kernel use. This will push page
> > tables into highmem slowing the whole system down.
> 
> NOPE!!!!

This is what I have to do right now with 1GB of memory and a 64MB Radeon on
2.6. We need to fix this. We should also add an error message right now to
framebuffer ioremap()'s telling users that this what they need to do to get
around the failure.

> 
> > 2) Only map a 2048x2048x32 piece of the framebuffer. This still uses 16MB
> of
> > address space which may not always be available. It could be possible to
> modify
> > the kernel to always reserve this much address space at boot.
> 
> I was thinking about a solution like this. We have to consider that alot 
> of drivers use the extra memory space to do hardware panning to create a
> scrolling effect. We could set a limit to the amount of memory mapped for 
> this effect. 
> 
> > 3) Only map what is actually needed on each mode change. Mode change could
> fail
> > at run time if not enough free address space.
> 
> That is acceptable. I doubt it would fail all the time. We lose th 
> eperformance boost for scrolling tho :-(

If you boot in a low res mode, mode changing to a higher res may fail because
there is not enough address space. Trying to fit into the small amount of
remaining VM space may  fragment it preventing you from getting 64MB of
contiguous address space.

> 
> > 4) Map the buffer into the highmem address space using the highmem access
> > macros.
> 
> We could do a partial mapping into highmem space. Lomem memory what we are 
> using now. High memory for what we need less often.
> 
> > 5) Map the fb in a user process and send it signals to draw.
> 
> Yuck!!

I'd like to hear a good explanation of why we need to draw to framebuffers in
the kernel. I'm starting to think that we should draw on whatever the BIOS sets
up untill user space is active. Then point the kernel to a user space process
that draws the console for specific hardware. Kernel VESA fb would always be
loaded as back up in case these processes die. User space proccesses don't have
the same problem with virtual memory address space shortages.

> The good news is fully accelerated drivers don't need to ioremap the 
> entire range in memory at one time. screen_base is not much use to them. 
> The only place this is not true is fb_read and fb_write. We could setup a 
> blitting engine use tho :-) Then of course mmap a huge framebuffer to 
> memory would fail then with 1 GB memory systems. 
> 
> P.S
>     How bad is the cost to access high memory?
> 
High mem might be the best solution. Make a rule that kernel framebuffers are
always mapped to high memory. I'd make it a rule so that this code will get
tested on all systems not just a few with 1GB today. Either your page tables
are going into high memory or your framebuffer is, if you ask me there is no
choice about this and the framebuffer is going high.

I have never used highmem before but I think it works something like this.
First we need some way to ioremap() to a highmem address.  Then before each
access to a high mem address there is a macro for converting the high mem
address to a low mem one, and then another macro for freeing it. These marcos
mess with a page table entry for a low mem page and make it point to the high
mem one. There are a limited number for page table entries reserved for this
process so you need to keep mapping and unmapping.

This is slow to a CPU but not to a human,  we're doing an APG or PCI memory
cycle which takes forever anyway. And it sure is easier than explaining why a
system won't boot because it is out of kernel virtual memory space.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
