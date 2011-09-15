From: Keith Packard <keithp@keithp.com>
Date: Thu, 15 Sep 2011 15:50:32 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <yun8vpp7qk7.fsf@aiko.keithp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti> <yunboul7sx7.fsf@aiko.keithp.com> <1316100594.23214.65.camel@deskari>
In-Reply-To: <1316100594.23214.65.camel@deskari>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-dev@lists.linaro.org, "Clark, Rob" <rob@ti.com>, Archit Taneja <archit@ti.com>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Sep 2011 18:29:54 +0300, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:

> 1) It's part of DRM, so it doesn't help fb or v4l2 drivers. Except if
> the plan is to make DRM the core Linux display framework, upon which
> everything else is built, and fb and v4l2 are changed to use DRM.

I'd like to think we could make DRM the underlying display framework;
it already exposes an fb interface, and with overlays, a bit more of the
v4l2 stuff is done as well. Certainly eliminating three copies of mode
setting infrastructure would be nice...

> But even if it was done like that, I see that it's combining two
> separate things: 1) the lower level HW control, and 2) the upper level
> buffer management, policies and userspace interfaces.

Those are split between the DRM layer and the underlying device driver,
which provides both kernel (via fb) and user space interfaces.

> 2) It's missing the panel driver part. This is rather important on
> embedded systems, as the panels often are not "dummy" panels, but they
> need things like custom initialization, sending commands to adjust
> backlight, etc.

We integrate the panel (and other video output) drivers into the device
drivers. With desktop chips, they're not easily separable. None of the
desktop output drivers are simple; things like DisplayPort require link
training, and everyone needs EDID. We share some of that code in the DRM
layer today, and it would be nice to share even more.

We should figure out if the DRM interfaces are sufficient for your
needs; they're pretty flexible at this point.

Of course, backlight remains a mess in the desktop world; with many
custom backlight drivers along with generic ACPI and then
per-video-device drivers as well.

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOch7JQp8BWwlsTdMRAtirAJ9t/Y9/5k6NowfUcxMhQ+g5+tDvXgCdEXqG
6/s9sy8CHA1RKmF4tuwRwYk=
=usgI
-----END PGP SIGNATURE-----
--=-=-=--
