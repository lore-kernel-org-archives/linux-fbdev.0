From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 15:44:33 +0200
Message-ID: <20050314134433.GC2695@linux-sh.org>
References: <qkX0zxQn.1110795218.6236360.varenet@localhost> <200503142015.14749.adaplas@hotpop.com> <20050314131839.GB2695@linux-sh.org> <Pine.LNX.4.62.0503141425000.4784@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAps5-0001XB-Uq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:44:37 -0800
Received: from smtp3.pp.htv.fi ([213.243.153.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAps3-0007L0-EZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:44:37 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503141425000.4784@numbat.sonytel.be>
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


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2005 at 02:25:48PM +0100, Geert Uytterhoeven wrote:
> On Mon, 14 Mar 2005, Paul Mundt wrote:
> > While the pci_resource_xxx() routines would still technically do the
> > right thing, this is purely coincidental.
>=20
> Nah, they would work better here, since they do include the +1 ;-)
>=20
Indeed. However, using the pci_ prefixing here is a misnomer. It may be
worth having more generic struct resource accessors that take care of
this sort of thing, as clearly this is a common issue (perhaps
resource_start()/resource_len() or something equally silly).

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNZVB1K+teJFxZ9wRAsaTAJ43t7gVPrtPvHMqYhRNz3UNEEwe0wCcDiBi
t4BmSkGmBDs2qkYqTrTFmAI=
=CEnB
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
