From: Keith Packard <keithp@keithp.com>
Date: Thu, 15 Sep 2011 18:12:10 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <yunwrd965fp.fsf@aiko.keithp.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti> <yunboul7sx7.fsf@aiko.keithp.com> <1316100594.23214.65.camel@deskari> <yun8vpp7qk7.fsf@aiko.keithp.com> <4E72320B.6020000@gmx.de>
In-Reply-To: <4E72320B.6020000@gmx.de>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-dev@lists.linaro.org, "Clark, Rob" <rob@ti.com>, Archit Taneja <archit@ti.com>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Sep 2011 17:12:43 +0000, Florian Tobias Schandinat <FlorianSchan=
dinat@gmx.de> wrote:

> Interesting that this comes from the people that pushed the latest mode s=
etting
> code into the kernel. But I don't think that this will happen, the expose=
d user
> interfaces will be around for decades and the infrastructure code could be
> shared, in theory.

We moved mode setting code from user space to kernel space -- the DRM
stuff comes directly from X, which has a fairly long history of
complicated display environments.

The DRM code does expose fb interfaces to both kernel and user mode,
figuring out how to integrate v4l2 and drm seems like the remaining
challenge.

> For fb and V4L2 I think we'll develop some level of interoperability, sha=
re
> concepts and maybe even some code. The FOURCC pixel formats and overlays =
are
> such examples. As Laurent is really interested in it I think we can get s=
ome
> nice progress here.

Jesse's design for the DRM overlay code will expose the pixel formats as
FOURCC codes so that DRM and v4l2 can interoperate -- we've got a lot of
hardware that has both video decode and 3D acceleration, so those are
going to get integrated somehow. And, we have to figure out how to share
buffers between these APIs to avoid copying data with the CPU.

DRM provides fb interfaces, so you don't need to change fb at all --
hardware that requires the capabilities provided by DRM will use that
and not use any of the other fb code in the kernel.

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOcj/6Qp8BWwlsTdMRArbiAJ0SqnnRj1hbLzm8OTXYMB/815odiwCfS/yv
nf7Q5xYImP7hXamle3ducVw=
=GpFo
-----END PGP SIGNATURE-----
--=-=-=--
