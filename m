From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb: vblank irq support
Date: Sun, 25 Jul 2004 13:16:01 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040725101601.GA15233@sci.fi>
References: <20040722184937.GA11361@sci.fi> <200407250112.18689.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bog33-00041B-6y
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 03:16:05 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bog32-0000no-OI
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 03:16:05 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 5798745D95
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 25 Jul 2004 13:16:01 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200407250112.18689.alex.kern@gmx.de>
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

On Sun, Jul 25, 2004 at 01:12:18AM +0200, Alexander Kern wrote:
> Am Donnerstag, 22. Juli 2004 20:49 schrieb Ville Syrj=E4l=E4:
> > This patch adds vblank interrupt support to atyfb. The added features=
 are
> > FB_ACTIVATE_VBL flag for panning and FBIO_WAITFORVSYNC ioctl.
> >
> > The code is basically copied from matroxfb. I've tested it on two lap=
tops
> > (Mobility and LT Pro) using DirectFB.
> Thanks Ville,
>=20
> I had added last three patches to my tree.
> atyfb: Rage LT LCD register access.
> atyfb: Blank LCD by turning off backlight voltage
> atyfb: vblank irq support
>=20
> atyfb: Add option to disable hardware cursor. <----This one I add in an=
other=20
> way. Option noaccel deactivate hwcursor too.
> The reason is, that I redone hwcursor part and it works now for me, ple=
ase=20
> test it.

Great. I'll test it later today.

> Here is a patch again vanilla 2.6.7 + latest known JSimmons patch
>=20
> P.S. Now the last consumer from fb_load_cursor_image is neo driver.
> Should we drop this function, it's buggy!
>=20
> Steel on my TODO list:
>=20
> Issue with 16bpp mode, brocken boot logo, fbi has problems too.
> Issue with 24bpp mode and fbtest, yellow parts of pinguin image are blu=
e!!!=20

I've never tried 24bpp because of limited acceleration support. I haven't=
=20
even bothered implenenting 24bpp acceleration in the DirectFB driver.

My only todo item is mtrr support. I have a patch which simply tries to=20
add fix.smem_len sized wrcomb mtrr. But that will only work with=20
power-of-two memory size. Also it won't work with a 8MB card when the=20
auxiliary aperture isn't used. Maybe an 8MB wrcomb mtrr + an overlapping=20
uncachable mtrr covering the register page might be better. Will that sor=
t=20
of thing work on all systems?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
