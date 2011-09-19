From: Keith Packard <keithp@keithp.com>
Date: Mon, 19 Sep 2011 06:53:27 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <yunfwjtauqg.fsf@aiko.keithp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>
	<yunboul7sx7.fsf@aiko.keithp.com>
	<1316100594.23214.65.camel@deskari>
	<yun8vpp7qk7.fsf@aiko.keithp.com>
	<1316107275.23214.99.camel@deskari>
	<yunfwjxwbjq.fsf@aiko.keithp.com>
	<20110916175326.54567b14@lxorguk.ukuu.org.uk>
	<1316414014.1978.12.camel@deskari>
In-Reply-To: <1316414014.1978.12.camel@deskari>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Sep 2011 09:33:34 +0300, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:

> I think it's a bit more complex than that. True, there are MIPI
> standards, for the video there are DPI, DBI, DSI, and for the commands
> there is DCS. And, as you mentioned, many panels need custom
> initialization, or support only parts of the DCS, or have other
> quirks.

So DSI is more like i2c than the DisplayPort aux channel or DDC. That
seems fine; you can create a DSI infrastructure like the i2c
infrastructure and then just have your display drivers use it to talk to
the panel. We might eventually end up with some shared DRM code to deal
with common DSI functions for display devices, like the EDID code
today, but that doesn't need to happen before you can write your first
DSI-using display driver.

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOdubnQp8BWwlsTdMRAusOAKCegZhdtYGIUQrd8gu69/RZ474TigCdFfyS
YiohI3JOdnyz+UzbK0fRb7A=
=wU+N
-----END PGP SIGNATURE-----
--=-=-=--
