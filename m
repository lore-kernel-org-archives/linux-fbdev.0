From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2 v5] Add DIU platform code for
	MPC8610HPCD
Date: Tue, 01 Apr 2008 16:36:31 -0500
Message-ID: <47F2AADF.1070705@freescale.com>
References: <12069806051060-git-send-email-yorksun@freescale.com>	<1206980605689-git-send-email-yorksun@freescale.com>	<12069806051291-git-send-email-yorksun@freescale.com>
	<20080401140029.be918d87.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgoAS-0008KV-8a for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Apr 2008 14:37:20 -0700
Received: from de01egw02.freescale.net ([192.88.165.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JgoAQ-0008UD-Tt
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Apr 2008 14:37:20 -0700
In-Reply-To: <20080401140029.be918d87.akpm@linux-foundation.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, galak@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, scottwood@freescale.com, avorontsov@ru.mvista.com

Andrew Morton wrote:

> The defconfig change gets almost 100% rejects and probably isn't
> appropriate here and isn't very important.

It's weird that you get rejects, but otherwise you're correct.  defconfigs are
just a convenience, anyway.

-- 
Timur Tabi
Linux kernel developer at Freescale

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
