From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH 11/20] cirrusfb: checkpatch.plcleanup
Date: Mon, 27 Aug 2007 10:19:15 +0200
Message-ID: <46d28903790a5@wp.pl>
References: <46D18888.10902@gmail.com>
	<Pine.LNX.4.64.0708270913170.19656@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPZof-0003WU-Fn for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 01:19:22 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IPZod-0001l9-Og
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 01:19:21 -0700
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	27 Aug 2007 10:19:15 +0200
In-reply-to: <46D18888.10902@gmail.com>
	<Pine.LNX.4.64.0708270913170.19656@anakin>
Content-Disposition: inline
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
Content-Type: text/plain; charset="iso-8859-1"
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andy Whitcroft <apw@shadowen.org>

Dnia 27-08-2007 o godz. 9:15 Geert Uytterhoeven napisa=B3:
> >  drivers/video/cirrusfb.c | 1788
+++++++++++++++++++++++++---------------------
> >  1 files changed, 983 insertions(+), 805 deletions(-)
> > =

> > diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
> > index 8269d70..4c97c1d 100644
> > --- a/drivers/video/cirrusfb.c
> > +++ b/drivers/video/cirrusfb.c
> > @@ -59,7 +59,7 @@ #include <asm/amigahw.h>
> >  #endif
> >  #ifdef CONFIG_PPC_PREP
> >  #include <asm/machdep.h>
> > -#define isPReP (machine_is(prep))
> > +#define isPReP(machine_is(prep))
> >  #else
> >  #define isPReP 0
> >  #endif
> =

> This chunk is bogus. Probably there should be a tab instead of
a space to
> silence checkpatch, or checkpatch should become smarter...
> =


My bad. The simplest solution is to drop parentheses so it becomes

#define isPReP machine_is(prep)

I'll made a patch today (about 12 hours later) if someone does
not make it earlier.

Regards,
Krzysztof

----------------------------------------------------
Wsp=F3=B3czesna bajka dla doros=B3ych! Zmys=B3owe opisy, magiczne =

zdarzenia, ironiczne komentarze "Mam =B3=F3zko z racuch=F3w =

na ma=B6lance" Jaclyn Moriarty ju=BF w ksiegaranich! =

http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fracuchy.html=
&sid=3D2



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
