From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 24 Sep 2020 07:11:52 +0000
Subject: Re: [PATCH v2] MAINTAINERS: add Dan Murphy as TP LP8xxx drivers maintainer
Message-Id: <CAJKOXPdWD47OvK7qQ4Md2t3U=NmSf=j5hNjBq4+8CgZKLdup=Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200922152839.2744-1-krzk@kernel.org>
 <fe4609b5-5aab-46ed-5280-9a4742b97fe5@ti.com>
 <20200923205857.5af407ee@archlinux>
In-Reply-To: <20200923205857.5af407ee@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org

On Wed, 23 Sep 2020 at 22:01, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 23 Sep 2020 11:53:33 -0500
> Dan Murphy <dmurphy@ti.com> wrote:
>
> > Hello
> >
> > On 9/22/20 10:28 AM, Krzysztof Kozlowski wrote:
> > > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > > credits and add Dan Murphy from TI to look after:
> > >   - TI LP855x backlight driver,
> > >   - TI LP8727 charger driver,
> > >   - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> > >
> > > Cc: Dan Murphy <dmurphy@ti.com>
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Acked-by: Dan Murphy <dmurphy@ti.com>
> >
> Not sure who will pick this one up, but
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I guess whoever is first. :)
This spans across systems but the common part is MFD, so maybe Lee -
could you pick it up?

Best regards,
Krzysztof
