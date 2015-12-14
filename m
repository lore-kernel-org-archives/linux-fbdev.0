From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Dec 2015 07:12:56 +0000
Subject: Re: [PATCH RFC 8/9] drm/omap: move omapdss & displays under omapdrm
Message-Id: <566E6BF8.40707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="etGFt2aubFx6M78X0eCU7rCGNIeUbeDT1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <1449757535-5674-9-git-send-email-tomi.valkeinen@ti.com>
 <13812119.EOZzmrY4TL@avalon>
In-Reply-To: <13812119.EOZzmrY4TL@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--etGFt2aubFx6M78X0eCU7rCGNIeUbeDT1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/12/15 21:08, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> Thank you for the patch.
>=20
> On Thursday 10 December 2015 16:25:34 Tomi Valkeinen wrote:
>> Now that omapfb has its own copy of omapdss and display drivers, we ca=
n
>> move omapdss and display drivers which omapdrm uses to omapdrm's
>> directory.
>>
>> We also need to change the main drm Makefile so that omapdrm directory=

>> is always entered, because omapdss has a file that always needs to be
>> built-in.
>=20
> Which file is that ? omapdss-boot-init.c ? I would say "that can't be b=
uilt as=20
> a module' instead of 'that always needs to be built-in' as the later im=
plies=20
> (at least for me) that the file always have to be built-in regardless o=
f=20
> whether omapdss support is enabled or not.

Yes, ompadss-boot-init.c. I'll change the wording.

 Tomi


--etGFt2aubFx6M78X0eCU7rCGNIeUbeDT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWbmv4AAoJEPo9qoy8lh71O2MP/2hPJUSQRkSm6UEM6XxMgwqg
D/UOB2RmhJbE65dStLsqQJIWd54fGwoXiiyDGz8vWj78A57grH3MmTBTu8MyHJ6i
fpVeObqO0IYGpynju9xJU9i1NesVDwFRoQzpf0+tw5ib2DcDu/g6BkLTsqmqGSMU
iN2pzBpyLE1osuNL1n6l5dj9QkS9Vcg/mYUPmj+LQH/LTKHpe6XhZuwhQo013RBI
vwvv1edyCUCRvm/K3kILmShFBsLXVkn8GKIsFjOxQf8xZNt5hY73JYzMSKbLKspf
YPw1Mx6JrtsmVdSEtMLF28tH+4WLcOXNLyq7GFy4dR7Lg+DXRo7hFZUTXwbDHfRN
W4Pjm7ZTNqA8cLTIoAKkPX6zmVo6RDS66Tg/qT2WHjUBvuBVYscx1aniBIZVPjlD
DmR8BTV3V3H2tkpwjbEPYqf/Plsoj25at30rEXloalD2ESd7ZdZtYEOyBOsEzTGG
/7R82KqSXrbpQC/QX7nOW0zhp+mK/CLpv2d/QDEcZ3y5E2qyAfy9LxeOmV0hkrfb
wOYjwXaMWZrhJw8yGzbdZaEAXTObPZ2c6Xne6n7jdiafHgphqsbDtA1/TmaHhXSj
ugyUvfgDNctv2xo8OpxTOlOkyKsljKBQnv7CHm4Yy8azj8od71jfjg6kxCtPKE8x
QCwE5zsOil++WOiflKvt
=fiGU
-----END PGP SIGNATURE-----

--etGFt2aubFx6M78X0eCU7rCGNIeUbeDT1--
