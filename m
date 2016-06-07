From: Peter Jones <pjones@redhat.com>
Date: Tue, 07 Jun 2016 17:23:05 +0000
Subject: Re: [PATCH] [efifb] Fix 16 color palette entry calculation
Message-Id: <20160607172304.GD24886@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
In-Reply-To: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Max Staudt <mstaudt@suse.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, eich@suse.de, tiwai@suse.de, agraf@suse.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>

On Tue, Jun 07, 2016 at 03:45:43PM +0200, Max Staudt wrote:
> When using efifb with a 16-bit (5:6:5) visual, fbcon's text is rendered
> in the wrong colors - e.g. text gray (#aaaaaa) is rendered as green
> (#50bc50) and neighboring pixels have slightly different values
> (such as #50bc78).
>=20
> The reason is that fbcon loads its 16 color palette through
> efifb_setcolreg(), which in turn calculates a 32-bit value to write
> into memory for each palette index.
> Until now, this code could only handle 8-bit visuals and didn't mask
> overlapping values when ORing them.
>=20
> With this patch, fbcon displays the correct colors when a qemu VM is
> booted in 16-bit mode (in GRUB: "set gfxpayload=800x600x16").
>=20
> Signed-off-by: Max Staudt <mstaudt@suse.de>
> ---
>  drivers/video/fbdev/efifb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 924bad4..37a37c4 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -50,9 +50,9 @@ static int efifb_setcolreg(unsigned regno, unsigned red=
, unsigned green,
>  		return 1;
> =20
>  	if (regno < 16) {
> -		red   >>=3D 8;
> -		green >>=3D 8;
> -		blue  >>=3D 8;
> +		red   >>=3D 16 - info->var.red.length;
> +		green >>=3D 16 - info->var.green.length;
> +		blue  >>=3D 16 - info->var.blue.length;
>  		((u32 *)(info->pseudo_palette))[regno] >  			(red   << info->var.red.o=
ffset)   |
>  			(green << info->var.green.offset) |
> --=20
> 2.6.6

Looks right to me.

Acked-By: Peter Jones <pjones@redhat.com>

--=20
  Peter
