From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: [Bugme-new] [Bug 4570] New: vesafb, Console goes black after some time of inactivity, but does not put monitor in standby
Date: Sat, 7 May 2005 11:11:12 +0800
Message-ID: <200505071111.12702.adaplas@hotpop.com>
References: <20050501142120.0978d2f9.akpm@osdl.org> <Pine.LNX.4.62.0505021123180.28949@numbat.sonytel.be> <200505022147.42248.bonbons67@internet.lu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUFlw-00069z-Ha
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 20:14:32 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DUFlt-0008PU-Is
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 20:14:32 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 346A8113565E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  7 May 2005 03:14:21 +0000 (UTC)
In-Reply-To: <200505022147.42248.bonbons67@internet.lu>
Content-Disposition: inline
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
To: Bruno <bonbons67@internet.lu>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 03 May 2005 03:47, Bruno wrote:
> On Monday 02 May 2005 11:24, Geert Uytterhoeven wrote:
> > On Sun, 1 May 2005, Andrew Morton wrote:
> > > Begin forwarded message:
> > >
> > > Date: Sun, 1 May 2005 13:16:17 -0700
> > > From: bugme-daemon@osdl.org
> > > To: bugme-new@lists.osdl.org
> > > Subject: [Bugme-new] [Bug 4570] New: vesafb, Console goes black after
> > > some time of inactivity, but does not put monitor in standby
> > >
> > >
> > > http://bugme.osdl.org/show_bug.cgi?id=4570
> > >
> > >            Summary: vesafb, Console goes black after some time of
> > >                     inactivity, but does not put monitor in standby
> > >     Kernel Version: 2.6.*
> > >             Status: NEW
> > >           Severity: normal
> > >              Owner: jsimmons@infradead.org
> > >          Submitter: bonbons67@internet.lu
> > >
> > >
> > > Distribution: Gentoo
> > > Hardware Environment:
> > >     Does not matter, all my computers have same problem
> > > Software Environment:
> > > Problem Description:
> > > After some time of inactivity the console goes black, but does not put
> > > monitor into standby mode (this works in X with driver for the card,
> > > have not tried with vesa driver in X)
> > > What I would expect is that the monitor is put in stand-by when the
> > > console goes blank. (Tweaking with fbset does not help)
> > >
> > > Steps to reproduce:
> > > Work on linux console (not under X ;-)), then keep away from
> > > keyboard/mouse for some time.
> >
> > man setterm(1).
> >
> > Does it work if you don't use vesafb, but the plain VGA text console?
> >
> > Gr{oetje,eeting}s,
> >
> > 						Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> > geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker.
> > But when I'm talking to journalists I just say "programmer" or something
> > like that. -- Linus Torvalds
>
> I tried out vga framebuffer (booting with vga=normal boot parameter), but
> there I still only get blanking instead of standby.
> With setterm it tried the various "powersave" options (vsync, hsync,
> powerdown), but none is working.
>

Yes, I know that the powersave options are not working for a long time now
and I don't know why.

Unfortunately setterm -blank puts the console in VESA_BLANK_NORMAL
only which is defined as blank the screen but keep monitor sync signals on.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
