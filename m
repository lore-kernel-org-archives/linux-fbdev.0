From: florin@iucha.net (Florin Iucha)
Subject: Re: Framebuffer updates.
Date: Tue, 25 Mar 2003 12:27:46 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030325182746.GA8769@iucha.net>
References: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iucha.net
	([209.98.146.184] helo=mail.iucha.net ident=foobar)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xt9J-00069r-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 10:27:49 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2003 at 05:57:18PM +0000, James Simmons wrote:
>=20
> As usually I have a patch avalaible at=20
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>=20
>  drivers/video/aty/aty128fb.c  |   16 +++++++---------
>  drivers/video/console/fbcon.c |    4 ++--
>  drivers/video/controlfb.c     |   18 +++---------------
>  drivers/video/platinumfb.c    |   28 ++++++++--------------------
>  drivers/video/radeonfb.c      |   10 ++++++++++
>  drivers/video/softcursor.c    |    2 +-
>  6 files changed, 31 insertions(+), 47 deletions(-)
>=20
> The patch has updates for the ATI Rage 128, Control, and Platnium=20
> framebuffer driver. The Radeon patch adds PLL times for the R* series of
> cards. Memory is now safe to allocate for the software cursor and inside=
=20
> fbcon. There still are issues with syncing which cause the cursor on some=
=20
> systems to become corrupt sometimes.=20

Where can I find working "modelines" for Radeon 8500?

I have a=20
   radeonfb: ATI Radeon 8500 QL DDR SGRAM 64 MB

I am interested in 1024x768 and 1152x864. I have tried the defaults
that come with Debian fbset (2.1-8) but I get garbled screen upon
changing the video mode. I can 'clear' the console and work more or
less normally but the viewport will be just a part of the whole
screen.

Thanks,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gJ+iNLPgdTuQ3+QRAtAIAKCLj0hZ5b6YDf2Yk/wR2Y+P+LE1egCfS4ck
+wLk2S8jQHwZdSrg++HVfpM=
=A64A
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
