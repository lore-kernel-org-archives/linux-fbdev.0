From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 15:18:39 +0200
Message-ID: <20050314131839.GB2695@linux-sh.org>
References: <qkX0zxQn.1110795218.6236360.varenet@localhost> <200503142015.14749.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DApT1-00008r-OO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:18:43 -0800
Received: from smtp2.pp.htv.fi ([213.243.153.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DApSz-0006n0-GR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:18:42 -0800
Content-Disposition: inline
In-Reply-To: <200503142015.14749.adaplas@hotpop.com>
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
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2005 at 08:15:13PM +0800, Antonino A. Daplas wrote:
> 3. You can use pci_resource_len()/pci_resource_start() instead of
>=20
> +	info->fix.mmio_start =3D pdev->resource[1].start;
> +	info->fix.mmio_len =3D pdev->resource[1].end - pdev->resource[1].start;
> +	info->fix.smem_start =3D pdev->resource[0].start;
> +	info->fix.smem_len =3D pdev->resource[0].end - pdev->resource[0].start;
> +
>=20
No, the pdev here refers to a platform device, not a pci device.

While the pci_resource_xxx() routines would still technically do the
right thing, this is purely coincidental.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNY8v1K+teJFxZ9wRAsSWAJ9XVlQx8t8585+AxQeI4FcXrXjaDwCZAe8P
6FNb7oERROKPmdhlPtMFkUM=
=i40d
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
