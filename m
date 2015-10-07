From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Oct 2015 11:14:16 +0000
Subject: Re: [PATCH] video: of: fix memory leak
Message-Id: <5614FE88.4030909@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pPrF4ATq2VJiTSPDn8HlkhTMT78gLf9cC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443606848-31510-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1443606848-31510-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--pPrF4ATq2VJiTSPDn8HlkhTMT78gLf9cC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 30/09/15 12:54, Sudip Mukherjee wrote:
> If of_parse_display_timing() fails we are printing an error message and=

> jumping to the error path but we missed freeing "dt".
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/video/of_display_timing.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_displ=
ay_timing.c
> index 32d8275..8a1076b 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -210,6 +210,7 @@ struct display_timings *of_get_display_timings(stru=
ct device_node *np)
>  			 */
>  			pr_err("%s: error in timing %d\n",
>  				of_node_full_name(np), disp->num_timings + 1);
> +			kfree(dt);
>  			goto timingfail;
>  		}

Thanks, queued for 4.3 fixes.

 Tomi


--pPrF4ATq2VJiTSPDn8HlkhTMT78gLf9cC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFP6IAAoJEPo9qoy8lh71TC8QAKU+wUc2zkuY6JrXenLKCpPD
2kjCjF0BSYiBUVuWRVi10CT4oGSttxulRTvxYcvr4zN8ho37Pj4L+SCtv9aCQ1Wo
xC6lqPgszLc6PuVZeTXP8dcSvDc+v32uvOiQdiEFT8kKTOXPgpmDn26WL/DmbxmG
JMI5fjjZFd9D5n6ad87LdxM9mlkXrEkECOiuMIrUEaUBTZHFCddP0P+HT/ZS2nza
W39qh/AcC7CUK35ks+AUzll1ZdvrJfHwQyTUlx+TYwTxpXxs443plMP85J5BZKhp
Y/nWrEjWFYWpzmHH7LOL78vQoJpnrFAvGTzBIbPoXB/g3yoym+XIitxMKFQLjyfF
97zYtSmFxwrJfA8WR6e1P26nJgj7C8EZE8kDwM9bQEcliID9leX8Uk5gsuFrdCAU
US4WfVhuYsjUCLr+5D9hRh51pDwM04kpKIzzpe7JD8d3Vx8Tn0RXiTv/I5idjF5e
Jqv7NGHJCGNYQj4+y3VINXYX2bWyHXxtiNFdKeFQD7+K+97lTC/HEYfkWIy70Rqn
pzN/X6EUsVf8Gu8h2ZwwSIqU/Ciyrzhs9A36ZHwJWYGr4Zw2AlbxKP1nxwAJh4Nh
dzIflJOSKejOBlnaga1fD7MUAxRaQ6bHUn8tk5JYNtg3gEitZIWTFegHhbwheexn
nITKGIvBmHO2p5ULrIAL
=8kqn
-----END PGP SIGNATURE-----

--pPrF4ATq2VJiTSPDn8HlkhTMT78gLf9cC--
