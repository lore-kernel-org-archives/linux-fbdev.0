From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Aug 2016 10:56:53 +0000
Subject: Re: [patch] video: fbdev: pxafb: potential NULL dereference on error
Message-Id: <ad029a9a-f61b-60e2-1e6d-ddf435e2a37c@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qKgCj2JjfoRP7k3LEEVVAH5QqubPDbPOf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160715110732.GC9258@mwanda>
In-Reply-To: <20160715110732.GC9258@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

--qKgCj2JjfoRP7k3LEEVVAH5QqubPDbPOf
Content-Type: multipart/mixed; boundary="SHejsf7cibkJL1RRGjnr6sFeWTsjUNMh7"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Luis R. Rodriguez"
 <mcgrof@suse.com>, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-ID: <ad029a9a-f61b-60e2-1e6d-ddf435e2a37c@ti.com>
Subject: Re: [patch] video: fbdev: pxafb: potential NULL dereference on error
References: <20160715110732.GC9258@mwanda>
In-Reply-To: <20160715110732.GC9258@mwanda>

--SHejsf7cibkJL1RRGjnr6sFeWTsjUNMh7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 15/07/16 14:07, Dan Carpenter wrote:
> If we "goto out;" then it calls display_timings_release(timings);
> Since "timings" is NULL, that's going to oops.  Just return directly.
>=20
> Fixes: 420a488278e8 ('video: fbdev: pxafb: initial devicetree conversio=
n')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index 2c0487f..ed41fdb 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2125,7 +2125,7 @@ static int of_get_pxafb_display(struct device *de=
v, struct device_node *disp,
> =20
>  	timings =3D of_get_display_timings(disp);
>  	if (!timings)
> -		goto out;
> +		return -EINVAL;
> =20
>  	ret =3D -ENOMEM;
>  	info->modes =3D kmalloc_array(timings->num_timings,
>=20

Thanks, queued for v4.9.

 Tomi


--SHejsf7cibkJL1RRGjnr6sFeWTsjUNMh7--

--qKgCj2JjfoRP7k3LEEVVAH5QqubPDbPOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwh2AAoJEPo9qoy8lh71/Y8P/jSgYkKWvruJjit2tiQMyn5t
9hvtOCDXVFNkDUc0e0EaBqlJdNKWE4evChbOuJ1ekxVetK03D8xkJ6OaODUt54CG
xO0G/1xgiqGWuDvcNeceNLdOftpxD0hbL4enoRpeqMKbrA9uofilGjVN9E/jRVYM
4J9I0R/GJB4ZYz7hHMLI6uPdAdyqfMW/dOvhqMdgio7A492gF64JglCznFTNTzqY
f7/ELx+8YdEBTOYr2Pp00QcJFMOLCaBUCyonTwgP6jeZLSbbViGMOSwrc3YVBP8/
t/RwE0v33NBkmjP6ssqcD+o5+OGPaTMgYaNkEv+DXYjeWO+qZnKgSBKiyiNd3VHL
niKrQz8Dhz1rKHefwgd2TN11P26ABsP+o24Z51Md2Rtuh3BlEWf77alydQg/p7K5
ity4Nwpg9P+fhH5seQCLgnJy/xLPRrf0wIdWaE2VM7YLe0irBGMdTulu2iG+6id8
RQLpQeThE/TR5EBGD+kUc80L0/DrpPV98MgxrsTRogfx842F6RE/NyHj+ZlIhOPH
3wVXOa1Ibfe2QbWRDTFk4rMFJnYFFQLITucMeIHNhQAsDlPUriHyjW6Wg72nPyjQ
hz7c3Jmt3cc6j/AMrUqyKh/h36aUWjWZJqG9V0eKyUZsBPZ5/MZCwhwk7slsRvHT
dNYyS9NqtN6JurLczVtE
=O58j
-----END PGP SIGNATURE-----

--qKgCj2JjfoRP7k3LEEVVAH5QqubPDbPOf--
