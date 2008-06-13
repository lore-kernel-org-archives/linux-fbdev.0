From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 2.6.26-rc3 02/10] pxafb: cleanup and
	fix order of failure handling
Date: Fri, 13 Jun 2008 08:37:51 +0100
Message-ID: <20080613073751.GC20702@flint.arm.linux.org.uk>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-3-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K73rL-0000jO-WB for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 00:38:11 -0700
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K73rK-0006X7-9h
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 00:38:07 -0700
Content-Disposition: inline
In-Reply-To: <1213289961-1562-3-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jun 12, 2008 at 12:59:13PM -0400, Jaya Kumar wrote:
> This issue was found by Krzysztof Helt and Eric Miao.
> 
> pxafb had issues in the order with which it cleaned up if errors occurred
> during a probe. This patch reorders the failure handling sequence and also
> frees the cmap and clk.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

Ok.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
