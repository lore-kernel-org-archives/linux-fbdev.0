From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 6/7] metronomefb: convert
 printk to dev_dbg/err messages
Date: Sat, 7 Jun 2008 10:46:05 +0200
Message-ID: <20080607104605.f2968e05.krzysztof.h1@poczta.fm>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-7-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4u1U-0006oq-Qs for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:43:41 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4u1T-0002pK-E1
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:43:40 -0700
In-Reply-To: <1212814166-10313-7-git-send-email-jayakumar.lkml@gmail.com>
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

On Sat,  7 Jun 2008 00:49:25 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> This patch converts the printk messages in metronomefb to dev_dbg/err type
> messages.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  drivers/video/metronomefb.c |   49 +++++++++++++++++++-----------------------
>  1 files changed, 22 insertions(+), 27 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e22 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
