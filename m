From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 9/16] kyrofb: Driver cleanups
Date: Wed, 30 Nov 2005 12:42:43 +0200
Message-ID: <20051130104243.GA16158@linux-sh.org>
References: <438B2257.60100@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhPQG-0007je-HG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 02:42:48 -0800
Received: from smtp2.pp.htv.fi ([213.243.153.35])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhPQF-0000yv-9v
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Nov 2005 02:42:48 -0800
Content-Disposition: inline
In-Reply-To: <438B2257.60100@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2005 at 11:29:27PM +0800, Antonino A. Daplas wrote:
> - remove unneeded casts
> - use framebuffer_alloc/framebuffer_release to allocate/free memory
> - the pseudo_palette is always u32 regardless of bpp if using generic
>   drawing functions
>=20
> Signed-off-by: Antonino Daplas <adaplas@pol.net>

Looks good, thanks.

Acked-by: Paul Mundt <lethal@linux-sh.org>

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDjYIj1K+teJFxZ9wRAmN6AJ9H7WSdEF4Qy1v2ODCto+xKnQyZggCbBroT
K/AoTFP7vbZgIxlF39Jqq1U=
=UiM1
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
