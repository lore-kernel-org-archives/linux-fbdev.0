From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 09:07:49 +0000
Subject: Re: [PATCH 2/2] drivers: video: fbdev: vga: fixed coding style
Message-Id: <55D598E5.4010209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QMPgdWFQ5Whq7tWPNcrgPtGvrGXICQJPh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436592450-5388-1-git-send-email-cristian97.ardelean@gmail.com>
In-Reply-To: <1436592450-5388-1-git-send-email-cristian97.ardelean@gmail.com>
To: Cristian Ardelean <cristian97.ardelean@gmail.com>, plagnioj@jcrosoft.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--QMPgdWFQ5Whq7tWPNcrgPtGvrGXICQJPh
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/07/15 08:27, Cristian Ardelean wrote:
> Fixed most of the coding style issues suggested by checkpatch.pl
> tool. Mainly converted spaces to tabs. Left remaining errors and
> warnings up to decision of the developers.
>=20
> Signed-off-by: Cristian Ardelean <cristian97.ardelean@gmail.com>
> ---
>  drivers/video/fbdev/vga16fb.c |  386 ++++++++++++++++++++-------------=
--------
>  1 file changed, 193 insertions(+), 193 deletions(-)

I don't want patches that clean up formatting for random old drivers.
For drivers that are in active development such patches may make sense,
but this one is just needless change, possibly causing conflicts.

 Tomi


--QMPgdWFQ5Whq7tWPNcrgPtGvrGXICQJPh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1ZjlAAoJEPo9qoy8lh71vWEP/1Nnjwga6wyDw0C220ssWAvS
0PAreqWGSEH5gtahfrTNqnJQNJ61011oYx3ptc9YOjbmKov7Cgu2hLh3CaXkI7Zk
h/+cJg0+Flb4bdh/rxmJiGRbo6oyUi2Y51mWdqhrmR9UWJW+96w2Ty24RoespXJS
gwOqh9FUakdm14m2hnOLfSwJvETo2CLXV7WzXbJp1mi47848z27fdT9/zvWFUZKn
giaP/+zc5/1WY/qJuW832KKDmm67CHi/4Oug9BAPzzAU7AOewm/+Rcm9j1SMt2lJ
4RCHpsNC+LmGMpBUA5M9N58AMiaMfRwt0kjwlPHYjOnh0u24HDlwpu5s1B96kxOw
5d4d9BRyyXe1XrmvxJ7Fkn12w/ihK9aMsOhvOmqXpz5Ua/8IzsorlIejaXvWIS4m
FkE6rjw2pjLDFPTyxw3p+CvfAr2lUL+hjQLmZVAD62Wk7YlE4x8LioVLXIay3Vgh
3t1W+0mKOwc8vaaFk0dggfwDuDSbJaqb76NyHoVydLlidFy0sr1f5IxY0U9Galrd
eJMMBeRl40STISPUH84mycSr2FrIqtOwArOXh1YH7vZ2b57Wr8SFeM3emuTNHqMj
tSYy9pqGMKRSZgOedTZAUiXYfkdCbXo3ttRKKfxfN6Z11qao5Q59sWsTWGBN05/L
aXQh6YTSFYvEHtjfuUgJ
=a3ql
-----END PGP SIGNATURE-----

--QMPgdWFQ5Whq7tWPNcrgPtGvrGXICQJPh--
