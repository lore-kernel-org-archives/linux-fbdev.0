From: Alexandru M Stan <amstan@chromium.org>
Date: Wed, 09 Sep 2020 18:42:56 +0000
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
Message-Id: <CAHNYxRw5t67-A4sf719+hQ51K-oRZZLt5W5P3Hej0ynvS9-V5Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
In-Reply-To: <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Douglas Anderson <dianders@chromium.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Matthias Kaehlcke <mka@chromium.org>

On Fri, Sep 4, 2020 at 4:38 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > Some displays need the low end of the curve cropped in order to make
> > them happy. In that case we still want to have the 0% point, even though
> > anything between 0% and 5%(example) would be skipped.
>
> For backlights it is not defined that 0 means off and, to be honest, 0
> means off is actually rather weird for anything except transflexive
> or front lit reflective displays[1]. There is a problem on several
> systems that when the backlight slider is reduced to zero you can't
> see the screen properly to turn it back up. This patch looks like it
> would make that problem worse by hurting systems with will written
> device trees.
>
> There is some nasty legacy here: some backlight displays that are off
> at zero and that sucks because userspace doesn't know whether zero is
> off or lowest possible setting.
>
> Nevertheless perhaps a better way to handle this case is for 0 to map to
> 5% power and for the userspace to turn the backlight on/off as final
> step in an animated backlight fade out (and one again for a fade in).

Hello

Apologies for my delay. Thanks for the responses!

Yeah, I felt pretty sketchy about this 0% patch as well. But I figured
it's better to send my suggestion and get corrected than lose the
fixed interpolation patch.

Turns out there's no reason to need 2/3. I was mistaken:
echo "4" > /sys/devices/platform/backlight/backlight/backlight/bl_power
seems to work just fine to turn the backlight off, nothing special
about my device (pwm comes from cros_ec).
Chrome OS user space already makes full use of that knob
(https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/platform2/power_manager/powerd/system/internal_backlight.cc;l9)
I wanted to try X11 on the same device but I haven't gotten to it yet,
perhaps I'll post my results in the next cover letter.
So it seems I didn't have to worry about "not breaking userspace" on
the existing devices.

I'll respin this patch set: keep 1/3 and 3/3, remove 2/3, and
potentially add another one to update trogdor's dtsi (since that's
where I want this fixed linear interpolation to happen).

Thank you,
Alexandru Stan
