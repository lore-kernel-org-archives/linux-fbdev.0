From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2 v2] Driver for Freescale 8610
	and 5121 DIU
Date: Mon, 24 Mar 2008 09:53:16 -0500
Message-ID: <47E7C05C.2000001@freescale.com>
References: <12059526271941-git-send-email-yorksun@freescale.com>	<12059526274026-git-send-email-yorksun@freescale.com>	<20080320152708.23c6c734.akpm@linux-foundation.org>	<47E3DE6E.2050801@freescale.com>
	<20080321111228.95a7d9ab.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jdo4D-0007SW-FI for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Mar 2008 07:54:29 -0700
Received: from az33egw02.freescale.net ([192.88.158.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jdo4C-0005c8-4u
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Mar 2008 07:54:29 -0700
In-Reply-To: <20080321111228.95a7d9ab.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Peter Zijlstra <a.p.zijlstra@chello.nl>, galak@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, York Sun <yorksun@freescale.com>

Andrew Morton wrote:

>>> GFP_DMA implies GFP_ATOMIC, but it's appropriate for documentation purposes.
>> So does that mean that "GFP_DMA | GFP_KERNEL" is always wrong?
> 
> No, that's OK too.  It's just that GFP_DMA|GFP_ATOMIC is a bit redundant
> and misleading.  GFP_DMA is already atomic; the only effect of adding
> GFP_ATOMIC to GFP_DMA is to add __GFP_HIGH.
> 
> Don't wory about it ;)

Well, maybe we don't want GFP_ATOMIC then, because I don't think we want
__GFP_HIGH.  Looking at the code, it appears the __GFP_HIGH has nothing to do
with HIGHMEM (which on PowerPC is the not 1-to-1 mapping memory from 0xF000000
to 0xFFFFFFFF).  Further examination of the cools shows the __GFP_HIGH says to
try access the "emergency pool", and I see this code snippet:

	if (alloc_flags & ALLOC_HIGH)
		min -= min / 2;

I guess this means that we reduce the amount of memory that can be available in
order for the allocate to succeed.

Considering that the amount of memory that we allocate is in the order of
megabytes, and it really isn't that important, I would think that we don't want
to touch the emergency pool.  Does that sound right?

-- 
Timur Tabi
Linux kernel developer at Freescale

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
