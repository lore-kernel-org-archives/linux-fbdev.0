From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Apr 2017 20:55:30 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as output
Message-Id: <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170416103546.3021-1-contact@paulk.fr>
In-Reply-To: <20170416103546.3021-1-contact-W9ppeneeCTY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Paul,

On Sun, Apr 16, 2017 at 12:35 PM, Paul Kocialkowski <contact@paulk.fr> wrote:
> The move to a dedicated pwm_backlight_initial_power_state function in
> commit 7613c922315e308a6486d802abed2eb74443dffd modified the condition
> to set the enable gpio as output. This breaks specific use cases using
> that GPIO, such as tegra124-based nyan Chromebooks where backlight
> stopped working.
>
> This puts the condition back to the way it was before the move.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Does "[PATCH v2] backlight: pwm_bl: Fix GPIO out for unimplemented
.get_direction()"
(https://lkml.org/lkml/2017/4/4/225) fix your issue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
