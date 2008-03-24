From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2 v2] Driver for Freescale 8610
	and 5121 DIU
Date: Mon, 24 Mar 2008 11:47:40 -0700
Message-ID: <20080324114740.337509d3.akpm@linux-foundation.org>
References: <12059526271941-git-send-email-yorksun@freescale.com>
	<12059526274026-git-send-email-yorksun@freescale.com>
	<20080320152708.23c6c734.akpm@linux-foundation.org>
	<47E3DE6E.2050801@freescale.com>
	<20080321111228.95a7d9ab.akpm@linux-foundation.org>
	<47E7C05C.2000001@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jdrj6-0003P3-1M for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Mar 2008 11:48:57 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jdrj4-0007EN-Cr
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Mar 2008 11:48:54 -0700
In-Reply-To: <47E7C05C.2000001@freescale.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, galak@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, yorksun@freescale.com

On Mon, 24 Mar 2008 09:53:16 -0500
Timur Tabi <timur@freescale.com> wrote:

> Andrew Morton wrote:
> 
> >>> GFP_DMA implies GFP_ATOMIC, but it's appropriate for documentation purposes.
> >> So does that mean that "GFP_DMA | GFP_KERNEL" is always wrong?
> > 
> > No, that's OK too.  It's just that GFP_DMA|GFP_ATOMIC is a bit redundant
> > and misleading.  GFP_DMA is already atomic; the only effect of adding
> > GFP_ATOMIC to GFP_DMA is to add __GFP_HIGH.
> > 
> > Don't wory about it ;)
> 
> Well, maybe we don't want GFP_ATOMIC then, because I don't think we want
> __GFP_HIGH.  Looking at the code, it appears the __GFP_HIGH has nothing to do
> with HIGHMEM (which on PowerPC is the not 1-to-1 mapping memory from 0xF000000
> to 0xFFFFFFFF).  Further examination of the cools shows the __GFP_HIGH says to
> try access the "emergency pool", and I see this code snippet:
> 
> 	if (alloc_flags & ALLOC_HIGH)
> 		min -= min / 2;
> 
> I guess this means that we reduce the amount of memory that can be available in
> order for the allocate to succeed.
> 
> Considering that the amount of memory that we allocate is in the order of
> megabytes, and it really isn't that important, I would think that we don't want
> to touch the emergency pool.  Does that sound right?

yup.  The absence of __GFP_WAIT already causes the page allocator to try a
bit harder.  Adding __GFP_HIGH would make it try harder still.

You do need to be sure that the driver will robustly and correctly recover
from an allocation failure here.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
