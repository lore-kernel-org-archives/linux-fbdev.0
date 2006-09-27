From: Willy Tarreau <w@1wt.eu>
Subject: Re: Fw: [Bugme-new] [Bug 7189] New:
	Inconsistent /proc/fb behavior
Date: Wed, 27 Sep 2006 09:17:05 +0200
Message-ID: <20060927071705.GA12021@1wt.eu>
References: <20060922194700.c581fa72.akpm@osdl.org>
	<Pine.LNX.4.64.0609241221410.24615@anakin>
	<20060926135809.9c74e7db.akpm@osdl.org>
	<20060927073930.GA23901@droopy.oc.cox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSU4T-0002Kb-N0 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 00:43:10 -0700
Received: from 1wt.eu ([62.212.114.60])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GSU4S-0003ET-Fn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 00:43:09 -0700
Content-Disposition: inline
In-Reply-To: <20060927073930.GA23901@droopy.oc.cox.net>
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
To: Jurij Smakov <jurij@wooyd.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, Sep 27, 2006 at 12:39:30AM -0700, Jurij Smakov wrote:
> On Tue, Sep 26, 2006 at 01:58:09PM -0700, Andrew Morton wrote:
> > On Sun, 24 Sep 2006 12:31:30 +0200 (CEST)
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> [...]
> > > [PATCH] Correct buffer size limit in fbmem_read_proc()
> > > 
> > > Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>
> > > 
> > > --- linux-2.6.18/drivers/video/fbmem.c.orig	2006-09-04 11:02:45.000000000 +0200
> > > +++ linux-2.6.18/drivers/video/fbmem.c	2006-09-24 12:17:07.000000000 +0200
> > > @@ -554,7 +554,8 @@ static int fbmem_read_proc(char *buf, ch
> > >  	int clen;
> > >  
> > >  	clen = 0;
> > > -	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && len < 4000; fi++)
> > > +	for (fi = registered_fb; fi < &registered_fb[FB_MAX] && clen < 4000;
> > > +	     fi++)
> > >  		if (*fi)
> > >  			clen += sprintf(buf + clen, "%d %s\n",
> > >  				        (*fi)->node,
> > > 
> > 
> > Thanks.   Do we have confirmation that this patch fixes the bug?
> 
> Sorry for not replying sooner. Today I've built a 2.6.18 kernel with this patch 
> and it did fix the problem. Grepping through /proc/fb now works as expected on my 
> Sparc.

Thanks for the feedback, then I'm queueing it for 2.4.34-pre4 too.

Cheers,
Willy


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
