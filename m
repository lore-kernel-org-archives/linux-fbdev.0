From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Feb 2014 12:32:54 +0000
Subject: Re: [PATCH v2 3/4] video: mmp: add devm_mmp_get_path_by_phandle for DT
Message-Id: <52F8C6F6.5000200@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9BEc0w0n4SkTcM0q7jg6rEMm9LX8ONiVh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com> <1389698184-28761-4-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389698184-28761-4-git-send-email-zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

--9BEc0w0n4SkTcM0q7jg6rEMm9LX8ONiVh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/01/14 13:16, Zhou Zhu wrote:
> add devm_mmp_get_path_by_phandle to replace mmp_get_path
> for DT usage
>=20
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> ---
>  drivers/video/mmp/core.c |   35 +++++++++++++++++++++++++++++++++++
>  include/video/mmp_disp.h |    2 ++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
> index b563b92..0538458 100644
> --- a/drivers/video/mmp/core.c
> +++ b/drivers/video/mmp/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
>  #include <video/mmp_disp.h>
> =20
>  static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
> @@ -156,6 +157,40 @@ struct mmp_path *mmp_get_path(const char *name)
>  EXPORT_SYMBOL_GPL(mmp_get_path);
> =20
>  /*
> + * devm_mmp_get_path_by_phandle - get path by phandle
> + * @dev: device that want to get path
> + * @phandle: name of phandle in device node that want to get path
> + *
> + * this function gets path according to node pointed by phandle
> + * return NULL if no matching path
> + */
> +struct mmp_path *devm_mmp_get_path_by_phandle(struct device *dev,
> +	const char *phandle)
> +{
> +	struct mmp_path *path;
> +	struct device_node *node;
> +
> +	if (!dev->of_node) {
> +		dev_err(dev, "device does not have a device node entry\n");
> +		return NULL;
> +	}
> +
> +	node =3D of_parse_phandle(dev->of_node, phandle, 0);
> +	if (!node) {
> +		dev_err(dev, "failed to get %s phandle in %s node\n", phandle,
> +			dev->of_node->name);
> +		return NULL;
> +	}
> +
> +	path =3D mmp_get_path(node->name);
> +
> +	of_node_put(node);
> +
> +	return path;
> +}
> +EXPORT_SYMBOL_GPL(devm_mmp_get_path_by_phandle);

Why is this function "devm_"? devm_ functions are supposed to
automatically free resources when the device is removed, I don't see
anything like that here.

 Tomi



--9BEc0w0n4SkTcM0q7jg6rEMm9LX8ONiVh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+Mb3AAoJEPo9qoy8lh71DcUP/jIOkMYL05SwzUh2aDpm3Bn5
F66zqhtYAIDSc4eVllwG867yyFQpLKmpO8olDTiEBvyLV2VhJ3I01gm14Qyf/gQY
+HGxWK8OMchTqV23pBSDNK4Ek61wDQLAYhsPsQLwqZeKPSWIRtk3GZSEEAM1eIZP
o/7638grAf2FW3SF5NEBrhHD80OQLreIG/1njtj3/2vLjjJ48NQyZcflybuLUKIo
iOyU8ZdxRq13DLKgpgdqDzdIodhWXIF5xAdRBN2/koG9v3Dyu+CWoNrXd3AcAH1U
VlzxKKE7tzRD7Qsdw8Xb7VSL5sAWbWDPQnge1PslVwOyaQ/n/dFQj+QB7eKbtZlY
yld2QKrUcbAhcuOBIQdNNZ5ZDlS41LonxQRIpzhVlFpc/qSbmCrFANRGfDS9Mz9Q
Paf5ilZTA0Kvp/cvxZ5dEwLuIva9OksLZfu10orFA+esquKD63UWzSl810fO+QoT
tZ/3HCDVMNeCyBKqxv4+qUyTv3isN1NNsoMyfdYfFHagGEgjxGZv8UWYi5ZMdKLp
f/+ZQ8eQ234C2hE9yRVIJdJvsZPm7C6JR8aAMUlpV+MIfx89P9B3zokpda8LyKlz
Hop/BkwW+VkDRHhEjB7k4roXy0TQedEPqEfYsEjbKTWDsxvl+F2pqpjh5A9//qm2
rZPcnEWnJribtHP0fRMF
=RiDB
-----END PGP SIGNATURE-----

--9BEc0w0n4SkTcM0q7jg6rEMm9LX8ONiVh--
