From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Mar 2016 07:36:23 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56DD2F77.6080407@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uLaSXHgKO3OenJO8kHjaTXSE2cen7MPOS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
 <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
 <56D02D28.9080109@ti.com>
 <CACRpkdaJ1xzRp4gg1wLSoo_se+LEC9sUDZ-9L2iZ1g4GPj_dZw@mail.gmail.com>
In-Reply-To: <CACRpkdaJ1xzRp4gg1wLSoo_se+LEC9sUDZ-9L2iZ1g4GPj_dZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--uLaSXHgKO3OenJO8kHjaTXSE2cen7MPOS
Content-Type: multipart/mixed; boundary="3hhvlTUr7RqoPQj81tENHorSWB89Qo1XR"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Joachim Eastwood <manabian@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>
Message-ID: <56DD2F77.6080407@ti.com>
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
 <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
 <56D02D28.9080109@ti.com>
 <CACRpkdaJ1xzRp4gg1wLSoo_se+LEC9sUDZ-9L2iZ1g4GPj_dZw@mail.gmail.com>
In-Reply-To: <CACRpkdaJ1xzRp4gg1wLSoo_se+LEC9sUDZ-9L2iZ1g4GPj_dZw@mail.gmail.com>

--3hhvlTUr7RqoPQj81tENHorSWB89Qo1XR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/03/16 18:57, Linus Walleij wrote:
> On Fri, Feb 26, 2016 at 5:47 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>=20
>> Although one thing to consider is that if there is ever going to be a
>> DRM driver for CLCD, it would be good to have the device tree parts
>> correctly representing the hardware, so that the DRM driver could be
>> implemented in a cleaner, more generic way.
>=20
> OK so for the next kernel cycle I can work on that.
>=20
> The non-controversial patch set is essentially just using the DT bindin=
gs

Yes, I think the non-controversial series is fine. Will you be sending a
v2 of that series?

> that are already in the kernel and in widespread use. See:
> commit d10715be03bd8bad59ddc50236cb140c3bd73c7b
> "video: ARM CLCD: Add DT support"
>=20
> They follow the example set by
> commit 478a4f81af4936c683a03488e15b087e28cb4f0d
> "ARM: vexpress: Add CLCD Device Tree properties"

This one not actually correct, as the panel node is inside the clcd
node. The child parent relationship should represent a control bus. But
that's a different topic...

 Tomi


--3hhvlTUr7RqoPQj81tENHorSWB89Qo1XR--

--uLaSXHgKO3OenJO8kHjaTXSE2cen7MPOS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3S93AAoJEPo9qoy8lh71PloP+wTYZMXDHmVUxnaNjgfQCwot
ZUiCm+ML46Wc3M5OE21Ua9kCLoZ7RLIqZiHLwIbhRSO7CDOc/xvDU+W997z8j34R
FW6RG603WzEwpufjmtZ4IsciUj5kjuKt09NBsfspZK3TxD++kQCluvPY4dSbvaCH
YaBEjEeY9MHAHJKFLrHjYteBYkhBx6q0O/pazxmA5aeeeKs289dpdEjNIi0Egc5h
zg3AByNsEreYTq5A03BfQZ8wDg7QIOmuHe1kcxVUZ8EqhDTblp3Wo8M5IqWZQ1sD
FsW7/yasnCvijk285/7n+CoUGHn8q6NMhxhBGEMlDDJpl9yuOZFfdlW/Pwa91dLL
rLbzek/NZd/xE996x+zhJ3d93WCDFwts8Lah8OK1k/ZD7EceEvO39+KB/b1Fz7t8
7ueP/2WXmEGn3xmgJouwpgtg3+WrPs07CZSNJ8/eda4WzemP1moeuRBI6m/TEcbI
Gxp/aNuT7091Q8VxOjmSdgBA5g/IK8oh3j66oP4vIb18kk16ttiF6oo13ZoEkvir
DcQjKxRSszypZR9NveVAfP+/0xKYpztrbq5KoRkt/mbATdRW48oNPpyKPCA9OeCZ
d2AIi7KWWyuRYIoNp+yYyehhkFeuAfqN32ZFjWevqRFDGJZYzbwyOMWm/KLE1JIN
c7ul9ONlt2jBfhVMlxzK
=YBeJ
-----END PGP SIGNATURE-----

--uLaSXHgKO3OenJO8kHjaTXSE2cen7MPOS--
