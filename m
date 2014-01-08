From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 08 Jan 2014 09:04:13 +0000
Subject: Re: [PATCH 0/2] video: mxsfb: fix broken videomode selection
Message-Id: <52CD148D.7060107@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GMq3TqRcUMdQXMwxcJqh5L0lPUnf2JAHD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org

--GMq3TqRcUMdQXMwxcJqh5L0lPUnf2JAHD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2014-01-06 15:17, Lothar Wa=C3=9Fmann wrote:
> The first patch in this set converts some messages that are printed
> in case of errors to be error messages rather than debug messages.
>=20
> The second patch fixes a bug in the video selection code that
> incorrectly OR's together the 'pixelclk-active' and 'de-active'
> flags from all possible video modes specified in DT into one flag.
>=20
> The current code does not allow selecting one specific mode from a
> list of video modes, but always uses the last one of the video modes
> listed in the DT.
>=20
>=20
> Since all current dts files only have one entry in their
> 'display-timings' node, this bug was not apparent and the fix does not
> change the driver's behaviour for the current users.
>=20
>  b/drivers/video/mxsfb.c |    6 +--
>  drivers/video/mxsfb.c   |  120 +++++++++++++++++++++++++++++----------=
-------------------------------
>  2 files changed, 53 insertions(+), 73 deletions(-)
>=20

Thanks, queued for 3.14.

Your diffstat above looks a bit funny. Where did that "b/" come from?

 Tomi



--GMq3TqRcUMdQXMwxcJqh5L0lPUnf2JAHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzRSNAAoJEPo9qoy8lh71ti0P/Rrj7HkaiwvhlokkLcSL5k1S
Xk5uwQHZNXWousKFOM8JQwlspYVCbaKXW6aBTOu60kBxcmqFvcCgCERSDqnOJoBT
8oQf3tRinL9knd7D/2E3etnc1rCrJFu2MVVPyaKMX4a7/qYyG1q3ZmxDIbtn6whD
lfV6qRaaHMkkUvHaf9GFS5sjdlV6JrPkpUkpsmbaNq6tnaglnrAZchBnX6vbDhor
in9zUfzbBNLhqVEs1JP11W0XHUytuTItLlueMxlLxt7WzsN2shTyy3S1NfNpcJuD
LTOHQcgiS0v4yl3Hzci1r6UMP9qt+4iK1jxmDug4mPbEWP3M0d667wbt0u5EKs8/
oD1KLvogy6H37d/+gkcRnlyXN64R2XXF9I6ywjj4tsUxnOqaWhspN/YgTSgffD50
Jj0+ewHm3wO+b1BLbf0HxML/xTRRs3RFeRtiWfLNBoGdoE172TN1XVx7jHMarHEh
7BcCZV8rfBXX+JXptJ1kGgDN5qJ+yHWCfdj8Soaie+w/vxGLqnwLCZs/rgm9yH6h
95dXWv0xneDjlLULF0zApE5XULOXTgXlaunscrMQ2YPtX1YQVuWh+3o5EmwI0VgV
g1X6rSQq1syz6I8TWTzuDQSRRc0acOj0xkqxDx6Y/QqNpiKLgxagErh/BrxgHiLI
3kBkWPsYA2Hdyq59PFD1
=s1co
-----END PGP SIGNATURE-----

--GMq3TqRcUMdQXMwxcJqh5L0lPUnf2JAHD--
