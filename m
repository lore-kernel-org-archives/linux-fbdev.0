From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Tue, 15 Mar 2005 09:17:35 +0200
Message-ID: <20050315071735.GA5037@linux-sh.org>
References: <20050314130014.55A073658E8@mail.esiee.fr> <200503142207.57074.adaplas@hotpop.com> <20050314143509.GD2695@linux-sh.org> <200503142306.00236.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB6JB-00025T-Sy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 23:17:41 -0800
Received: from smtp3.pp.htv.fi ([213.243.153.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DB6JB-0005wq-6A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 23:17:41 -0800
Content-Disposition: inline
In-Reply-To: <200503142306.00236.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2005 at 11:06:00PM +0800, Antonino A. Daplas wrote:
> In the case of hitfb, fillrect and copyarea are both accelerated.  So the=
 proper flags would
> be:
>=20
> FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN | FBINFO_HWACCEL_COPYAREA |
> FBINFO_HWACCEL_FILLRECT.
>=20
Should this not be implied by having something other then the cfb_
routines for these? On the other hand, will this affect performance
negatively if these flags remain and we end up wrapping to the cfb_
routines in certain cases?

If we consider the case of FBINFO_HWACCEL_COPYAREA:

        if ((cap & FBINFO_HWACCEL_COPYAREA) &&
            !(cap & FBINFO_HWACCEL_DISABLED))
                p->scrollmode =3D SCROLL_MOVE;
        else /* default to something safe */
                p->scrollmode =3D SCROLL_REDRAW;


This doesn't seem like it will work out well if we end up having
something like (using neofb as an example):

static void
neofb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
{
        switch (info->fix.accel) {
                case FB_ACCEL_NEOMAGIC_NM2200:
                case FB_ACCEL_NEOMAGIC_NM2230:
                case FB_ACCEL_NEOMAGIC_NM2360:
                case FB_ACCEL_NEOMAGIC_NM2380:
                        neo2200_copyarea(info, area);
                        break;
                default:
                        cfb_copyarea(info, area);
                        break;
        }
}

The behaviour in this case will be to use SCROLL_MOVE with regards to
cfb_copyarea() instead of SCROLL_REDRAW as it would normally. If we trust
the comment, then this seems unsafe or broken.

In this case it would seem to be more sensible to fix neo_alloc_fb_info()
to only set these flags for those devices where an optimization exists.
In the case of where using the optimized method depends on a fixed bit
depth, this issue becomes a bit more problematic.

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNowP1K+teJFxZ9wRAtElAJsFYndFr5ODY+fhsJ8UyZ5Q/rF8NACeOgE9
x1brXWIocYkaHRwhaNP0rJg=
=PO6Q
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
