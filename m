From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 09 Jun 2017 07:35:34 +0000
Subject: Re: [PATCH v10 1/3] DT add arctic to vendor prefix for ArcticSand
Message-Id: <20170609073534.5as5icygbmcx5zs5@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1496931122-29094-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1496931122-29094-1-git-send-email-olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

On Thu, 08 Jun 2017, Olimpiu Dejeu wrote:

> dt-bindings: vendor-prefixes: add arctic to vendor prefix
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>=20
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> ---
> v9 =3D> v10:
> - (Re-submit) Per Rob Herring's request changed vendor-prefix to arctic
> v8 =3D> v9:
> - Version updated to match other patch in set. No other changes.
> v8:
> - Version to match other patches in set
>=20
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +

Applied, thanks.

>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docu=
mentation/devicetree/bindings/vendor-prefixes.txt
> index 16d3b5e..6f33a4b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -28,6 +28,7 @@ andestech	Andes Technology Corporation
>  apm	Applied Micro Circuits Corporation (APM)
>  aptina	Aptina Imaging
>  arasan	Arasan Chip Systems
> +arctic	Arctic Sand
>  aries	Aries Embedded GmbH
>  arm	ARM Ltd.
>  armadeus	ARMadeus Systems SARL

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
