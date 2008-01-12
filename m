From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tdfxfb: fix section mismatch
 warnings
Date: Sat, 12 Jan 2008 03:54:42 -0800
Message-ID: <20080112035442.667d39ce.akpm@linux-foundation.org>
References: <20080111170353.c28970f8.rdunlap@xenotime.net>
	<20080112052257.afe963fe.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDexA-0007XO-EC for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jan 2008 03:55:08 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JDex9-0001ej-5H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 Jan 2008 03:55:08 -0800
In-Reply-To: <20080112052257.afe963fe.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: hmallat@cc.hut.fi, samr <sam@ravnborg.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Sat, 12 Jan 2008 05:22:57 +0100 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> On Fri, 11 Jan 2008 17:03:53 -0800
> Randy Dunlap <rdunlap@xenotime.net> wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > tdfxfb_setup() can be __devinit.  This fixes the modpost section mismatch
> > warnings:
> > 
> >  
> >  #ifndef MODULE
> > -static void tdfxfb_setup(char *options)
> > +static void __devinit tdfxfb_setup(char *options)
> >  {
> >  	char *this_opt;
> 
> It should be rather in the __init section, as it is called only
> from the function below:
> 
> static int __init tdfxfb_init(void)
> 

yup.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
