From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 08 May 2017 14:30:58 +0000
Subject: Re: [PATCH v10 3/3] backlight arcxcnn add support for ArcticSand devices
Message-Id: <20170508143058.3as24eijzndare4f@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1493823859-22402-1-git-send-email-olimpiu@arcticsand.com>
 <1493823859-22402-3-git-send-email-olimpiu@arcticsand.com>
 <20170505075712.xroroafofrkfxux4@dell>
 <000001d2c5c1$e00500f0$a00f02d0$@arcticsand.com>
In-Reply-To: <000001d2c5c1$e00500f0$a00f02d0$@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu@arcticsand.com>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, Brian Dodge <bdodge@arcticsand.com>, joe@perches.com, daniel.thompson@linaro.org, lkp@intel.com, fengguang.wu@intel.com

On Fri, 05 May 2017, Olimpiu Dejeu wrote:

> >> backlight: Add support for Arctic Sand LED backlight driver chips
>=20
> >This should be the subject line of the patch.
>=20
> >Out of interest, how are you submitting your patches?
>=20
> >If you're not already, you should be using:
>=20
>  > `git format-patch ...`
>  > `git send-email ...`
>  =20
> >> This driver provides support for the Arctic Sand arc2c0608 chip,=20
> >>     and provides a framework to support future devices.
>=20
> >'\n' here.
>=20
> >> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> >> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
>=20
> >Biggest point however is that this patch is already in Mainline.
>=20
> The only reason for this set of patches is based on the request from Rob =
Herring for vendor name change from 'arc' to 'arctic'. Not sure how to proc=
eed, please advise.

You need to only re-send the patches which have not been accepted
already.  So fix the comments I gave you on the vendor name patch and
only re-send that one.

> >> ---
> >> v9 =3D> v10:
> >> - Per Rob Herring's request changed vendor-prefix to arctic
> >> v8 =3D> v9:
> >> - Addressing kbuild test robot WARNING: PTR_ERR_OR_ZERO can be used
> >> v7 =3D> v8:
> >> - Version updated to match other patch in set. No other changes.
> >> v6 =3D> v7:
> >> - Addressing issues brought up by Daniel Thompson
> >> v5 =3D> v6:
> >> - Addressing issues brought up by Daniel Thompson
> >> v4 =3D> v5:
> >> - Code style changes per Joe Perches and Jingoo Han
> >> v3 =3D> v4:
> >> - Code style changes per Joe Perches and Jingoo Han
> >> v2 =3D> v3:
> >> - Renamed variables to comply with conventions on naming
> >> - Corrected device name in arcxcnn.h
> >> v1 =3D> v2:
> >> - Removed "magic numbers" to initialize registers
> >> - Cleaned up device tree bindings
> >> - Fixed code style to address comments and pass "checkpatch"
> >> - Removed unneeded debug and testing code
> >>=20
> >>=20
> >>  drivers/video/backlight/Kconfig      |   7 +
> >>  drivers/video/backlight/Makefile     |   1 +
> >>  drivers/video/backlight/arcxcnn_bl.c | 419=20
> >> +++++++++++++++++++++++++++++++++++
> >>  3 files changed, 427 insertions(+)
> >>  create mode 100644 drivers/video/backlight/arcxcnn_bl.c
> >>=20
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
