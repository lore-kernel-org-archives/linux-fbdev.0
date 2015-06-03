From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 03 Jun 2015 09:42:42 +0000
Subject: Re: [PATCH v5 0/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <556ECC12.7050603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1RqJGiELOALE4XgAQrdXp2I7hG8I4wR9w"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432937236-9327-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1432937236-9327-1-git-send-email-mcgrof@do-not-panic.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

--1RqJGiELOALE4XgAQrdXp2I7hG8I4wR9w
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 30/05/15 01:07, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> Tomi,
>=20
> this v5 series goes with the patch 3/17 titled "video: fbdev: gbefb:
> use arch_phys_wc_add() and devm_ioremap_wc()" with a change from
> dma_free_coherent() to dma_free_writecombine() for the area now allocat=
ed
> with dma_alloc_writecombine(). The remaining patches remain the same.
>=20
> As for the pull request all I did was reset my tree to yours, and
> then reset it to the same old commit 36520841a443d5ee966f9632c417fcc8a2=
5e07e3,
> then applied the new series. The only delta from the v4 seires is the
> patch 3/17. The new branch changes from simple-arch_phys-20150528 to
> simple-arch_phys-20150529. Pull request below for your convenience.

Thanks, I've picked up the v5 of the patch 3.

 Tomi


--1RqJGiELOALE4XgAQrdXp2I7hG8I4wR9w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbswSAAoJEPo9qoy8lh71L3QP/RC75R8iDFPLLGdS4qZitehl
ZuoR/FCztHXi9rw6JlWTlRqC7ej6F/lHX1M0hDaKyi+1u01tArK4dvbiwzZ6KxVV
VOXT69bNDBIp+Eyi/8km+7CKjodwE5rZVAsfDVVPliLu2d3vzCj7dB/yBJxyUH3W
IoC/z1X755bgM+QSzDt3WiM4mduvh4uS68W53c2Y5lrzggKcHpQzcZuZWYAeLf29
ez+zIH/i7UnAUu9ivsrKoN91uqnsvDaJMOCkzt9cI/d0i4PoocHuxRpdHOQBfa6N
iXXKcGiblQoR1Qiq/mvntP6MdpaLhzQlbFMm9UPDclwtD2HOigc/4kvRW/72Q43p
0lh7R2hACCrIWpNYUwTg0Zn2uxWNWX4nsoQQAqw7SH3bgcEwjMc+XGHShIZwLvTE
yfgC1FbPslHAi0fpRHQbwWfLIHZ4Yd15s5mvUvk/lF3M5HOSWwjCcqmSd8nAG4id
LqcCyEFOad/rJ3eZ3bu2Em3jKUPaXuxGpPLV1H/MpV3dEZbc9RSElDqygVLj+9ix
LtGuouZ9NoifJxxVD28somQZLtZXUe1+FzBtOiiw9nwUKftlNLkhSusMkgtiQcLF
EurW8HSvQ7pXKxb9CG2VXRyS+NtOfbMFgBWXxVbI4v1k7zf+qGjWRP6aJI5Bg2Av
ixxBq1mojNERR0SRHuPM
=Ok8p
-----END PGP SIGNATURE-----

--1RqJGiELOALE4XgAQrdXp2I7hG8I4wR9w--
