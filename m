From: Adam Jackson <ajax@redhat.com>
Date: Wed, 22 Feb 2012 17:00:17 +0000
Subject: Re: Kernel Display and Video API Consolidation mini-summit at ELC 2012 - Notes
Message-Id: <1329930017.30884.84.camel@atropine>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-gzt8ttsgsYrpcFpaBmPL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <201201171126.42675.laurent.pinchart@ideasonboard.com>
	 <1775349.d0yvHiVdjB@avalon> <20120217095554.GA5511@phenom.ffwll.local>
	 <2168398.Pv8ir5xFGf@avalon>
	 <alpine.LFD.2.02.1202221559510.3721@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.02.1202221559510.3721@casper.infradead.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomasz Stanislawski <t.stanislaws@samsung.com>, linux-fbdev@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Pawel Osciak <pawel@osciak.com>, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, Alexander Deucher <alexander.deucher@amd.com>, Rob Clark <rob@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-media@vger.kernel.org


--=-gzt8ttsgsYrpcFpaBmPL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-22 at 16:03 +0000, James Simmons wrote:

> Fbcon scrolling at be painful at HD or better modes. Fbcon needs 3=20
> possible accels; copyarea, imageblit, and fillrect. The first two could b=
e=20
> hooked from the TTM layer. Its something I plan to experiment to see if=
=20
> its worth it.

In my ideal world, the "framebuffer console" is something like vte under
wayland, which avoids this entirely.  Scrolling on early boot until you
manage to get into initramfs would still be slow, but whatever, that's a
debugging feature anyway.

- ajax

--=-gzt8ttsgsYrpcFpaBmPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk9FHyIACgkQW4otUKDs0NMJ+gCcCFwB/UYrLZdqCRXHaHTw2Tww
yb4AoIjvACDS/dvbZVePv9XOJizEnnAm
=dTsh
-----END PGP SIGNATURE-----

--=-gzt8ttsgsYrpcFpaBmPL--

