From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Mar 2014 10:21:34 +0000
Subject: Re: [PATCH v5 1/2] video: ARM CLCD: Add DT support
Message-Id: <53184C2E.3000807@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Akl0XEf6Nn5aTGssPp7GFb60uLQ0kXm0n"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org

--Akl0XEf6Nn5aTGssPp7GFb60uLQ0kXm0n
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Pawel,

On 05/03/14 18:23, Pawel Moll wrote:
> This patch adds basic DT bindings for the PL11x CLCD cells
> and make their fbdev driver use them.

Is this an old HW, and presumably there won't be new users for it? If
yes, this is probably fine. If not, you might want to look at the video
ports and endpoints, which is used by at least three not-yet-merged serie=
s:

[PATCHv3 00/41] OMAPDSS: DT support v3
[PATCH v5 00/11] imx-drm dt bindings
[RFC PATCH v2 00/21] Add DSI display support for Exynos based boards

Using bindings like that would be more future proof, even if the current
driver doesn't use them.

 Tomi



--Akl0XEf6Nn5aTGssPp7GFb60uLQ0kXm0n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGEwuAAoJEPo9qoy8lh71pdEP/2+bLsds4O6LJTNLLU4mTkCf
L+nkfM3QlX9GJlNXXJ8J9V0jrZwMgMXQBnXQyBxhYT2kEaOydtuMakKFSM70FvuZ
+o4XhHfH6DkzzJcz7OmNjfdKUQ4SmSbiPoGnheCv3TJA5UZRCeyYyO8VAACTNUDi
B9jWE2cR1h/HBQvgtwggoPfpA/GgjCwQhucoFIE7a5DXIEmaUR3ZVRY/raFatDub
0uIGZMkog9PYp+iRKTZwc0ogdqXBUoz/0xyGN+m+V1ZClP+QD9GaD0J7aWoR4IB1
GVIZ05I12xhZMM3YCHh6Prmv1urmzGop7Mrlv9iB/64KVXuUz9aF7blGtPi8tC2+
ZWrCHEN+cZBwLYhTbhd/T7ZOMbDybVGoRjaLlstqsVe2hdCISbLatS+4J16hR5X3
t3LurMdcP0cIULHyO7XFe3GSfBkKYVy1r1Md8RNFFQPvNs3KnTJA23I3bU+AIVdA
haAiGqijShmAS08iDMc0V99cAN+n6hlsjwNzQCDfGiBM9bYKY6yBH7Cceqr/NTh6
6gNY3tM4I/Sz4795g6gy1UQx96wHCXPhNlxH+2T/Re4T8mEYeY0aSV+BIIWvZMdp
onSJNrMbJBXryugWRnM6duO5ABoYgILSF/8p3iNPE1b35REcguWLry3u7VDf29Na
79Zmz71bR6agdtp8Ed8z
=tX/s
-----END PGP SIGNATURE-----

--Akl0XEf6Nn5aTGssPp7GFb60uLQ0kXm0n--
