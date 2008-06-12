From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 02/10] pxafb: cleanup and
 fix order of failure handling
Date: Thu, 12 Jun 2008 20:36:08 +0200
Message-ID: <20080612203608.f5a0b1eb.krzysztof.h1@poczta.fm>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-3-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6s5t-0003HW-KA for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 12:04:21 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6s5t-00038v-3b
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 12:04:21 -0700
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

On Thu, 12 Jun 2008 12:59:13 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> This issue was found by Krzysztof Helt and Eric Miao.
> 
> pxafb had issues in the order with which it cleaned up if errors occurred
> during a probe. This patch reorders the failure handling sequence and also
> frees the cmap and clk.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Internetowy planer podrozy - sprawdz!
kliknij >>> http://link.interia.pl/f1e3a


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
