From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH] fbdev: fix the fb_find_nearest_mode() function
Date: Thu, 13 Oct 2005 21:36:51 +0200
Message-ID: <20051013193650.GA17760@spock.one.pl>
References: <20051009092949.GA9610@spock.one.pl> <434A249F.4060503@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQ8t4-00072E-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Oct 2005 12:37:10 -0700
Received: from ipp23-131.piekary.net ([80.48.23.131])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EQ8t0-0000UZ-4g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Oct 2005 12:37:10 -0700
Content-Disposition: inline
In-Reply-To: <434A249F.4060503@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2005 at 04:21:51PM +0800, Antonino A. Daplas wrote:

> > diff -Nurp fbdev-orig/drivers/video/modedb.c fbdev/drivers/video/modedb=
=2Ec
> > --- fbdev-orig/drivers/video/modedb.c	2005-10-08 23:14:29.000000000 +02=
00
> > +++ fbdev/drivers/video/modedb.c	2005-10-09 01:25:16.000000000 +0200
> > @@ -663,6 +663,7 @@ void fb_var_to_videomode(struct fb_video
> >  {
> >  	u32 pixclock, hfreq, htotal, vtotal;
> > =20
> > +	mode->refresh =3D 0;
>=20
> Any reason why you need to set mode->refresh to 0?

This is something I had to use in a driver I'm currently working on and
I thought it might be a good idea to include it in the patch I sent.

The thing is, if the var struct has the pixclock field set to 0,
mode->refresh is left untouched, which could mean that it's either
set to a random value or to an invalid refresh rate coming from a
previously processed videomode (in case the fb_videomode struct is
reused).

I actually dealt with modes with var->pixclock =3D=3D 0, and it always resu=
lted
in a getting U:<xres>x<yres>-<random> in /sys/class/graphics/fb0/modes.

In case you're wondering why would anyone ever need to have
var->pixclock set to 0 -- I was using it to denote modes with a default
refresh rate set by the hardware (well, the Video BIOS to be more
specific). Please let me know is this is very wrong, but I just didn't
see any other way of doing it.

--=20
Michal Januszewski                                Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDTrdSaQ0HSaOUe+YRAj7vAKCG6yzdQjwwj0Yt2GI2nJPpCzZFAACeNIeF
WNGISekxKkyXEQTz5PXbsr4=
=q+jI
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
