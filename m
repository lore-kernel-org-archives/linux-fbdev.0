From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 20 Jan 2017 10:01:35 +0000
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
Message-Id: <8944dd20e8ae6ed705dcf69e9f0ed4fd@mail.crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-14-paul@crapouillou.net>
 <CACRpkdYMm0iWxmEGyQyEz4JfWukXNyGXO1rqw1dSiABgHdA1tQ@mail.gmail.com>
In-Reply-To: <CACRpkdYMm0iWxmEGyQyEz4JfWukXNyGXO1rqw1dSiABgHdA1tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

Le 2017-01-19 10:07, Linus Walleij a =C3=A9crit :

> On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>=20
>> All the drivers for the various hardware elements of the jz4740 SoC=20
>> have been modified to use the pinctrl framework for their pin=20
>> configuration needs. As such, this platform code is now unused and can=20
>> be deleted. Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> I feel I might have come across as a bit harsh in the previous review=20
> of the
> patches leading up to this one. In that case I'm sorry.
>=20
> I can clearly see that the intent of the series is to remove this=20
> hopelessly
> idiomatic code from the MIPS hurdle, and move these systems over
> to standard frameworks.
>=20
> In a way, if I look at the kernel as a whole, it would likely look=20
> better
> after these patches were merged, than before. Even with the
> shortcomings I painted out in the previous review comments.
>=20
> A very complicated piece of messy code is cut from MIPS.
>=20
> I think this is very valuable work and well worth persuing, so please
> go ahead and work with the series, your effort is very much=20
> appreciated!
>=20
> Yours,
> Linus Walleij

Well thank you for your very constructive criticism ;) And for your=20
review.
I'll submit a v2 very soon - I don't want to miss the 4.11 merge.

Regards,
-Paul
