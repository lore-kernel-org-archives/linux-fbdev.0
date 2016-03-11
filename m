From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 11 Mar 2016 11:37:52 +0000
Subject: Re: [PATCH v2] xen kconfig: don't "select INPUT_XEN_KBDDEV_FRONTEND"
Message-Id: <56E2AE10.7030701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2VdQRjxshUJ2e2qHdLsNrsH1OcLKdhcn4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455278707-2008263-1-git-send-email-arnd@arndb.de>
 <56C20552.8030305@citrix.com>
 <alpine.DEB.2.02.1602151708110.27008@kaball.uk.xensource.com>
 <2479546.WgivMO2bp2@wuerfel>
In-Reply-To: <2479546.WgivMO2bp2@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--2VdQRjxshUJ2e2qHdLsNrsH1OcLKdhcn4
Content-Type: multipart/mixed; boundary="OdLj6FDpCecXisHW5w2BxM9aKQq4l25MU"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: David Vrabel <david.vrabel@citrix.com>, Andrew Jones
 <drjones@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-arm-kernel@lists.infradead.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xensource.com, boris.ostrovsky@oracle.com
Message-ID: <56E2AE10.7030701@ti.com>
Subject: Re: [PATCH v2] xen kconfig: don't "select INPUT_XEN_KBDDEV_FRONTEND"
References: <1455278707-2008263-1-git-send-email-arnd@arndb.de>
 <56C20552.8030305@citrix.com>
 <alpine.DEB.2.02.1602151708110.27008@kaball.uk.xensource.com>
 <2479546.WgivMO2bp2@wuerfel>
In-Reply-To: <2479546.WgivMO2bp2@wuerfel>

--OdLj6FDpCecXisHW5w2BxM9aKQq4l25MU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/02/16 17:03, Arnd Bergmann wrote:
> The Xen framebuffer driver selects the xen keyboard driver, so the latt=
er
> will be built-in if XEN_FBDEV_FRONTEND=3Dy. However, when CONFIG_INPUT
> is a loadable module, this configuration cannot work. On mainline kerne=
ls,
> the symbol will be enabled but not used, while in combination with
> a patch I have to detect such useless configurations, we get the
> expected link failure:
>=20
> drivers/input/built-in.o: In function `xenkbd_remove':
> xen-kbdfront.c:(.text+0x2f0): undefined reference to `input_unregister_=
device'
> xen-kbdfront.c:(.text+0x30e): undefined reference to `input_unregister_=
device'
>=20
> This removes the extra "select", as it just causes more trouble than
> it helps. In theory, some defconfig file might break if it has
> XEN_FBDEV_FRONTEND in it but not INPUT_XEN_KBDDEV_FRONTEND. The Kconfig=

> fragment we ship in the kernel (kernel/configs/xen.config) however
> already enables both, and anyone using an old .config file would
> keep having both enabled.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: David Vrabel <david.vrabel@citrix.com>
> Fixes: 36c1132e34bd ("xen kconfig: fix select INPUT_XEN_KBDDEV_FRONTEND=
")
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 8ea45a5cd806..d889ef2048df 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2246,7 +2246,6 @@ config XEN_FBDEV_FRONTEND
>  	select FB_SYS_IMAGEBLIT
>  	select FB_SYS_FOPS
>  	select FB_DEFERRED_IO
> -	select INPUT_XEN_KBDDEV_FRONTEND if INPUT_MISC
>  	select XEN_XENBUS_FRONTEND
>  	default y
>  	help
>=20

Thanks, queued for 4.6.

 Tomi


--OdLj6FDpCecXisHW5w2BxM9aKQq4l25MU--

--2VdQRjxshUJ2e2qHdLsNrsH1OcLKdhcn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4q4QAAoJEPo9qoy8lh71wVoP/3jBl6ja7v/j+dIknjeNxTN+
5Pn0JorH3cvP2qpy/nbJTOZX5u6Geih6AEkM/p/TgTPuO97pgd5ubb6ERHoan0+M
zv9dE1emLKcaCosQ934fa2ShTlSe108CpiK/xUY5dRM+PrrKEBck5j7KlXVU0PIg
PqN+eNj43xCpDap6NvQ6hVztt6BzlLqgXbNYe1mdvyena/oiVfIi/dsIIw0ruSoq
k1iPNzpztF0vzzmLxElB/754ntBoDT0kcJn6Qa2Nx1zjz8tDAHPXZ9ZSNih3s5eL
aJYc0vt2HJxsY8yvD2mTWCpdAkyz3cdibSVjm6GVqi3ehVwnHhUjoHfAm1HDMO+7
SfuBDTjl64tXXeFw5OY+lX3MESM0Q/stRB/FxVpqs0tAah+i+f+xxEkHb6ELzYya
/q4KpSUooPTEZA6pZ0cIPv3JvVWpP5j76PBwuCtabrxcmxuAQFdMBx4x3TB+QjZo
TC48o+ROVxqs7CJJ0o4C45wg6VxhBWRVjOex8OdwTpQQ1o4mN92l3eQHPVv9Gumx
cFEbLNNdLmjdtABbkUndp2pm/5JOwBtovv5CfhFLa25SueDmoHEbnheqU+w58715
JZ89C2cKPo9NWIuXSuR15lbCviotj1QGq7m9l6zs/sDUhb2koBOZ93PgUUJJfIcY
12G4n0zYMXm1hGq+c1nt
=UrN1
-----END PGP SIGNATURE-----

--2VdQRjxshUJ2e2qHdLsNrsH1OcLKdhcn4--
