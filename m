From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jul 2013 08:38:54 +0000
Subject: Re: [PATCH] video: sh7760fb: fix to pass correct device identity to free_irq()
Message-Id: <51F2359E.8030506@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Gq7wvwT6MwiSFoaWF4mUH9DNQAJRm82R9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd9+d0Csf0kad8fnYQc4UQLdoJCo+-MZNNGKi_PTxeBJjQ@mail.gmail.com>
In-Reply-To: <CAPgLHd9+d0Csf0kad8fnYQc4UQLdoJCo+-MZNNGKi_PTxeBJjQ@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--Gq7wvwT6MwiSFoaWF4mUH9DNQAJRm82R9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/07/13 16:20, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> free_irq() expects the same device identity that was passed to
> corresponding request_irq(), otherwise the IRQ is not freed.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/sh7760fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
> index a8c6c43..1265b25 100644
> --- a/drivers/video/sh7760fb.c
> +++ b/drivers/video/sh7760fb.c
> @@ -567,7 +567,7 @@ static int sh7760fb_remove(struct platform_device *=
dev)
>  	fb_dealloc_cmap(&info->cmap);
>  	sh7760fb_free_mem(info);
>  	if (par->irq >=3D 0)
> -		free_irq(par->irq, par);
> +		free_irq(par->irq, &par->vsync);
>  	iounmap(par->base);
>  	release_mem_region(par->ioarea->start, resource_size(par->ioarea));
>  	framebuffer_release(info);
>=20

Thanks, I've applied this into my 3.11-fixes/fbdev branch.

 Tomi



--Gq7wvwT6MwiSFoaWF4mUH9DNQAJRm82R9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8jWeAAoJEPo9qoy8lh71sjoP/jtt1fVb03jN2+j+1OyCnTbI
ng/hbXvY/XcI8bMjOSQB72ZV5fPHCBeY2+5M1CgCcF7sx2mkeK3PfZrKpktmf/+s
jO2dzOKDTCWLQ8TabD2rTioq6SMr0IrhSlnXFkAlTrh5VHH2oh4oZ9uIhAD+0Fbr
gMvnOZphRFrKCWhe2uvHoMk7ZNIeEc4CFTO+ZDU+PFhsngnU2FwPAY3xOECVEsPD
vTW5Gzt5rmejiC2H7hCRV+uui9jEN31VS0nwfPNPW2FtQ7pqv0jA9IxbQm8Cg09T
rFB/cCN5g/dt6FeS4HB2mPMscu7IVLvwZ79ETSBtAGhzKLTHptEiaQ/7CQJ7E19E
qS/Y8rCQv3iOmhwtZLOg8JeKgiB225NccWnCRbpIIKB8Tlmj5OwnR6tu/xuHclPn
4PeYsRRCTp+N7vawFYJk14TDSVLciVyOov7bZRTcgPysv5rgV5VfuHReH2OEqxNQ
nuOZi49nZ0EH0wF4drX3mA3FIWNi+sIgoQTo8nIXlSEWQC+zBU8S1NzR16YzeeI/
48CyRu/IVkawl/IFv97zsaqYCmq/GMjHR2dsuGLyIud1eZ4S4D1EKo2z3bxwVUE0
4kvIECrWvm8937yZUiKeh3rcwe+0gtoQm1WX7HDLqlMqXi1lX7R2ELvkUoWthHdd
zyGrYpxNzqpS3I2AJ48i
=5+Zj
-----END PGP SIGNATURE-----

--Gq7wvwT6MwiSFoaWF4mUH9DNQAJRm82R9--
