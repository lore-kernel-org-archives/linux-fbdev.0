From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 16:35:09 +0200
Message-ID: <20050314143509.GD2695@linux-sh.org>
References: <20050314130014.55A073658E8@mail.esiee.fr> <200503142207.57074.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAqf2-0004I0-98
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:35:12 -0800
Received: from smtp3.pp.htv.fi ([213.243.153.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAqf0-00069Q-KH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 06:35:12 -0800
Content-Disposition: inline
In-Reply-To: <200503142207.57074.adaplas@hotpop.com>
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
Cc: adaplas@pol.net


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2005 at 10:10:35PM +0800, Antonino A. Daplas wrote:
> BTW, I would guess that scrolling is slow in this driver.  Since this dri=
ver
> can do pan_display, If this:=20
>=20
> info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
>=20
> is added somewhere before register_framebuffer(), and var->xres_virtual >
> var->xres, you might get a several-fold increase in scrolling speed (since
> scrolling mode will be SCROLL_PAN_REDRAW instead of SCROLL_REDRAW).
>=20
This is interesting. When FBINFO_HWACCEL_YPAN was added to hitfb, it slowed
down scrolling by several orders of magnitude. Perhaps it was something
relating to how the pan_display was implemented, but it's definitely not
a general win for everyone..

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNaEd1K+teJFxZ9wRArmNAJ42hAOYwyKbuuT1dsB7vPm1hTiMyQCfVODf
0bXD/nAtFaCosRdXZV4RvLQ=
=2EXi
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
