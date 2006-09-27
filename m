From: Jurij Smakov <jurij@wooyd.org>
Subject: Re: Fw: [Bugme-new] [Bug 7189] New:
	Inconsistent /proc/fb behavior
Date: Wed, 27 Sep 2006 00:39:30 -0700
Message-ID: <20060927073930.GA23901@droopy.oc.cox.net>
References: <20060922194700.c581fa72.akpm@osdl.org>
	<Pine.LNX.4.64.0609241221410.24615@anakin>
	<20060926135809.9c74e7db.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSU16-0001yD-Rw for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 00:39:41 -0700
Received: from mouth.voxel.net
	([69.9.180.118] helo=mail.squishy.cc ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GSU15-0002Rc-IW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 00:39:40 -0700
Content-Disposition: inline
In-Reply-To: <20060926135809.9c74e7db.akpm@osdl.org>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Willy Tarreau <w@1wt.eu>, jurij@wooyd.org

On Tue, Sep 26, 2006 at 01:58:09PM -0700, Andrew Morton wrote:
> On Sun, 24 Sep 2006 12:31:30 +0200 (CEST)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
[...]
> > [PATCH] Correct buffer size limit in fbmem_read_proc()
> > 
> > Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>
> > 
> > --- linux-2.6.18/drivers/video/fbmem.c.orig	2006-09-04 11:02:45.000000000 +0200
> > +++ linux-2.6.18/drivers/video/fbmem.c	2006-09-24 12:17:07.000000000 +0200
> > @@ -554,7 +554,8 @@ static int fbmem_read_proc(char *buf, ch
> >  	int clen;
> >  
> >  	clen = 0;
> > -	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && len < 4000; fi++)
> > +	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && clen < 4000;
> > +	     fi++)
> >  		if (*fi)
> >  			clen += sprintf(buf + clen, "%d %s\n",
> >  				        (*fi)->node,
> > 
> 
> Thanks.   Do we have confirmation that this patch fixes the bug?

Sorry for not replying sooner. Today I've built a 2.6.18 kernel with this patch 
and it did fix the problem. Grepping through /proc/fb now works as expected on my 
Sparc.

Best regards,
-- 
Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
