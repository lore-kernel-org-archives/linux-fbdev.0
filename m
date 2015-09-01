From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Sep 2015 10:52:56 +0000
Subject: Re: [PATCH v4] OMAPDSS: hdmi: Reconfigure and restart audio when display is enabled
Message-Id: <55E58388.7030301@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TcStdiwjOqBa7v3dAkFxXSlf1NPBNp6Mj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440771706-21388-1-git-send-email-jsarha@ti.com>
In-Reply-To: <1440771706-21388-1-git-send-email-jsarha@ti.com>
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com

--TcStdiwjOqBa7v3dAkFxXSlf1NPBNp6Mj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 28/08/15 17:21, Jyri Sarha wrote:
> Reconfigure and restart audio when display is enabled, if audio
> playback was active before. This is needed in a situation when an
> audio+video stream application opens the audio stream before the
> video. When video stream is opened the display mode may change and
> that aborts audio playback, because the display is momentarily
> turned off.
>=20
> The audio configuration is stored when it is successfully applied and
> a boolean is set when the audio playback is started and unset when
> stopped. This data is used to reconfigure the audio when display is
> re-enabled. The audio playback is aborted if the reconfiguration fails.=

>=20
> A new spin lock is introduced in order to protect state variables
> related to audio playback status. This is needed for the transition
> from display enabled state (when audio start/stop commands can be
> written to HW) to display disabled state (when audio start/stop
> commands update only the hdmi.audio_playing variable) to always
> serialize correctly with the start/stop audio commands. The already
> existing mutex can not be used, because the audio start and stop
> commands are executed in atomic context.
>=20
> For example: when display is turned back on we take the spinlock and
> we can be sure that the audio start/stop status will not change while
> we update the HW according to hdmi.audio_playing state and set
> hdmi.display_enabled to true. After releasing the lock
> hdmi.display_enabled is true and all audio_start and audio_stop
> commands write their stuff directly to HW.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
> Fixed one bad sentece in the description.
>=20
>  drivers/video/fbdev/omap2/dss/hdmi.h  |  9 ++++-
>  drivers/video/fbdev/omap2/dss/hdmi4.c | 66 +++++++++++++++++++++++++--=
---
>  drivers/video/fbdev/omap2/dss/hdmi5.c | 76 +++++++++++++++++++++++++++=
+-------
>  3 files changed, 124 insertions(+), 27 deletions(-)

Thanks, I've queued this for 4.4.

 Tomi


--TcStdiwjOqBa7v3dAkFxXSlf1NPBNp6Mj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5YOIAAoJEPo9qoy8lh71DiwQAJGlo4ScwI6z+7waHZ8Z6KO1
q604LRQbuTjNFpq64rugiTdN4OKd+dnr6m8AjGVpVS7YnFGrOS29HCZZeumpumrP
eHv9LHy3CF/TcQ1WxZXNY1m3CSyyFNOOTy7eERqUHW6ZzhlYMlZlx9+ohU1pvCAM
R4Q6loOUtT3LCpN8MTs5mpOSXqB1tfYCa/wcCgqlCge91nAvbp4eLG1pWucjSNCc
XrPTyerA0jqaqmT222fwE1Ze73b95U/3abcNfl3YCzsgviCZcL10GWeN3Hs44Jb5
VAN52c5Gqfk2gkBAR4gdm3nOHczo5ja97C4nSsasvwn9uNYixgK0x1aMJKn1b85n
vXptQs4WybYcvfkmq3dMwRM6JwkPygJFEYZMPlZ+u8QEwmGaOW4SzPWE7r20JDVC
P7jDp8p+RPpKkW7xNSBdxlcBxtAFaK/sf4+2NnZKC1xRDnPJBVJ7VYTG4Rt9E9QH
tuau6BqIZNiM3rYmnKN6WMLTuzXcfqqQaGPQH/1IiD+e/N2mp2CkN7/Jw+LvYmg+
ZMC6OHGag0xdRes+1lgw5c9xcNBrVrw64jlbNfJlgWqBWTKCJrnDcanPR6TmMCEX
5p5w+T6B+mDN3e7JpDhdfo63IQtX93Gg7MKCPW0UR0jWNMbdlWTlkGWPg8JNNahf
vaMDo6uxvuPm7idsD0wh
=lMYi
-----END PGP SIGNATURE-----

--TcStdiwjOqBa7v3dAkFxXSlf1NPBNp6Mj--
