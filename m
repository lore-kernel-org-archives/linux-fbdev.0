From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Apr 2016 09:10:56 +0000
Subject: Re: [PATCH 1/7 RESEND] video: ARM CLCD: runtime check for Versatile
Message-Id: <5714A4A0.3090900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LDfNGBel3O8OvSRLC5bIInvS4eS6kpvVg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-2-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYAcVy+PA5nXnWjWoLhh0UQm1=WMAzXiJtgcK0TsEa=zA@mail.gmail.com>
In-Reply-To: <CACRpkdYAcVy+PA5nXnWjWoLhh0UQm1=WMAzXiJtgcK0TsEa=zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--LDfNGBel3O8OvSRLC5bIInvS4eS6kpvVg
Content-Type: multipart/mixed; boundary="hvJD3F8kgU63rm6Q6x6E6QUAKDt97nw0i"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Ray Jui <ray.jui@broadcom.com>, stable <stable@vger.kernel.org>
Message-ID: <5714A4A0.3090900@ti.com>
Subject: Re: [PATCH 1/7 RESEND] video: ARM CLCD: runtime check for Versatile
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-2-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYAcVy+PA5nXnWjWoLhh0UQm1=WMAzXiJtgcK0TsEa=zA@mail.gmail.com>
In-Reply-To: <CACRpkdYAcVy+PA5nXnWjWoLhh0UQm1=WMAzXiJtgcK0TsEa=zA@mail.gmail.com>

--hvJD3F8kgU63rm6Q6x6E6QUAKDt97nw0i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 15/04/16 14:47, Linus Walleij wrote:
> On Tue, Feb 23, 2016 at 11:01 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>=20
>> The current compile-time check for inversed IENB/CNTL does not
>> work in multiplatform boots: as soon as versatile is included
>> in the build, the IENB/CNTL is switched and breaks graphics.
>> Convert this to a runtime switch.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Fixes: a29da136de34 ("ARM: versatile: convert to multi-platform")
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Tomi can you PLEASE merge this patch which is regressing all
> the Versatile hardware since commit a29da136de34?
>=20
> It is not dependent on the rest of the series.
>=20
> I am coming back to revising the rest of the patches, but
> this one need to go in.

Sure, queued for 4.6 fixes.

 Tomi


--hvJD3F8kgU63rm6Q6x6E6QUAKDt97nw0i--

--LDfNGBel3O8OvSRLC5bIInvS4eS6kpvVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXFKSgAAoJEPo9qoy8lh71yb0P/RRNu3C+VQhyfaOiCvKY2ouW
QYcKJsFcObIQibv+OqRBk3H2eszoumtHmncffElZnJbJIEgmr0uzSNjr5O3b8In2
hNxIfAo5UHXcJqfGC5rSV2itp93Q67Yt7dQ3RZKEWkEGZxxLy1Uk29BH1HcOZMtb
de/lzDBlO5karNYSCavrWGqCOJwHQCYgQPDAm4WW/2QMIWguwM97MBfUJ7PqINNf
0MX/ls35sMcvCSlE8csOhgvrZrgQe7Xnb1zJLHKWX0O4QxWWDw2M+Alxr852CUQB
OXtRCc4+glf72NDcSfx6dhxeZTiF0X61nHY0weafGkkHwo/IePK6a2GLQ29oO+NY
9ZnvO9GKjcqbrde7FtAZDizNJ6u5hmpvWhWdOa6fyR3YsL8NSKs3qJxaLJaynGoC
oIix7BxZI0JHduLmb2o+S4j0yDLESsjgRneDS3bbiwlMN1pkSibzKbkdZVqYgBv+
WxIv3zptmQQfpg+0OtlyRaPxgU9ZBPhlAHzR/MQSzi02mwZFGl8DwKAhNGRFMC61
GAlUyY1LaPKT7Rev2Gncv0y0ZZJJws+7j6hhbTpATK+FgWJaC7kNkXhtdxyg2e3m
mrtB4it7DKRlowkVfxL9OuW2IdsSwEQacVd+EtqaJK7/BGGrfpxhytIaMZbilzRJ
T7eoJ9aCk4Agls+7Qdm8
=QsqL
-----END PGP SIGNATURE-----

--LDfNGBel3O8OvSRLC5bIInvS4eS6kpvVg--
