From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Proper backlight selection for
 fbdev drivers
Date: Wed, 13 Dec 2006 14:58:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0612131442440.4484@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
	<20061213000029.edd9c91e.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuVZA-0006aO-2b for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 06:58:40 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GuVZ8-0007Us-Ab
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 06:58:39 -0800
In-Reply-To: <20061213000029.edd9c91e.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


The problem is the overlap of the patches 

fbdev-update-after-backlight-argument-change.diff
proper-backlight-selection-forfbdev-drivers.patch

The machine_is change is in the argument change patch. It should be in 
this patch. I can send updates of both patches.

On Wed, 13 Dec 2006, Andrew Morton wrote:

> On Thu, 7 Dec 2006 17:59:01 +0000 (GMT)
> James Simmons <jsimmons@infradead.org> wrote:
> 
> > Try this patch. This should fix any module/built-in dependencys.
> 
> drivers/video/aty/atyfb_base.c: In function 'atyfb_blank':
> drivers/video/aty/atyfb_base.c:2817: warning: implicit declaration of function 'machine_is'
> drivers/video/aty/atyfb_base.c:2817: error: 'powermac' undeclared (first use in this function)
> drivers/video/aty/atyfb_base.c:2817: error: (Each undeclared identifier is reported only once
> drivers/video/aty/atyfb_base.c:2817: error: for each function it appears in.)
> 
> This is i386 build.
> 
> #ifdef CONFIG_FB_ATY_BACKLIGHT
> 	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
> 		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
> #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
> 
> It assumes that only pmacs have backlights.
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
