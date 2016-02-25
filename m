From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 25 Feb 2016 13:56:48 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CF0820.1010602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3dFqWQik11uupd74jCT8FNIdD9SPj4NOI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com> <B8A82546-46C7-4A21-92D8-62418E49FBB6@konsulko.com>
 <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
In-Reply-To: <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--3dFqWQik11uupd74jCT8FNIdD9SPj4NOI
Content-Type: multipart/mixed; boundary="3BMkOo620MSETONpJ0ClBUd3XHvU9IbKC"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>,
 Tom Rini <trini@konsulko.com>, Tony Lindgren <tony@atomide.com>,
 Adam Ford <aford173@gmail.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <56CF0820.1010602@ti.com>
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com> <B8A82546-46C7-4A21-92D8-62418E49FBB6@konsulko.com>
 <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
In-Reply-To: <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>

--3BMkOo620MSETONpJ0ClBUd3XHvU9IbKC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/02/16 15:43, Linus Walleij wrote:
> On Wed, Feb 24, 2016 at 1:13 PM, Pantelis Antoniou
> <pantelis.antoniou@konsulko.com> wrote:
>=20
>> IMHO DT+overlays handle all your cases just fine.
>>
>> As far as I see these are the cases which we need to handle:
>>
>> 1) The expansion board in question has some means of identification, w=
hether it=E2=80=99s an
>> EEPROM or a GPIO keying combination etc. In that case it is the kernel=
=E2=80=99s job to match this
>> id value with a dtbo firmware file and apply it. The blob is located v=
ia means of request_firmware().
>=20
> Since the dawn of time the x86 people used that console to display
> the early boot crawl and collect crash data. What you're suggesting
> is that we can't get the console up until after the filesystems and mou=
nts
> are up so the kernel can read firmware files.

You can build firmware images into the kernel image. No, I don't like
that either.

The 2.2) option in Pantelis' mail can be used for 1) too, although then
the bootloader needs to know which dtbos to add.

 Tomi


--3BMkOo620MSETONpJ0ClBUd3XHvU9IbKC--

--3dFqWQik11uupd74jCT8FNIdD9SPj4NOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzwggAAoJEPo9qoy8lh71UZMP/jKpLEf/LzUWsj2Z+bFipZkz
EFWtQiSWBuCWXvQ+jusWE2tlY49xoL4CdHmZX4yWp5rI6WeDiI5pY6LLlL68/324
DksRkejvwibl8xxXqsb6yuqPWDu8MkM1QAotlwTACRi5n+1wJL8Zu8IexuXoTkYU
a+eDq4OnvTJ3lx2ZbbEUQ1BefQAZf7sbBNeA5SUXgwQmjgyyXO1jBmQE72XMo/NN
HXuPL2s+6x2p681bqzpfzWneP5QomTiIxJe5mUO4Wd5YCIM4WD97cPkO5Tkcf9tp
jiST1qP4L86k8hpbwjDAB5EYy1x7YjVUr9GkIqziiGap0RwUyNRPT9g023oAtjgL
Qr6EqO0Ox/8dz7XjK55TSTHzphZFJinqhqS0dbmw45BFc0ib3St/rxfkw9ecUEh8
JznDTJEGwk7HlYAg3YqKdb8u/dmV3gvEVd4JVzzZGtmZdPUeBBYZXZIaDWQDtpjg
/U5hZiVL0qsm/MgqUOHkTr82hp8fpKJqH/x7OZEjov45+mOHahkLI85n5GQa02gm
i5jqPJWE+0W4YZnTCrrERfNaz7hcAUyn7H2TkEQv9DE8H0YpGwqJdC3xGuaRUsz8
mShUiTxfeRr5J7oVe9V3k8a5sQSaDmfWEUutrkEQEGyn5T+Sc8IzxOZ8ehcFTQAh
+GFQiIydIwRHQAlyQjUv
=r7fB
-----END PGP SIGNATURE-----

--3dFqWQik11uupd74jCT8FNIdD9SPj4NOI--
