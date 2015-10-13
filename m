From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 13 Oct 2015 07:29:41 +0000
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device defined in dt
Message-Id: <20151013072941.GR17172@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <561BB2BC.9090907@atmel.com>
 <20151012153029.62f948d2@bbrezillon>
 <561BBB9F.6060808@mentor.com>
 <20151012160608.41f04553@bbrezillon>
 <561BC177.2050000@mentor.com>
 <20151012171931.3fb922d2@bbrezillon>
 <561BD282.70305@mentor.com>
In-Reply-To: <561BD282.70305@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 12 Oct 2015, Vladimir Zapolskiy wrote:

> On 12.10.2015 18:19, Boris Brezillon wrote:
> > On Mon, 12 Oct 2015 17:19:35 +0300
> > Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com> wrote:
> >>
> >>> Thierry's patch makes sure that EPROBE_DEFER is not returned when the
> >>> PWM device definition is not found using in the PWM lookup tables or
> >>> the DT definition,
> >>
> >> This is okay, but I'm interested in proper handling of cases other than
> >> EPROBE_DEFER. EPROBE_DEFER and the related issues are on your balance
> >> and I'm attempting to avoid interfering with it here :)
> >=20
> > I keep thinking we should fix all platforms using the ->pwm_id pdata
> > field to attach a PWM device to a PWM backlight instead of trying to
> > guess when falling back to the legacy API is acceptable...
> >=20
> >>
> >>> and in this case the pwm_bl code will fallback to
> >>> the legacy PWM API, which AFAICT is what you're trying to solve.
> >>
> >> Fallback must happen exclusively under (IS_ERR(pb->pwm) &&
> >> PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER && !pdev->dev.of_node) condition I=
MHO.
> >>
> >> Before EPROBE_DEFER appeared on the scene the condition was
> >> (IS_ERR(pb->pwm) && !pdev->dev.of_node).
> >>
> >> So, the question is if my change requires any updates or not from your
> >> point of view.
> >=20
> > ... but from a functional point of view your patch seems correct.
>=20
> Sounds good, thank you for review.

So should I take this patch, or not?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
