From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Fri, 5 Nov 2004 11:36:18 +0200
Message-ID: <20041105093618.GA15762@sci.fi>
References: <1099448020.900.25.camel@gaston> <20041103032613.GA3677@sci.fi> <1099633776.9260.160.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ0W6-0005wh-Lu
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 01:36:22 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQ0W5-0007zk-08
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 01:36:22 -0800
Content-Disposition: inline
In-Reply-To: <1099633776.9260.160.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Fri, Nov 05, 2004 at 04:49:36PM +1100, Benjamin Herrenschmidt wrote:
>=20
> > > Index: linux-work/drivers/video/fbmem.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-work.orig/drivers/video/fbmem.c	2004-10-26 13:15:55.00000=
0000 +1000
> > > +++ linux-work/drivers/video/fbmem.c	2004-11-03 13:10:41.324932256 =
+1100
> > > @@ -748,6 +748,10 @@
> > >  	u16 *black =3D NULL;
> > >  	int err =3D 0;
> > >  =09
> > > +	/* Workaround for broken X servers */
> > > +	if (blank > VESA_POWERDOWN)
> > > +		blank =3D VESA_POWERDOWN;
> > > +
> > >  	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
> > >  		return 0;
> > > =20
> >=20
> > This goes against documented behaviour (see fb.h). Also drivers/char/=
vt.c=20
> > seems to agree with fb.h, as do at least atyfb and matroxfb. I also u=
sed=20
> > the vesa level+1 convention in DirectFB. So AFAICS this patch would=20
> > confuse console power management, XFree86/X.Org, DirectFB and some fb=
=20
> > drivers.
>=20
> Ok, can we agree here on what has to be done ? X is hard-coding numbers
> that don't seem to be make any sense vs. our constants. In radeonfb, I
> used switch case on constants, not +1, so there is something I'm not
> getting. Besides, radeon always try to power down TFT panels when
> blank !=3D 0, maybe I should improve that ... What is this +1 thing, wh=
ere
> does it comes from ?

Maybe it's there because someone wanted to blank the display without=20
disabling sync signals.

I suggest a new set of constants that cover all legal values. Here's the=20
first drawft.

--- linux-orig/include/linux/fb.h	2004-11-05 12:25:14.087807848 +0200
+++ linux/include/linux/fb.h	2004-11-05 12:28:02.734169704 +0200
@@ -27,7 +27,7 @@
 /* #define FBIOSWITCH_MONIBIT	0x460E */
 #define FBIOGET_CON2FBMAP	0x460F
 #define FBIOPUT_CON2FBMAP	0x4610
-#define FBIOBLANK		0x4611		/* arg: 0 or vesa level + 1 */
+#define FBIOBLANK		0x4611		/* see FB_BLANK_* */
 #define FBIOGET_VBLANK		_IOR('F', 0x12, struct fb_vblank)
 #define FBIO_ALLOC              0x4613
 #define FBIO_FREE               0x4614
@@ -258,6 +258,12 @@
 #define VESA_HSYNC_SUSPEND      2
 #define VESA_POWERDOWN          3
=20
+#define FB_BLANK_NO_BLANKING	0
+#define FB_BLANK_BLANKING	1
+#define FB_BLANK_VSYNC_SUSPEND	2
+#define FB_BLANK_HSYNC_SUSPEND	3
+#define FB_BLANK_POWERDOWN	4
+
 #define FB_VBLANK_VBLANKING	0x001	/* currently in a vertical blank */
 #define FB_VBLANK_HBLANKING	0x002	/* currently in a horizontal blank */
 #define FB_VBLANK_HAVE_VBLANK	0x004	/* vertical blanks can be detected *=
/

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
