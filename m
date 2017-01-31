From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 31 Jan 2017 14:12:01 +0000
Subject: Re: [PATCH v3 03/14] pinctrl-ingenic: add a pinctrl driver for the  Ingenic jz47xx SoCs
Message-Id: <a17fe420e842f4975fbff4172fd72f67@mail.crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-4-paul@crapouillou.net>
 <CACRpkdZKNACkOYJtUcYavriSxSDMy0iLt2SUX+d8DcKPXofXyw@mail.gmail.com>
In-Reply-To: <CACRpkdZKNACkOYJtUcYavriSxSDMy0iLt2SUX+d8DcKPXofXyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

Le 2017-01-31 15:05, Linus Walleij a =C3=A9crit :

> If I didn't mention before this could pperhaps just use "pins"?

You commented this on v2 after I sent the v3 :)
I will fix it for v4.

> If you just use "pins" can this even be parsed by a generic parser=20
> function
> pinconf_generic_dt_subnode_to_map()?

I'll take a look. Thanks.

Regards,
-Paul
