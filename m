From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsl-diu-fb: Update Freescale DIU
	driver to use page_alloc_exact()
Date: Fri, 4 Jul 2008 06:32:05 -0400
Message-ID: <DEA4DF93-2CC0-4F19-B1CC-59A737626D2B@freescale.com>
References: <1214325853-26150-1-git-send-email-timur@freescale.com>
	<20080630132426.a89c32b0.akpm@linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEiWr-0006jl-68 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 03:28:37 -0700
Received: from de01egw02.freescale.net ([192.88.165.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KEiWn-000400-NC
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 03:28:37 -0700
In-Reply-To: <20080630132426.a89c32b0.akpm@linux-foundation.org>
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
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


On Jun 30, 2008, at 4:24 PM, Andrew Morton wrote:

> This is also incorrect.  We cannot pass u64 or uint64_t into printk at
> all.  We do not know what type the architectures uses to implement
> them.  It should be cast to a known type.  In this case `unsigned long
> long'.

Ok, I'll fix these, but I'm on vacation now and won't get to it for  
another 10 days.


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
