From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 12:47:39 +0000
Subject: Re: [patch] fbdev: pm3fb: cleanup some confusing indenting
Message-Id: <54FEE7EB.8070402@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q56R8VaCa90KBVVU90lFe8bTCnGfXwaxJ"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--Q56R8VaCa90KBVVU90lFe8bTCnGfXwaxJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/02/15 15:25, Dan Carpenter wrote:
> This if statement should be pushed out one tab to line up with the rest=
=2E
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
> index 4bf3273..77b99ed 100644
> --- a/drivers/video/fbdev/pm3fb.c
> +++ b/drivers/video/fbdev/pm3fb.c
> @@ -1479,9 +1479,9 @@ static void pm3fb_remove(struct pci_dev *dev)
>  		fb_dealloc_cmap(&info->cmap);
> =20
>  #ifdef CONFIG_MTRR
> -	if (par->mtrr_handle >=3D 0)
> -		mtrr_del(par->mtrr_handle, info->fix.smem_start,
> -			 info->fix.smem_len);
> +		if (par->mtrr_handle >=3D 0)
> +			mtrr_del(par->mtrr_handle, info->fix.smem_start,
> +				 info->fix.smem_len);
>  #endif /* CONFIG_MTRR */
>  		iounmap(info->screen_base);
>  		release_mem_region(fix->smem_start, fix->smem_len);

Thanks, queued for 4.1.

 Tomi



--Q56R8VaCa90KBVVU90lFe8bTCnGfXwaxJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/ufrAAoJEPo9qoy8lh71lOAP/R0LVa4/t1snu2LwuqwBGCS/
ooht8QJT8qL+CGbUW/Zmkd8XVo08VHjphenmDKhVXEcBC5awkiDB0Djfj+JR+lMd
XwCGKsD2p8mTECwsBR5kPnFuqMJ5SOHpYc/74f44JXj9pLbz/ahKHPYP4jtDNhQh
pD+fiZ21EdMCpyW4iNTVANh93dZPJYIahOqW7zrwETFhp8mtLqz/mtdvxcdqlTcS
auG+PciFcCO4wjHr/vDlTw1Nghv3onRap7ftUvS1C7ps1u04PF4PvQnek4DQXg7b
zqs6As/zlb7FIHp+x1wPd0PMR8rCWccc10Q8TlEgQOIrSg1FeV8HMzeVWnuPJvCy
GFoGA4k1J0KdV2PSo+wlxHWy/yBougqEeTqxG5bT8ilR4RpKcG/X5ZKddN0tuuYr
M5xJh2jjQRXBqJxa4hNihZRemVMZp03douKiHOMSj/lxqOKAtqHh6B+pUx9hlWPr
mLDNLb5K2aYObFTKzOuqPjvw9DeGJSZO0FGsPR72bNTl+hDKClxCuQNpxn1a1wGH
MrCy5KEaHLsjURmwABPjXq0k1Us0cmlSGXHkBPL9m+dhrt7Ea5NISiWdq+Jbeggg
U2wtz2Sdpc2rTfu/rrQMd8sChYojoOhoQ7luCDJ2CP1wuDIWc+NO4ySZgWo9Hmyn
VnZM9n6Ut2pAFPNgsn1Q
=z6TZ
-----END PGP SIGNATURE-----

--Q56R8VaCa90KBVVU90lFe8bTCnGfXwaxJ--
