From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: [PATCH] atyfb: vblank irq support
Date: Sun, 25 Jul 2004 20:29:10 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407252029.10373.alex.kern@gmx.de>
References: <20040722184937.GA11361@sci.fi> <200407250112.18689.alex.kern@gmx.de> <20040725101601.GA15233@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bonl5-0008Sg-Jc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 11:30:03 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bonl5-0004Zt-03
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 11:30:03 -0700
In-Reply-To: <20040725101601.GA15233@sci.fi>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>

Am Sonntag, 25. Juli 2004 12:16 schrieb Ville Syrj=E4l=E4:
> On Sun, Jul 25, 2004 at 01:12:18AM +0200, Alexander Kern wrote:
> > Am Donnerstag, 22. Juli 2004 20:49 schrieb Ville Syrj=E4l=E4:
> > > This patch adds vblank interrupt support to atyfb. The added features
> > > are FB_ACTIVATE_VBL flag for panning and FBIO_WAITFORVSYNC ioctl.
> > >
> > > The code is basically copied from matroxfb. I've tested it on two
> > > laptops (Mobility and LT Pro) using DirectFB.
> >
> > Thanks Ville,
> >
> > I had added last three patches to my tree.
> > atyfb: Rage LT LCD register access.
> > atyfb: Blank LCD by turning off backlight voltage
> > atyfb: vblank irq support
> >
> > atyfb: Add option to disable hardware cursor. <----This one I add in
> > another way. Option noaccel deactivate hwcursor too.
> > The reason is, that I redone hwcursor part and it works now for me,
> > please test it.
>
> Great. I'll test it later today.
>
> > Here is a patch again vanilla 2.6.7 + latest known JSimmons patch
> >
> > P.S. Now the last consumer from fb_load_cursor_image is neo driver.
> > Should we drop this function, it's buggy!
> >
> > Steel on my TODO list:
> >
> > Issue with 16bpp mode, brocken boot logo, fbi has problems too.
> > Issue with 24bpp mode and fbtest, yellow parts of pinguin image are
> > blue!!!
>
> I've never tried 24bpp because of limited acceleration support. I haven't
> even bothered implenenting 24bpp acceleration in the DirectFB driver.
Interesting, I thought 24bpp hardware acceleration is complete? What is=20
missed?
>
> My only todo item is mtrr support. I have a patch which simply tries to
> add fix.smem_len sized wrcomb mtrr. But that will only work with
> power-of-two memory size. Also it won't work with a 8MB card when the
> auxiliary aperture isn't used. Maybe an 8MB wrcomb mtrr + an overlapping
> uncachable mtrr covering the register page might be better. Will that sort
> of thing work on all systems?


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
