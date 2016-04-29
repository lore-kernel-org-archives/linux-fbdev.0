From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Apr 2016 12:50:40 +0000
Subject: Re: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
Message-Id: <572358A0.8010002@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Abu5KBdOVweHtLui2tjNVutcUplXl08K8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-4-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461856717-6476-4-git-send-email-noralf@tronnes.org>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

--Abu5KBdOVweHtLui2tjNVutcUplXl08K8
Content-Type: multipart/mixed; boundary="bQku0Lp5rQvHBKlkVrNi2xVCbCOSsqjG6"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
 linux-kernel@vger.kernel.org
Message-ID: <572358A0.8010002@ti.com>
Subject: Re: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-4-git-send-email-noralf@tronnes.org>
In-Reply-To: <1461856717-6476-4-git-send-email-noralf@tronnes.org>

--bQku0Lp5rQvHBKlkVrNi2xVCbCOSsqjG6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/04/16 18:18, Noralf Tr=C3=B8nnes wrote:
> This adds deferred io support to drm_fb_helper.
> The fbdev framebuffer changes are flushed using the callback
> (struct drm_framebuffer *)->funcs->dirty() by a dedicated worker
> ensuring that it always runs in process context.
>=20
> Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---

Thanks for the series! Unfortunately I haven't been able to follow the
discussions properly, so I hope my questions haven't been covered earlier=
=2E

> Changes since v3:
> - Don't use forward decl, move drm_fb_helper_dirty_work()
> - Use DIV_ROUND_UP in drm_fb_helper_deferred_io()
>=20
> Changes since v2:
> - FB_DEFERRED_IO is now always selected by DRM_KMS_FB_HELPER, ifdef rem=
oved
> - The drm_clip_rect utility functions are dropped, so open code it
> - docs: use & to denote structs
>=20
> Changes since v1:
> - Use a dedicated worker to run the framebuffer flushing like qxl does
> - Add parameter descriptions to drm_fb_helper_deferred_io
>=20
>  drivers/gpu/drm/Kconfig         |   1 +
>  drivers/gpu/drm/drm_fb_helper.c | 103 ++++++++++++++++++++++++++++++++=
+++++++-
>  include/drm/drm_fb_helper.h     |  15 ++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 9e4f2f1..8e6f34b 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -52,6 +52,7 @@ config DRM_KMS_FB_HELPER
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select FB_DEFERRED_IO
>  	help
>  	  FBDEV helpers for KMS drivers.
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
> index 855108e..62f849f 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -84,6 +84,15 @@ static LIST_HEAD(kernel_fb_helper_list);
>   * and set up an initial configuration using the detected hardware, dr=
ivers
>   * should call drm_fb_helper_single_add_all_connectors() followed by
>   * drm_fb_helper_initial_config().
> + *
> + * If CONFIG_FB_DEFERRED_IO is enabled and &drm_framebuffer_funcs ->di=
rty is
> + * set, the drm_fb_helper_{cfb,sys}_{write,fillrect,copyarea,imageblit=
}
> + * functions will accumulate changes and schedule &fb_helper .dirty_wo=
rk to run
> + * right away. This worker then calls the dirty() function ensuring th=
at it
> + * will always run in process context since the fb_*() function could =
be
> + * running in atomic context. If drm_fb_helper_deferred_io() is used a=
s the

Who's calling {write,fillrect,copyarea,imageblit} in an atomic context?
That sounds like a very bad idea to me...

If this is only for accumulating changes, I think it may be better to
leave that to the driver as it may have better idea of how to accumulate.=


But, of course, this is a helper, so if all the drivers use this kind of
accumulation, it makes sense =3D).

 Tomi


--bQku0Lp5rQvHBKlkVrNi2xVCbCOSsqjG6--

--Abu5KBdOVweHtLui2tjNVutcUplXl08K8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXI1igAAoJEPo9qoy8lh719HoP/2s2o6/NYTYTNunkTLMRY4Gt
PPcjFaE/gvqGy/Q072lSzg4upkTLpUoCXv0onKf/J7uWy8amUcMPjduJEJvrz64t
cT0//Puy0GE3qv8LGGnaiRn5CpncmyfIWhEEZG4/2J3oSw8c8UmqYpJ76RaKFWEB
CF+Fh03sb3l5NbL2ijSqvCGk+bnjw/3ebGD2do6O3YUl91q6EGJe0M0Ptgp2WoIz
EKPtOiGJbG4RyeZSQOBzSNX6y2SB+NZTXMqmc11GhwnyKRkiEXGv3OOPgzVmaRIv
y8DFDkatDL6CtFf7N7YqGv/Tr75hngjBAKFr4ISa6w17A6QkAGpa55IkInYavKVQ
Hls31yBFY7Mvm+XetkTZkK4ffAuE3aYwP4LQjEFDWD2nWUk+Orm5MXg8L+ATtP0D
sEXhbwAyIvnes+O4fxbnXHlngd6/h3iX2RKlVGWljHbiHlB9b9o4rcdY3RvCTtXx
l/Lb6Ny0MZVvy2zFquGrujTUH28n970950abz2eUasBfeqCapyQjWhRCpbqx2qzi
wxPX8fNQ/LlWOGiBzQtXZiCT8axXW8ZHD9bEg+TrQU2+ImQeaESTUNbD2jx6cD8x
OTI5LFeh6Mf8MRjCKkPZs0Oe+dZiMlg0dyEakGkpE53pMk8/UdmjbYs5T+EQnSP7
V7zE2nVXbM6t44CkeqdV
=BG+6
-----END PGP SIGNATURE-----

--Abu5KBdOVweHtLui2tjNVutcUplXl08K8--
