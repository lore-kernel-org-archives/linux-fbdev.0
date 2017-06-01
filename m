From: Mike Gerow <gerow@google.com>
Date: Thu, 01 Jun 2017 20:38:50 +0000
Subject: Re: [PATCH] video: fbdev: udlfb: drop log level for blanking
Message-Id: <20170601203850.GB10180@google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NDin8bjvE/0mNLFQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170601202559.GA96809@google.com>
In-Reply-To: <20170601202559.GA96809@google.com>
To: linux-fbdev@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It would also be far simpler (and perhaps better) to just drop the existing=
 log
to debug instead of this conditional nonsense. I'm mostly interested in bei=
ng
able to check a machine running for a few weeks and seeing the logs not be =
95%
"udlfb: /dev/fb1 FB_BLANK mode 0 --> 0".

--=20
Mike Gerow
gerow@google.com

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZMHtaAAoJECb8JZRr34gjHJwIAIExjpCVcclk1muzyehHWlEb
zAGIaKcq3Ss/ooNQHEXzFT2CpjE+Yz99Dag0VWTkGUPUVg0wlgczjcooEYSVSfgC
cD8/HCWZJY25xHaylPjakaKPwsorpNZ8oFTOIJcYMdSAeekWnsSofTeRdKf2abFw
hCHGDyZPWEFPL4QgDnb8aiX/9+Ix5FXhkhWwfhQbgz4Htz+uUbW/QxIhddoxL0v8
M17th03FoIgNrxxoU5imED0RMYoGBrdYa2FozXDf/gP4FEdgmO+Xtb6CQHtDdIdo
pNTJaFEg80vlcJJNK2gDZ3MpUYqtYrXnKTacOLL0DFyYp3Io/Z6XS+0DY1G29es=
=aHbr
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
