From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Proper backlight selection for
	fbdev drivers
Date: Wed, 13 Dec 2006 00:00:29 -0800
Message-ID: <20061213000029.edd9c91e.akpm@osdl.org>
References: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuP2h-0007Ng-TF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 00:00:43 -0800
Received: from smtp.osdl.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GuP2g-0007xO-Hs
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 00:00:43 -0800
In-Reply-To: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 7 Dec 2006 17:59:01 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> Try this patch. This should fix any module/built-in dependencys.

drivers/video/aty/atyfb_base.c: In function 'atyfb_blank':
drivers/video/aty/atyfb_base.c:2817: warning: implicit declaration of function 'machine_is'
drivers/video/aty/atyfb_base.c:2817: error: 'powermac' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c:2817: error: (Each undeclared identifier is reported only once
drivers/video/aty/atyfb_base.c:2817: error: for each function it appears in.)

This is i386 build.

#ifdef CONFIG_FB_ATY_BACKLIGHT
	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
#elif defined(CONFIG_FB_ATY_GENERIC_LCD)

It assumes that only pmacs have backlights.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
