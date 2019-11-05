From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 05 Nov 2019 10:17:44 +0000
Subject: Re: [PATCH 38/46] video: backlight: tosa: use gpio lookup table
Message-Id: <20191105101744.kzdpopq25slbfuue@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-38-arnd@arndb.de>
 <CACRpkdajkSh6Bbvpfycm83j1GuCm+pTfw9fQS53JEfG2i07MKg@mail.gmail.com>
In-Reply-To: <CACRpkdajkSh6Bbvpfycm83j1GuCm+pTfw9fQS53JEfG2i07MKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Tue, Nov 05, 2019 at 11:04:44AM +0100, Linus Walleij wrote:
> On Fri, Oct 18, 2019 at 5:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The driver should not require a machine specific header. Change
> > it to pass the gpio line through a lookup table, and move the
> > timing generator definitions into the drivers itself.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > ---
> > I'm not overly confident that I got the correct device names
> > for the lookup table, it would be good if someone could
> > double-check.
> 
> You're anyway doing more than required for the people who
> may or may not be using this platform. Brokenness can surely
> be fixed later, it's not like we are taking down the entire Amazon
> cloud or something.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Same here. I read, I did't see anything wrong but I can't test.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
