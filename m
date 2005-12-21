From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] radeonfb ATI 9100IGP shared main memory / VRAM
Date: Wed, 21 Dec 2005 23:26:39 +0100
Message-ID: <20051221222639.GT4495@sunbeam.de.gnumonks.org>
References: <20051221203706.GR4495@sunbeam.de.gnumonks.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U7F658e60E1K4csu"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EpCQ0-0006BA-QG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 14:26:44 -0800
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EpCPy-0004nB-7x
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Dec 2005 14:26:44 -0800
Content-Disposition: inline
In-Reply-To: <20051221203706.GR4495@sunbeam.de.gnumonks.org>
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
To: "Ben. Herrenschmidt" <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


--U7F658e60E1K4csu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2005 at 09:37:06PM +0100, Harald Welte wrote:
> I've altered radeon_base.c with a special exception for this chip, see
> the patch below.  Now everything works like a charm.

unfortunately I now discovered that the PCI resource is always 64MB in
size, even when the UMA BIOS setting is configured to smaller (e.g. 8MB)
sizes.

I don't have a clue for a proper fix, but maybe you have ;)

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--U7F658e60E1K4csu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDqdafXaXGVTD0i/8RAgmYAJ9KwXuAR7rxUARvbLYPHrXwg72MIQCgtQmx
qCVrTXpmKkPQrml9r45ViTc=
=VwPV
-----END PGP SIGNATURE-----

--U7F658e60E1K4csu--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
