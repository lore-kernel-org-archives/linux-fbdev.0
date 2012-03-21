From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 21 Mar 2012 12:58:19 +0000
Subject: Re: [PATCH] OMAPDSS: OMAPFB: check for matching memory size early
Message-Id: <1332334699.2236.16.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-N5pugJoh3/hsZzAyTOlp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331253769-9770-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1331253769-9770-1-git-send-email-notasas@gmail.com>
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-N5pugJoh3/hsZzAyTOlp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2012-03-09 at 02:42 +0200, Grazvydas Ignotas wrote:
> If the size of memory region that is being set up is the same as before,
> we don't have to do memory and layer busy checks.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> I'm not sure if this is semantically correct, but this helps to get
> some old programs working, that rely on old DSS version which didn't
> check for mmap lock, but incidentally they are using same size too..

Well, I wouldn't allow code like that if it was a new ioctl, but if, as
you say, the old omapfb worked that way, then I think it's better to do
things the same way.

I can see no harm in it, so I'll apply.

 Tomi


--=-N5pugJoh3/hsZzAyTOlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPadBrAAoJEPo9qoy8lh71nDIQAJYs44hFjPrcY0MY3i/3JqDZ
bKWr7+T6e+2k7krpmP4hNfo+vFN3+G8Eo4f3TW+I210vVR0xisA5aqspEV27IYnq
D1GfFTj37187VG6aROrm4X0rrz6JE62ykTLU2Yg5qI/dzQt2f9oRMj3zFLs4a/p3
geT1Fh4eI1XgyfWO+bxwTDQWLuKlL2wJmQXsQAPy/fAzQ90sTbxJEYMOdp2BO2aB
aP+NDX3M+P6My8Dy3kXepAxuZ8znEwP8xW85KFjlJauGh7MvKdpVhB2mQgcBqPEQ
2JIWz8mmZ3JqB3di5Mlm4NV/Nl6EDJE3PsH9sdWjMe+3ki7GcF7NJBr4RDRrjBEg
2DCB8asLDiK5RRHKq73LjpC0p0dhpn3v0+sIKvzIqUQkuHxLL7LPfKYQQ2zv1IeZ
HforkXbpNkmQznenP1QcFmGVOq9yWaRUFckiOpnoKedIc78SqGOeYV86XfdWGDMb
AbX2/WaajvgU1i/qHuq+yt5Wf4fJYiwqjm8HAwyHHg3jM06KvN5kRTg5D1qd2a7i
VuHV+2YQYVvWfvuTvzkTUc93s99Sbfi2LEzJVDzr9lom2hVDKAuYt/9ATOVJOrmo
OsxDo8DRzGYxiNk8WwOOaFDtv4K1fX+1pxknLnym0PSHl+DtSDkBDstaLQaQqhbd
1sNkut+TW4a3SQyvaDAP
=HPGL
-----END PGP SIGNATURE-----

--=-N5pugJoh3/hsZzAyTOlp--

