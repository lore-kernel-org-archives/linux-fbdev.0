From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 Oct 2015 09:26:08 +0000
Subject: Re: [PATCH] radeonfb: Deinline large functions
Message-Id: <561636B0.1070509@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="l3H1DXc8rL0CO3ehQPELW2tlmrRaNliaa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443031073-7039-1-git-send-email-dvlasenk@redhat.com>
In-Reply-To: <1443031073-7039-1-git-send-email-dvlasenk@redhat.com>
To: Denys Vlasenko <dvlasenk@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Richard Purdie <rpurdie@rpsys.net>, Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@linux.ie>, Alex Deucher <alexdeucher@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--l3H1DXc8rL0CO3ehQPELW2tlmrRaNliaa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 23/09/15 20:57, Denys Vlasenko wrote:
> With this .config: http://busybox.net/~vda/kernel_config,
> after uninlining these functions have sizes and callsite counts
> as follows:
>=20
> __OUTPLLP: 61 bytes, 12 callsites
> __INPLL:   79 bytes, 150 callsites
> __OUTPLL:  82 bytes, 138 callsites
> _OUTREGP: 101 bytes, 8 callsites
> _radeon_msleep:      66 bytes, 18 callsites
> _radeon_fifo_wait:   83 bytes, 24 callsites
> _radeon_engine_idle: 92 bytes, 10 callsites
> radeon_engine_flush: 105 bytes, 2 callsites
> radeon_pll_errata_after_index_slow: 31 bytes, 11 callsites
> radeon_pll_errata_after_data_slow:  91 bytes, 9 callsites
>=20
> radeon_pll_errata_after_FOO functions are split into two parts:
> the inlined part which checks corresponding rinfo->errata bit,
> and out-of-line part which performs workaround magic per se.
>=20
> Reduction in code size is about 49,500 bytes:
>=20
>     text     data      bss       dec     hex filename
> 85789648 22294616 20627456 128711720 7abfc28 vmlinux.before
> 85740176 22294680 20627456 128662312 7ab3b28 vmlinux

Thanks, applying for 4.4.

 Tomi


--l3H1DXc8rL0CO3ehQPELW2tlmrRaNliaa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFjaxAAoJEPo9qoy8lh71/0UP/iN0zDp5jYzObPyLXkJvTIH+
lgUntfvvrnZt4s3l0wfoG4HwPU9W/PAVaXlvs2Wm99yAKUJoh4qnkKH6AODdEQOI
AHXJgKKH4/FUy1LuQaKf0uFhQ1pls4y4baosp6uCF/cSVe+sYqO8AC+bQ2Zl/vUa
dNR49DdT+HHHjUzc6sJvJ2+Th71pF6unGrqwwoiQrVkSjTCRwUrfrZmq7EQQIjVN
0So770tBnt+Z3MSlWE6ry60cMa5os7SmUFpxK3tqQTEyCK4akN9eTXo2AXLujDao
q6xiED6M+etVRGpVZ0ei7385h6imKl/vk34TScBcrLzwR+ZgfsL+AW/td7LHRctf
Rcdrui508PYQiqtGh7IgdVL8Op8V9P1mPhlpuHkllkkzpTL/Cf52FaB7ir9v4fZo
fiXsFCm9PlCywXGPM/g9AG0wxRUL7RYJ8cvnQN2qo6usuVIodk4fsPMQEkNuwRzW
VJ9Whnid5Bo/UsLqA7XM8noqPZHy2PGhYZwqe0EZP7HVWHEOort/3YGgSDLUmOA2
IKXob6Fzpw23AcE7ruew0hnGQ76pIQX6yH61Qi97HPGRFthWKGq/fNXmyUWtQR6A
SL9IVBWKu7HGJ3szYqlyjjA8RBuQqKfHlvRIOU+aJ5sPwfVeSqySV8Xs58ijw+du
HRzFXNLuRPwZMpYP1Uvb
=xFBA
-----END PGP SIGNATURE-----

--l3H1DXc8rL0CO3ehQPELW2tlmrRaNliaa--
