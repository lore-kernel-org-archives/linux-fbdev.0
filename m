From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mach64 atari patch
Date: Sun, 7 Aug 2005 09:46:18 -0700
Message-ID: <20050807094618.0cc4cadc.akpm@osdl.org>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
	<Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1oJj-0004nO-Hx
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:48:07 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1E1oJj-0001me-4A
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 09:48:07 -0700
In-Reply-To: <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@hotpop.com

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sun, 7 Aug 2005, James Simmons wrote:
> > This patch makes the mach64 chip a platform device so sysfs can work with 
> > it. 
> > 
> > Signed-off-by: James Simmons <jsimmons@infradead.org>
> > 
> > --- linus-2.6/drivers/video/aty/atyfb_base.c	2005-07-11 10:07:21.000000000 -0700
> > +++ fbdev-2.6/drivers/video/aty/atyfb_base.c	2005-07-27 08:41:24.000000000 -0700
> > @@ -321,10 +318,8 @@
> >  #endif
> >  
> >  #ifdef CONFIG_ATARI
> > -static unsigned int mach64_count __initdata = 0;
> > -static unsigned long phys_vmembase[FB_MAX] __initdata = { 0, };
> > -static unsigned long phys_size[FB_MAX] __initdata = { 0, };
> > -static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
> > +static struct mach64_device* __init store_video_par(char *video_str, unsigned char m64_num)
> 
> Missing semicolumn at end of line.
> 
> [etc]
>

Thanks, Geert.

James, I'll drop this one - it seems to need version 2.

I'll also drop fbdev-dont-allow-softcursor-use-from-userland.patch as there
seems to be quite a bit of controversy there.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
