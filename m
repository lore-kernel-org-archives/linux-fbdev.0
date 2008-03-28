From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2 v4] Driver for Freescale 8610
	and 5121 DIU
Date: Fri, 28 Mar 2008 13:09:05 -0500
Message-ID: <47ED3441.3090601@freescale.com>
References: <12066720572512-git-send-email-yorksun@freescale.com>
	<12066720572314-git-send-email-yorksun@freescale.com>
	<47ED2B35.4030601@freescale.com> <47ED33C6.3090202@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JfJ1E-0000dl-Iw for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 11:09:36 -0700
Received: from az33egw02.freescale.net ([192.88.158.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JfJ1A-00025o-6u
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Mar 2008 11:09:36 -0700
In-Reply-To: <47ED33C6.3090202@freescale.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, galak@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

Timur Tabi wrote:
> Scott Wood wrote:
> 
>> ...but not anywhere else.  All user pointers should have a __user 
>> annotation.
> 
> Even in a typecast?

Yes.  Otherwise, as far as sparse sees, you're passing a kernel pointer 
to something expecting a user pointer.

-Scott

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
