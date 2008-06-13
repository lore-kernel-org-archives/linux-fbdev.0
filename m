From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 2.6.26-rc3 01/10] pxafb: fix ifdef for
	command line option handling
Date: Fri, 13 Jun 2008 08:37:10 +0100
Message-ID: <20080613073710.GB20702@flint.arm.linux.org.uk>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-2-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K73qo-0000dV-0q for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 00:37:34 -0700
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K73ql-0006EO-9O
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jun 2008 00:37:32 -0700
Content-Disposition: inline
In-Reply-To: <1213289961-1562-2-git-send-email-jayakumar.lkml@gmail.com>
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

On Thu, Jun 12, 2008 at 12:59:12PM -0400, Jaya Kumar wrote:
> This bug was found and fixed by Lothar Wassmann.
> 
> Previously, the use of ifndef CONFIG_MODULES made it such that pxafb command
> line option parsing was dependent on whether the kernel was built with module
> support. The ifndef should be MODULE so that parsing is dependent only on
> whether the driver is built-in or not.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

Ok.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
