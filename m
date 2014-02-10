From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Feb 2014 12:43:27 +0000
Subject: Re: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <52F8C96F.7050107@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="n4siHe6TcpdWBAF1CtoEwjJNEpEa5rGrl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com> <1389698184-28761-5-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389698184-28761-5-git-send-email-zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

--n4siHe6TcpdWBAF1CtoEwjJNEpEa5rGrl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/01/14 13:16, Zhou Zhu wrote:
> add device tree support for mmp fb/controller
> the description of DT config is at
> Documentation/devicetree/bindings/fb/mmp-disp.txt
>=20
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> ---
>  Documentation/devicetree/bindings/fb/mmp-disp.txt |   60 ++++++++
>  drivers/video/mmp/fb/mmpfb.c                      |   73 ++++++----
>  drivers/video/mmp/hw/mmp_ctrl.c                   |  160 +++++++++++++=
+++-----
>  3 files changed, 235 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt
>=20
> diff --git a/Documentation/devicetree/bindings/fb/mmp-disp.txt b/Docume=
ntation/devicetree/bindings/fb/mmp-disp.txt
> new file mode 100644
> index 0000000..80702f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fb/mmp-disp.txt
> @@ -0,0 +1,60 @@
> +* Marvell MMP Display (MMP_DISP)
> +
> +To config mmp display, 3 parts are required to be set in dts:
> +1. mmp fb
> +Required properties:
> +- compatible: Should be "marvell,<soc>-fb".
> +- marvell,path: Should be the path this fb connecting to.
> +- marvell,overlay-id: Should be the id of overlay this fb is on.
> +- marvell,dmafetch-id: Should be the dma fetch id this fb using.
> +- marvell,default-pixfmt: Should be the default pixel format when this=
 fb is
> +turned on.
> +
> +2. mmp controller
> +Required properties:
> +- compatible: Should be "marvell,<soc>-disp".
> +- reg: Should be address and length of the register set for this contr=
oller.
> +- interrupts: Should be interrupt of this controller.
> +
> +Required sub-node:
> +- path:
> +Required properties in this sub-node:
> +-- marvell,overlay_num: Should be number of overlay this path has.

If that one tells how many overlays there are, maybe "num_overlays"
would be better.

> +-- marvell,output-type: Should be output-type settings
> +-- marvell,path-config: Should be path-config settings
> +-- marvell,link-config: Should be link-config settings
> +-- marvell,rbswap: Should be rbswap settings

If these terms (output-type, path-config, ...) are straight from the HW
manual, then fine. But if they are not clear, or are driver specific,
the values these can have should be documented here.

> +
> +3. panel
> +Required properties:
> +- marvell,path: Should be path that this panel connected to.
> +- other properties each panel has.
> +
> +Examples:
> +
> +fb: mmp-fb {
> +	compatible =3D "marvell,pxa988-fb";
> +	marvell,path =3D <&path1>;
> +	marvell,overlay-id =3D <0>;
> +	marvell,dmafetch-id =3D <1>;
> +	marvell,default-pixfmt =3D <0x108>;
> +};
> +
> +disp: mmp-disp@d420b000 {
> +	compatible =3D "marvell,pxa988-disp";
> +	reg =3D <0xd420b000 0x1fc>;
> +	interrupts =3D <0 41 0x4>;
> +	path1: mmp-pnpath {
> +		marvell,overlay-num =3D <2>;
> +		marvell,output-type =3D <0>;
> +		marvell,path-config =3D <0x20000000>;
> +		marvell,link-config =3D <0x60000001>;
> +		marvell,rbswap =3D <0>;
> +	};
> +};
> +
> +panel: <panel-name> {

How is the panel linked to all this? The nodes above do not refer to the
panel.

> +	...
> +	marvell,path =3D <&path1>;
> +	...
> +};

It's a bit difficult to say much about this, as I have no knowledge
about mmp.

But I don't quite understand what the pxa988-fb is. Is that some kind of
virtual device, only used to set up fbdev side? And pxa988-disp is the
actual hardware device?

If so, I don't really think pxa988-fb should exist in the DT data at
all, as it's not a hardware device.

Why isn't there just one node for pxa988-disp, which would contain all
the above information?

 Tomi



--n4siHe6TcpdWBAF1CtoEwjJNEpEa5rGrl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+MlvAAoJEPo9qoy8lh71g3UQAI8qIu5jwlN23mcvzIMmm/j1
2EoYIU9jgSJVls6aVOcmCJkAc+lD4f5CVnZO8sRGRwF4HuWY6Tss+aThQ8RfK88h
aRGHs4B+aXrunJr17X71cAW10zVdbaAoABbnY7dKdA+3Hvy606Dl4xoqQQ1GlVto
Yl0vwP5SyjELloM4w887FPE7dp1LFE+4c8tkmPpvUEkfd95GmpUb82jp+1NaGcPl
RGN+IWoN9LUSSQTdRed2fCggCjC81HFjb/E+isUHlxu35VHfLk2a4RS3XAUIAlFO
wCkUH1BceNpSc/eEEs9kCHaMM+FnhMWq8jhA/XIiLt5AqliCmu+TXX4hut+7/Ggw
t9Sm6XcE4uRmIn4AISmSuzLT1dabyA8R/4eQjOYK3ZhU9xq4HgTfC5EFh7kbyczl
cOJay8NHGAjIHD6Y2Q6ePVVo4YhHJllVIEvgs/76MaHzch8rblQebOLF1w5keh8n
eudYt/hiloN1VSCXomzP9wK0XcM4rIosrSOYpJ8nNVyJI3q+HSk21iJqSJATvWQ2
6LauhO1+DyGOC6KpyDLrEL01UP4HWioFjuQmZk6nKsauk7EKCrHrMHlK0LVkAmRl
s/Ok2cBwvdaAIgOMlCqfr5k4Anx37W6gffzw7KP0T5rIZZVtwEFP1/ib58Ij9t9b
2ppojoM8yP3rvXFO1ds5
=dYSz
-----END PGP SIGNATURE-----

--n4siHe6TcpdWBAF1CtoEwjJNEpEa5rGrl--
