From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 10:20:33 +0000
Subject: Re: [PATCH 0/7] video: ARM CLCD: non-controversial parts
Message-Id: <56D026F1.1080009@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RcDePFxUfw0KVlDmEOqbsx4paH3VLweuX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbGDXTbenOY_bsiuGqS3oBP3CKyjsOJuMPStaMFi=u3hw@mail.gmail.com>
In-Reply-To: <CACRpkdbGDXTbenOY_bsiuGqS3oBP3CKyjsOJuMPStaMFi=u3hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--RcDePFxUfw0KVlDmEOqbsx4paH3VLweuX
Content-Type: multipart/mixed; boundary="7a8oKcEg5JN7Lm0qLfMiv5h8rfJLwJTJP"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Ray Jui <ray.jui@broadcom.com>
Message-ID: <56D026F1.1080009@ti.com>
Subject: Re: [PATCH 0/7] video: ARM CLCD: non-controversial parts
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbGDXTbenOY_bsiuGqS3oBP3CKyjsOJuMPStaMFi=u3hw@mail.gmail.com>
In-Reply-To: <CACRpkdbGDXTbenOY_bsiuGqS3oBP3CKyjsOJuMPStaMFi=u3hw@mail.gmail.com>

--7a8oKcEg5JN7Lm0qLfMiv5h8rfJLwJTJP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/02/16 21:35, Linus Walleij wrote:
> On Tue, Feb 23, 2016 at 11:01 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>=20
>> This is a redux version of the previous patch set that strips out
>> any attempts to auto-switch or rewrite the device tree to match
>> the CLCD Versatile panel.
>=20
> It seems patch #4 didn't make it out so I re-sent it.

Hmm, it was there in the series... Russell had comments to it, to which
you didn't reply.

 Tomi


--7a8oKcEg5JN7Lm0qLfMiv5h8rfJLwJTJP--

--RcDePFxUfw0KVlDmEOqbsx4paH3VLweuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0CbxAAoJEPo9qoy8lh71fKQP/0S2gjsH8HqmTF0SjI9NUjpp
rGd19Iwr8NJE9uc5bG75X2HnuHubS9blZkqPzvqok83cZkitaI+7Fruu1kvO2APG
RvQQ5Ba9Tv7/d8pfuWEa6hfM8odbkYanZbAOVfZ6XKVFuRCpdQBnVK7+692HpAh7
gt+LhtDwYxPNot5f1eGJsohmm9laH7ZRCR66BKSkDgKc2nkikk0VeVCq1FIrelFU
g9JM53gcOVV0WBf1mPcWZTFaOgZIF7aa6LHcJvtwUhSpuXeI3mFdpVrFvPqGxdmB
9Xz3BJzgMlAGZHca8qDnFJgEDob6bl5y76/QVl4XuOgHJ8UMBDx3wLDsjy07otsP
/c2GOHLUr9XbaDaMSRkJuTd3cSIgLBYm3UCGpX7+YuvBJDx2ZUkHwWkuz6lEt3G5
NBiTf9hqkR+GRxh/FFWNbFdo03hchfxwOEOKVW1ro0reCPvHrOLyxaa3BfboFZzc
Ew8eQJwKkPrPPihF1787ZTuqhDWtnOQ9KqwjbMtwxo9iKAdThiwT/qDVH1KACm10
wxtvNWomDe8ILgEhN5bt2pmd24atuVd+5Ct1QOI+AU567HClmpX1mp7iwvRIjnk9
N4I8GPZoaYydDS5hSNgRqAXF2iLYUDU0hl+4hLVGDyIOdqOXY67Z9tdEpH3usovv
JJoUPaPO3fL1gIZSwYQE
=Gh0M
-----END PGP SIGNATURE-----

--RcDePFxUfw0KVlDmEOqbsx4paH3VLweuX--
