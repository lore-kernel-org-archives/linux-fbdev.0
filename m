From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 19 May 2015 12:33:14 +0000
Subject: Re: [PATCH v3 01/17] mfd: add new driver for Sharp LoCoMo
Message-Id: <20150519123314.GA3627@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
 <1431880077-26321-2-git-send-email-dbaryshkov@gmail.com>
 <20150519103828.GU22418@x1>
 <20150519112134.GD2067@n2100.arm.linux.org.uk>
In-Reply-To: <20150519112134.GD2067@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org

On Tue, 19 May 2015, Russell King - ARM Linux wrote:

> On Tue, May 19, 2015 at 11:38:28AM +0100, Lee Jones wrote:
> > On Sun, 17 May 2015, Dmitry Eremin-Solenikov wrote:
> > > +static void locomo_mask_irq(struct irq_data *d)
> > > +{
> > > +	struct locomo *ldev =3D irq_data_get_irq_chip_data(d);
> > > +	unsigned int mask =3D 0x0010 << d->hwirq;
> >=20
> > This also needs defining.
> >=20
> > Why not
> >   BIT(d->hwirq + 1)
>=20
> I think your maths is off...
>=20
> 0x0010 << d->hwirq !=3D BIT(d->hwirq + 1)

Ah, that's hex.  I was blinded by the 1's and 0's.  Doh!

Thanks Russell.

---

Why not
  BIT(d->hwirq + 4)

... with an explanation as to why you're skipping the first 4 bits?

/me hopes that maths is right now. :)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
