From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Fri, 5 Nov 2004 12:43:47 +0200
Message-ID: <20041105104347.GA16300@sci.fi>
References: <1099448020.900.25.camel@gaston> <20041103032613.GA3677@sci.fi> <1099633776.9260.160.camel@gaston> <20041105093618.GA15762@sci.fi> <Pine.GSO.4.61.0411051052490.15464@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ1ZS-0000wy-B7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 02:43:54 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ1ZR-0005w0-02
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 02:43:54 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411051052490.15464@waterleaf.sonytel.be>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Fri, Nov 05, 2004 at 10:56:04AM +0100, Geert Uytterhoeven wrote:
> On Fri, 5 Nov 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> > On Fri, Nov 05, 2004 at 04:49:36PM +1100, Benjamin Herrenschmidt wrot=
e:
> > > Ok, can we agree here on what has to be done ? X is hard-coding num=
bers
> > > that don't seem to be make any sense vs. our constants. In radeonfb=
, I
> > > used switch case on constants, not +1, so there is something I'm no=
t
> > > getting. Besides, radeon always try to power down TFT panels when
> > > blank !=3D 0, maybe I should improve that ... What is this +1 thing=
, where
> > > does it comes from ?
> >=20
> > Maybe it's there because someone wanted to blank the display without=20
> > disabling sync signals.
>=20
> Yes of course! (/me wasn't completely awake yet)
>=20
> > I suggest a new set of constants that cover all legal values. Here's =
the=20
> > first drawft.
> >=20
> > --- linux-orig/include/linux/fb.h	2004-11-05 12:25:14.087807848 +0200
> > +++ linux/include/linux/fb.h	2004-11-05 12:28:02.734169704 +0200
> > @@ -27,7 +27,7 @@
> >  /* #define FBIOSWITCH_MONIBIT	0x460E */
> >  #define FBIOGET_CON2FBMAP	0x460F
> >  #define FBIOPUT_CON2FBMAP	0x4610
> > -#define FBIOBLANK		0x4611		/* arg: 0 or vesa level + 1 */
> > +#define FBIOBLANK		0x4611		/* see FB_BLANK_* */
> >  #define FBIOGET_VBLANK		_IOR('F', 0x12, struct fb_vblank)
> >  #define FBIO_ALLOC              0x4613
> >  #define FBIO_FREE               0x4614
> > @@ -258,6 +258,12 @@
> >  #define VESA_HSYNC_SUSPEND      2
> >  #define VESA_POWERDOWN          3
> > =20
> > +#define FB_BLANK_NO_BLANKING	0
> > +#define FB_BLANK_BLANKING	1
> > +#define FB_BLANK_VSYNC_SUSPEND	2
> > +#define FB_BLANK_HSYNC_SUSPEND	3
> > +#define FB_BLANK_POWERDOWN	4
> > +
>=20
> Yep, these nicely cover the current intended behavior.
>=20
> But every existing application that uses (shiver) the kernel headers wi=
ll break
> after this change...

If the VESA constants are left intact nothing should change. BTW neither=20
XFree86/X.Org nor DirectFB use them so chances are nothing else does.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
