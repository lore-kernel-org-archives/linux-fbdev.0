From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] atyfb (2.6): Add RGB565 support
Date: Thu, 13 May 2004 11:22:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405131121210.9790@waterleaf.sonytel.be>
References: <20040511213607.GB6854@sci.fi> <Pine.GSO.4.58.0405121110360.19967@waterleaf.sonytel.be>
 <20040512185724.GA825@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOCPn-0003A9-28
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 02:22:07 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BOCPm-000429-Hi
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 02:22:06 -0700
In-Reply-To: <20040512185724.GA825@sci.fi>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi Ville,

On Wed, 12 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> On Wed, May 12, 2004 at 11:11:21AM +0200, Geert Uytterhoeven wrote:
> > On Wed, 12 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> > > This patch adds RGB565 support to atyfb.
> >
> > Nice! Have you tried fbtest on it?
> >
> > I once tried to implement it myself, but it didn't work reliably.
>
> I just tried fbtest and most tests look ok. The penguin images are wron=
g
> (green instead of white stuff aroung the penguin) and the test009 looks
> wrong too. Are you sure fbtest is doing the right thing with rgb565
> directcolor visuals? DirectFB or mplayer don't have any problems.

It's always possible there's a bug in fbtest w.r.t. 565 handling, but I d=
idn't
see it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
