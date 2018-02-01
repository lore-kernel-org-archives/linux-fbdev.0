From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 01 Feb 2018 12:06:43 +0000
Subject: Re: [PATCH v5 1/5] pwm-backlight: enable/disable the PWM before/after LCD enable toggle.
Message-Id: <20180201120643.3spdhgvudjk3eb3b@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171201120651.29633-1-enric.balletbo@collabora.com>
 <CAFqH_531DL3DYp4kn_Gjxprp7NNoAnP4MMD4-PRN=yJ+mXJNnA@mail.gmail.com>
In-Reply-To: <CAFqH_531DL3DYp4kn_Gjxprp7NNoAnP4MMD4-PRN=yJ+mXJNnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On Tue, 30 Jan 2018, Enric Balletbo Serra wrote:

> Hi,
>=20
> 2017-12-01 13:06 GMT+01:00 Enric Balletbo i Serra <enric.balletbo@collabo=
ra.com>:
> > Before this patch the enable signal was set before the PWM signal and
> > vice-versa on power off. This sequence is wrong, at least, it is on
> > the different panels datasheets that I checked, so I inverted the seque=
nce
> > to follow the specs.
> >
> > For reference the following panels have the mentioned sequence:
> >   - N133HSE-EA1 (Innolux)
> >   - N116BGE (Innolux)
> >   - N156BGE-L21 (Innolux)
> >   - B101EAN0 (Auo)
> >   - B101AW03 (Auo)
> >   - LTN101NT05 (Samsung)
> >   - CLAA101WA01A (Chunghwa)
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > ---
> > Changes since v4:
> >  - Rebase on top of mainline.
> >  - Add the acks from Daniel Thompson and Jingoo Han.
> > Changes since v3:
> >  - List the part numbers for the panel checked (Daniel Thompson)
> > Changes since v2:
> >  - Add this as a separate patch (Thierry Reding)
> > Changes since v1:
> >  - None
> >
> >  drivers/video/backlight/pwm_bl.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> A gentle ping, It's been nearly two months since I sent this patchset,
> there is anything else that prevents these patches to land or
> incorporate in linux-next?

Looks like Daniel should Ack 2/5 since he had comments on it before
and it still lacks a Backlight Ack.

With regards to -next, the merge-window is open (should close in a
little over a week), so the chances are, you'll get a long soak before
the next merge-window opens.

--=20
Lee Jones
Linaro Services Technical Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
