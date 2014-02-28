From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 09:24:23 +0000
Subject: Re: [PATCH 1/5] video: imxfb: Remove dead declaration of set_imx_fb_info()
Message-Id: <531055C7.5010606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Vfu5QbACfie8pNSBqArHsdFObeABTTLBH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392443786-30527-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1392443786-30527-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--Vfu5QbACfie8pNSBqArHsdFObeABTTLBH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15/02/14 07:56, Alexander Shiyan wrote:
> Function set_imx_fb_info() is missing in the kernel code,
> so remove the dead declaration.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  include/linux/platform_data/video-imxfb.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/=
platform_data/video-imxfb.h
> index 8902706..dd1bed9 100644
> --- a/include/linux/platform_data/video-imxfb.h
> +++ b/include/linux/platform_data/video-imxfb.h
> @@ -79,5 +79,4 @@ struct imx_fb_platform_data {
>  	void (*backlight_power)(int);
>  };
> =20
> -void set_imx_fb_info(struct imx_fb_platform_data *);
>  #endif /* ifndef __MACH_IMXFB_H__ */
>=20

Thanks, queued the series for 3.15.

 Tomi



--Vfu5QbACfie8pNSBqArHsdFObeABTTLBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTEFXIAAoJEPo9qoy8lh71L0QQAIJlkfMl1pzZdvhvai5rpcOM
bbH/dE61Q89mAVq4eOTiCeNBhjzU1qBLxC/z9bSNzDsriiTyo/g1svPIgdLmosrJ
I7mcaKeLU+DCIGpZOUk3Q5dyMwbo9NrwRLAYFQbjbGxQFZfAiQaiRdcul5noEnY0
5Cd/On0lb6NNPzJcRsjZn3hQuA6kmtJKrFNBNFiACYTDK+SqEJStBLqM3t/Yrf5I
4RdM0CEq1s9+g7uGOxgHA8N5ZGpWMViCv//UaPz3604JD7VrkPeAwgh2G7vUuZLg
JMq/rsixcUcm+r/PXkzb7G4NZ0n4+SlFvjjOt3NMftvzACswoGl6v3xoUt4CKZ4o
3JoahVp1GcdxliD11Zf1Yin4sDWz3j8y+1twLn4LLFJGePfGj4OTAMyKsHKn1/sw
AHWG8Gy8y5+CQtDXYxDr4UKeLbfPah9DmV8Nj3kmjfaGSOKlbcUM8gMl3jRa4JJC
4Bt1NyQVv+meavwIoaxn2khAnyh1XaHu11eqUtuBKaS8jMKvQ2vRYJaoTDle67LU
85wv8KcLYdU7EdvtB9rLiMGC3sE+MnIXVt1BnW934u9gry5Wf2hNLyUdHTVcokpU
9grbC6YaIeCJYLXC2z06wLVKQztBbQaBmfMcW3W0Bu70IXyTDUpZ3wUMs+HEbgqj
cqZy06vgzEOu0zHQfzLU
=oIQD
-----END PGP SIGNATURE-----

--Vfu5QbACfie8pNSBqArHsdFObeABTTLBH--
