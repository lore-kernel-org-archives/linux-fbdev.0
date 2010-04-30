From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 30 Apr 2010 18:07:02 +0000
Subject: Re: [PATCH 13/30] viafb: Separate global and fb-specific data
Message-Id: <4BDB1C46.8020101@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>	<1272493051-25380-14-git-send-email-corbet@lwn.net>	<20100429201902.6379f8d3@neptune.home> <20100430102157.5eb59055@bike.lwn.net>
In-Reply-To: <20100430102157.5eb59055@bike.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Corbet <corbet@lwn.net>
Cc: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Hi,

Jonathan Corbet schrieb:
> On Thu, 29 Apr 2010 20:19:02 +0200
> Bruno Pr=E9mont <bonbons@linux-vserver.org> wrote:
>=20
>>> +	vdev->engine_start =3D pci_resource_start(vdev->pdev, 1);
>>> +	vdev->engine_len =3D pci_resource_len(vdev->pdev, 1);
>>> +	/* If this fails, others will notice later */
>>> +	vdev->engine_mmio =3D ioremap_nocache(vdev->engine_start,
>>> +			vdev->engine_len);
>> Shouldn't this ioremap_nocache() have error-checking
>> as the one below (instead of relying on later code to bail out)?
>=20
> It would be better, yes, I'll add a patch to fix it up.

Please don't do this. The reason for not failing in viafb is that=20
ioremap failure of the engine is not critical it just disables the=20
hardware acceleration but otherwiese it works quite nice. The problem is=20
that ioremap failures are quite common as we really try to remap huge=20
amount (sometimes above 128 or even 256 MB). In fact the bug (or missing=20
feature) is that the first ioremap is fatal and that needs to be fixed=20
on the long run. Sorry but I don't want to make viafb unusable for many=20
people if they don't add the "vmalloc=3D" kernel option so failing here=20
would be a step in the wrong direction.


Thanks,

Florian Tobias Schandinat

> viafb: Fix initialization error paths
>=20
> Properly localize error cleanup, and make sure that the iomem regions are
> unmapped if framebuffer initialization fails.
>=20
> Reported-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  drivers/video/via/via-core.c |   26 ++++++++++++++++----------
>  1 files changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
> index 2b5773a..b8a8783 100644
> --- a/drivers/video/via/via-core.c
> +++ b/drivers/video/via/via-core.c
> @@ -454,26 +454,32 @@ static int viafb_get_fb_size_from_pci(int chip_type)
>   */
>  static int __devinit via_pci_setup_mmio(struct viafb_dev *vdev)
>  {
> +	int ret;
>  	/*
>  	 * Hook up to the device registers.
>  	 */
>  	vdev->engine_start =3D pci_resource_start(vdev->pdev, 1);
>  	vdev->engine_len =3D pci_resource_len(vdev->pdev, 1);
> -	/* If this fails, others will notice later */
>  	vdev->engine_mmio =3D ioremap_nocache(vdev->engine_start,
>  			vdev->engine_len);
> -
> +	if (vdev->engine_mmio =3D NULL)
> +		return -ENOMEM;
>  	/*
> -	 * Likewise with I/O memory.
> +	 * Likewise with framebuffer memory.
>  	 */
>  	vdev->fbmem_start =3D pci_resource_start(vdev->pdev, 0);
> -	vdev->fbmem_len =3D viafb_get_fb_size_from_pci(vdev->chip_type);
> -	if (vdev->fbmem_len < 0)
> -		return vdev->fbmem_len;
> +	ret =3D vdev->fbmem_len =3D viafb_get_fb_size_from_pci(vdev->chip_type);
> +	if (ret < 0)
> +		goto out_unmap;
>  	vdev->fbmem =3D ioremap_nocache(vdev->fbmem_start, vdev->fbmem_len);
> -	if (vdev->fbmem =3D NULL)
> -		return -ENOMEM;
> +	if (vdev->fbmem =3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto out_unmap;
> +	}
>  	return 0;
> +out_unmap:
> +	iounmap(vdev->engine_mmio);
> +	return ret;
>  }
> =20
>  static void __devexit via_pci_teardown_mmio(struct viafb_dev *vdev)
> @@ -566,13 +572,13 @@ static int __devinit via_pci_probe(struct pci_dev *=
pdev,
>  	spin_lock_init(&global_dev.reg_lock);
>  	ret =3D via_pci_setup_mmio(&global_dev);
>  	if (ret)
> -		goto out_teardown;
> +		return ret;
>  	/*
>  	 * Set up the framebuffer device
>  	 */
>  	ret =3D via_fb_pci_probe(&global_dev);
>  	if (ret)
> -		return ret;
> +		goto out_teardown;
>  	/*
>  	 * Create our subdevices.
>  	 */

