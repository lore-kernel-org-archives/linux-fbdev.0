From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 22 Sep 2020 07:08:37 +0000
Subject: Re: [PATCH] MAINTAINERS: move Milo Kim to credits
Message-Id: <CAJKOXPdwQc86H-S=C4v_1VCbd7RhC2Soepj_2LqG1e_E_bgAug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200921210233.21449-1-krzk@kernel.org>
 <20200921210610.GA5338@amd>
In-Reply-To: <20200921210610.GA5338@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>

On Mon, 21 Sep 2020 at 23:06, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > credits and remove the separate driver entries for:
> >
> >  - TI LP855x backlight driver,
> >  - TI LP8727 charger driver,
> >  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> I believe normal way would be to mark the entries "orphaned", not to
> drop them altogether. Plus, I believe someone from TI is likely to
> step up.

These are entries for specific drivers so they are covered by the
subsystem maintainers. You believe someone will step up, I believe if
these were important for TI, they would find the person some time ago,
so the emails won't bounce... This was similar with BQ chargers where
Andrew's email was bouncing and after a few weeks it was fixed. To me
it looks like TI does not have any priority in maintaining separate
driver entries so what is the point to keep orphaned driver-entry? It
is not the case where we have an orphaned subsystem and we look for a
person to handle it...

Best regards,
Krzysztof
