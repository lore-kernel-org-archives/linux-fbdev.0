From: James Simmons <jsimmons@infradead.org>
Subject: Re: Large framebuffers and HIGHMEM systems
Date: Fri, 12 Sep 2003 23:56:32 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309122329220.5017-100000@phoenix.infradead.org>
References: <20030909212824.95374.qmail@web14916.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xwqD-0003I2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:56:37 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xwqC-0006LW-AU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:56:36 -0700
In-Reply-To: <20030909212824.95374.qmail@web14916.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> Fbdev needs to come up with a general solution for mapping large framebuffers
> on systems with over 1GB memory. For example my system does not have 64MB of
> free address space below 1GB, this causes my framebuffer drivers to fail when
> loading. With RAM prices at $200 for 1GB memory 1GB systems will be common
> during the 2.6 timeframe.
> 
> There are many possible solutions...
> 1) add reserve=XXXX to the kernel at boot. Drawback to this is reserving
> 256-512MB takes this memory out of lowmem kernel use. This will push page
> tables into highmem slowing the whole system down.

NOPE!!!!

> 2) Only map a 2048x2048x32 piece of the framebuffer. This still uses 16MB of
> address space which may not always be available. It could be possible to modify
> the kernel to always reserve this much address space at boot.

I was thinking about a solution like this. We have to consider that alot 
of drivers use the extra memory space to do hardware panning to create a
scrolling effect. We could set a limit to the amount of memory mapped for 
this effect. 

> 3) Only map what is actually needed on each mode change. Mode change could fail
> at run time if not enough free address space.

That is acceptable. I doubt it would fail all the time. We lose th 
eperformance boost for scrolling tho :-(

> 4) Map the buffer into the highmem address space using the highmem access
> macros.

We could do a partial mapping into highmem space. Lomem memory what we are 
using now. High memory for what we need less often.

> 5) Map the fb in a user process and send it signals to draw.

Yuck!!

The good news is fully accelerated drivers don't need to ioremap the 
entire range in memory at one time. screen_base is not much use to them. 
The only place this is not true is fb_read and fb_write. We could setup a 
blitting engine use tho :-) Then of course mmap a huge framebuffer to 
memory would fail then with 1 GB memory systems. 

P.S
    How bad is the cost to access high memory?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
