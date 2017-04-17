From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Apr 2017 19:36:06 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as output
Message-Id: <CAMuHMdVLUmT_NJt86tspYEZnsFEiEwiNu_19RQu0qhtcyP1SdQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170416103546.3021-1-contact@paulk.fr> <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ@mail.gmail.com>
 <1492443526.12267.4.camel@paulk.fr>
In-Reply-To: <1492443526.12267.4.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Paul Kocialkowski <contact@paulk.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-tegra@vger.kernel.org

Hi Paul,

On Mon, Apr 17, 2017 at 5:38 PM, Paul Kocialkowski <contact@paulk.fr> wrote:
> Le dimanche 16 avril 2017 à 22:55 +0200, Geert Uytterhoeven a écrit :
>> On Sun, Apr 16, 2017 at 12:35 PM, Paul Kocialkowski <contact@paulk.fr> wrote:
>> > The move to a dedicated pwm_backlight_initial_power_state function in
>> > commit 7613c922315e308a6486d802abed2eb74443dffd modified the condition
>> > to set the enable gpio as output. This breaks specific use cases using
>> > that GPIO, such as tegra124-based nyan Chromebooks where backlight
>> > stopped working.
>> >
>> > This puts the condition back to the way it was before the move.
>> >
>> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>>
>> Does "[PATCH v2] backlight: pwm_bl: Fix GPIO out for unimplemented
>> .get_direction()"
>> (https://lkml.org/lkml/2017/4/4/225) fix your issue?
>
> This definitely solves the issue!
>
> Since this fixes broken backlight (that, in turn, makes systems unusable),
> perhaps this should be included in the next rc cycle?

You mean v4.11 final, as there probably won't be another rc?
Yes!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
