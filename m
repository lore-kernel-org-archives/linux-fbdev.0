From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 21 Jul 2015 08:50:36 +0000
Subject: Re: [PATCH] backlight: pm8941-wled: Move PM8941 WLED driver to backlight
Message-Id: <20150721085036.GF3061@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436990540-23354-1-git-send-email-bjorn.andersson@sonymobile.com>
 <55A764C5.5060205@samsung.com>
 <004401d0c2f6$9b73b820$d25b2860$@com>
 <55AD63FF.8090408@gmail.com>
 <9F0858DA-62D4-4511-A515-6CE38A680969@gmail.com>
In-Reply-To: <9F0858DA-62D4-4511-A515-6CE38A680969@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Tue, 21 Jul 2015, Jingoo Han wrote:

>=20
> On 2015. 7. 21., at AM 6:11, Jacek Anaszewski <jacek.anaszewski@gmail.com=
> wrote:
> >> On 20.07.2015 16:15, Jingoo Han wrote:
> >>> On Thursday, July 16, 2015 5:01 PM, Jacek Anaszewski wrote:
> >>>> On 07/15/2015 10:02 PM, Bjorn Andersson wrote:
> >>>> The Qualcomm PM8941 WLED block is used for backlight and should ther=
efor
> >>>> be in the backlight framework and not in the LED framework. This mov=
es
> >>>> the driver and adapts to the backlight api instead.
> >>>>=20
> >>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> >>>> ---
> >>>>   .../devicetree/bindings/leds/leds-pm8941-wled.txt  |  5 +-
> >>>>   drivers/leds/Kconfig                               |  8 ---
> >>>>   drivers/leds/Makefile                              |  1 -
> >>>>   drivers/video/backlight/Kconfig |  8 +++
> >>>>   drivers/video/backlight/Makefile                   |  1 +
> >>>>   .../backlight/pm8941-wled.c}                       | 59 ++++++++++=
------------
> >>>>   6 files changed, 36 insertions(+), 46 deletions(-)
> >>>>   rename drivers/{leds/leds-pm8941-wled.c =3D> video/backlight/pm894=
1-wled.c} (90%)
> >>>=20
> >>> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> >>=20
> >> If you are not an author of this driver or a maintainer affected by th=
is patch,
> >> Just 'Reviewed-by' looks good.
> >=20
> > I am a LED subsystem maintainer.
>=20
> OK, I see.
> I didn't notice that you were added as the maintainer 2 months ago.

Please read: Sections 12 and 13 of Documentation/SubmittingPatches.

Granted, Acked-bys are used by Maintainers when reviewing changes in
subsystems they are responsible for.  However, that's not the sole use
of them.  Anyone can provide an Ack for code they have reviewed, but
are not an expert in.  Reviewed-bys have much stronger meaning and
should only be used if the supplier knows the code and the subsystem
well.  Please see SubmittingPatches for a full meaning of the
Reviewed-by tag.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
