From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Dec 2015 07:14:06 +0000
Subject: Re: [PATCH RFC 7/9] omapfb: move vrfb into omapfb
Message-Id: <566E6C3E.1080805@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sOpa5ldHmJvN6jJihx6T219g4thBvT0L2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <1449757535-5674-8-git-send-email-tomi.valkeinen@ti.com>
 <26366528.DG0zY3a8a2@avalon>
In-Reply-To: <26366528.DG0zY3a8a2@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--sOpa5ldHmJvN6jJihx6T219g4thBvT0L2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/12/15 21:13, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> Thank you for the patch.
>=20
> On Thursday 10 December 2015 16:25:33 Tomi Valkeinen wrote:
>> VRFB is only used by omapfb, so we can move it under omapfb's director=
y.
>=20
> Do you see any specific blocker for support of vrfb in omapdss, apart f=
rom=20
> finding time (and a reason) to implement it ?

You probably mean omapdrm. No, no other reasons.

 Tomi


--sOpa5ldHmJvN6jJihx6T219g4thBvT0L2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWbmw+AAoJEPo9qoy8lh71FusQAJhX1Z5iTpXoTPEDzDC3LM9I
kfYvLwCIPQIegOX1N0x3xdnnQ8yBp8zfGEJmYav7eaL2ScjaX51EklLYY8sQHPOL
4PvC6wfKPXn7ffyRLXmGVWjZiLo+qPP4Y7fhDcr+qsIfhhg+9VHBh92Vn0DBUyjM
IOCH1OWr97wGqENnnIrF3a4NGpwAA7amkhi74HBI6NZ62P8pinUTA+8v2ijNiydf
X0+qQ9AhegGcv10YpwUrP3AEWLfJEF3fCLTGFoX8K9eFD+Q7dGCn+ubJy+2cL6/k
leLonPkoMPfVLi3uk6r97iIvhuqSeoq9dBLF/98zhYKicjxHijfb6cSEsPwI5+yO
3cbwujoeHcqGfOBz8LMBgOa8plfNjZSVVN1vW/8GxuX0vsyVu6DSat0KVygSCC2o
mZ+G+s6hwmFOA2dx6ntmUpcmwgP9o3bnFDLUCmw2iKPPO/OrrvsRvHEALUsHQYTV
E2VdrRGolCCsB2GsmrryTqbdWwau1lkmrDfoxNoJWodxMG8Uwz0Mn89HBa7v6HvQ
0FYvxnqMNWP+e4AkXW16MXomlzbHbLaeVoLnV096UR1gvBDCp2lRbvBHANbZc9C4
eWLYIagPFxqCHx9yYil+x66Z04CFySZoUI8YjQy+XPIpG1xxrdFjVo5JojqsZ9Sf
zAQ5vuI9LV1MK7PxJ4uP
=81sU
-----END PGP SIGNATURE-----

--sOpa5ldHmJvN6jJihx6T219g4thBvT0L2--
