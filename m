From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Nov 2016 08:21:33 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <508207ae-7667-c2ac-1e5c-cba28ed05a52@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0Xb3qFVjh9PAFCBxH3816XON7I7kVRoer"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123081932.byoasvcl322hrlin@phenom.ffwll.local>
In-Reply-To: <20161123081932.byoasvcl322hrlin@phenom.ffwll.local>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, linux-kernel@vger.kernel.org

--0Xb3qFVjh9PAFCBxH3816XON7I7kVRoer
Content-Type: multipart/mixed; boundary="Anho68XRfRE8Rk7XSETgwO9LMAWApqOrO";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Arnaud Patard <arnaud.patard@rtp-net.org>, linux-kernel@vger.kernel.org
Message-ID: <508207ae-7667-c2ac-1e5c-cba28ed05a52@ti.com>
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123081932.byoasvcl322hrlin@phenom.ffwll.local>
In-Reply-To: <20161123081932.byoasvcl322hrlin@phenom.ffwll.local>

--Anho68XRfRE8Rk7XSETgwO9LMAWApqOrO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/11/16 10:19, Daniel Vetter wrote:
> On Wed, Nov 23, 2016 at 10:03:10AM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> Since the fbdev framework is in maintenance mode and all new display d=
rivers
>> should be made with the DRM framework, remove the fbdev drivers from s=
taging.
>>
>> Note: the patches are created with git format-patch -D, so they can't =
be
>> applied. Only for review.
>=20
> +1 from my side. Now that we have the simple pipe helpers in drm-kms, a=
nd
> a few drivers starting to use them, there's really no reasons left anym=
ore
> to have fbdev drivers.

Well, I think there's the MMU problem. If I recall right, someone said
DRM doesn't compile/work without MMU.

 Tomi


--Anho68XRfRE8Rk7XSETgwO9LMAWApqOrO--

--0Xb3qFVjh9PAFCBxH3816XON7I7kVRoer
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNVGNAAoJEPo9qoy8lh71h2kQAKqUy7Soxf9TKp8BIKsuZSUv
OI1i0PSPoFP+QscjiuTPjhE7gc33rA37HB8QHRWirY5vTtGtIZOi9L4CHWSPm3Zd
UjH57h92W374SMIvx9/ORB70l1/7p6iBd4owPnil8xBKjY/ZzQSZcpgTJYnxyTKp
SQLUvFoafXMzOkFrq+Ns9K91xBH2F+912l0HH7b/YaDI/xpVPGqu/MxENR/3axx8
7CWBGXXIs6YRmhJxEPHUiVz9+J9KJPfqCJ3lfW7Sq2jpRH63LKXbltRo6ZDptA8a
WC0DnvgbaNgFdvmUrocKKEGf7m18FPXgctEVXF122j8RXmJnXAcVgnorDm1AfQP9
/GQeFd1MOercL+6WFyJwO8GojtrA8wuJHBE4+bF8oEcFXTSzB+6bxL3adV3WFmmU
Re5Z0gkgiOh0qMPQdAUvGzr9rvmqlLCvHhco+GQiRsuhNJ4AIDtg80usrOlHoKAq
UI40UYEhfBHAK+lTKneV7ViLlxM52jtn5eThHhC44AnBFwxKVpO3uLZ+IFbBmwkP
14Nlfc46Fq9FtQ7fZsWA4j2WeOMNwkTCaNtfhpDhV92lskjuxjhBcFWJB9SoS3ME
fwae+kpsu80A1m6e1La5yGH6z5CTcVHwUVVCFUmyC23hgx00LijF7Uck3DNk1CA4
Z7y4zVc9IKKW+jiZQTkF
=ZDln
-----END PGP SIGNATURE-----

--0Xb3qFVjh9PAFCBxH3816XON7I7kVRoer--
