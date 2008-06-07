From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 4/7] am200epd: move
 am200epd to mach-pxa
Date: Sat, 7 Jun 2008 10:40:04 +0200
Message-ID: <20080607104004.ec8c2373.krzysztof.h1@poczta.fm>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-5-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4tvc-0006Cb-Nl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:37:36 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4tvc-0002Z1-AJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:37:36 -0700
In-Reply-To: <1212814166-10313-5-git-send-email-jayakumar.lkml@gmail.com>
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

On Sat,  7 Jun 2008 00:49:23 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> The am200epd driver was designed with bad assumptions. It manipulated
> GPSR/GPLR registers directly. It relied on direct access to the pxa LCDC
> registers which have since conflicted with commit
> ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 . This patch moves it into
> mach-pxa in preparation for an overhaul. This is done as a move rather
> than a removal in order to facilitate code review.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig    |   17 +++
>  arch/arm/mach-pxa/Makefile   |    1 +
>  arch/arm/mach-pxa/am200epd.c |  295 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/video/Kconfig        |   13 --
>  drivers/video/Makefile       |    1 -
>  drivers/video/am200epd.c     |  295 ------------------------------------------
>  6 files changed, 313 insertions(+), 309 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/am200epd.c
>  delete mode 100644 drivers/video/am200epd.c
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

The move instead of removal is good idea.

Regards,
Krzysztof

---------------------------------------------------------------
Sprawdz jak zdobyc zdrowy usmiech!
Kliknij >> http://link.interia.pl/f1e26


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
