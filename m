From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 13 May 2016 11:43:52 +0000
Subject: Re: [PATCH] efifb: Don't show the mapping VA
Message-Id: <5735BDF8.20003@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7SeKBS52laurMC11sAUkdINBHeNsrVMJf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <c980a1a405f54b39fc6382c20182786c894c7ffd.1463011030.git.luto@kernel.org>
In-Reply-To: <c980a1a405f54b39fc6382c20182786c894c7ffd.1463011030.git.luto@kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--7SeKBS52laurMC11sAUkdINBHeNsrVMJf
Content-Type: multipart/mixed; boundary="lUi5vSlulOerKtOf6T0QRu0pggIO12km3"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Andy Lutomirski <luto@kernel.org>, Peter Jones <pjones@redhat.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <5735BDF8.20003@ti.com>
Subject: Re: [PATCH] efifb: Don't show the mapping VA
References: <c980a1a405f54b39fc6382c20182786c894c7ffd.1463011030.git.luto@kernel.org>
In-Reply-To: <c980a1a405f54b39fc6382c20182786c894c7ffd.1463011030.git.luto@kernel.org>

--lUi5vSlulOerKtOf6T0QRu0pggIO12km3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/16 02:57, Andy Lutomirski wrote:
> The framebuffer mapping virtual address leaks information about the
> kernel memory layout.  Stop logging it.
>=20
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/video/fbdev/efifb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 95d293b7445a..3dcaf4e82885 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -247,10 +247,8 @@ static int efifb_probe(struct platform_device *dev=
)
>  		goto err_release_fb;
>  	}
> =20
> -	printk(KERN_INFO "efifb: framebuffer at 0x%lx, mapped to 0x%p, "
> -	       "using %dk, total %dk\n",
> -	       efifb_fix.smem_start, info->screen_base,
> -	       size_remap/1024, size_total/1024);
> +	printk(KERN_INFO "efifb: framebuffer at 0x%lx, using %dk, total %dk\n=
",
> +	       efifb_fix.smem_start, size_remap/1024, size_total/1024);
>  	printk(KERN_INFO "efifb: mode is %dx%dx%d, linelength=3D%d, pages=3D%=
d\n",
>  	       efifb_defined.xres, efifb_defined.yres,
>  	       efifb_defined.bits_per_pixel, efifb_fix.line_length,
>=20

Thanks, queued for 4.7.

 Tomi


--lUi5vSlulOerKtOf6T0QRu0pggIO12km3--

--7SeKBS52laurMC11sAUkdINBHeNsrVMJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNb34AAoJEPo9qoy8lh71IB4P/ilIhXHCscc0qFg6MdI2/Qhd
vC7UVeIt66VQa7QB/80a/DL2h+ntdipUfsVvuSGrgX6HxP89O7qlrlEDl97QbRiQ
u4LMUFeXINfjZc90/g7spvnVwIcBEnmurYQI50jhhEU0glp6uqM/C5+ZyXRZoBy6
C7miNeLopYsLtvI4CqJPoYRVwnYwvnWuh/WZaHoK5K60tXPA5+oc1YPl1AnfSymj
OyarfcZq10mZjHGPbg2E3a5lLydBG+GbeJ3RbmfgJ0ohI5o2NfRAruUezLg1W+S1
ntQ1eeJHBf5vMGrsJLBPoknt0cYBDp7LBT6gryU3ahQUydpuH+MlaRPdGjCbJ2hJ
I+c2M9SUlRIW5wSux+Wv12hnXf42ScuB1FZW/ZMYtffkrvtRed+bdM3RBOoDfOUD
9UogYGo+2GOtgPXQ4DidWulo5wVBJP1qjYS5Cift7Lh9XvmO0nNrhW1aHP0ZM2a3
+NM6GbW9qKuguWZhE7At/A6PJ9tlbzunk7WXcvQeksxwI0ks3LMREoXKxTtGXVN3
03J0/5pfIMJA0BdM4OY65NMRXd7y8Tuids6htVHIBV7Wx5IQTVpgKHrAlQj+n0VY
AZKrmU7j6CGFVRhmEZ8GU7PvTNwbKb601oP5C/u2SnH3dy30mXSOq6vdWHAzMt4l
S7lsdTGiSHw2CSH5OW6Q
=lLTd
-----END PGP SIGNATURE-----

--7SeKBS52laurMC11sAUkdINBHeNsrVMJf--
