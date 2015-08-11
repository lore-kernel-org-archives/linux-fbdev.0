From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2015 07:28:09 +0000
Subject: Re: [PATCH v2 09/11] fbdev: Allow compile test of GPIO consumers if !GPIOLIB
Message-Id: <CAMuHMdUjDkH0qqKkp9rC__uWzi8bx+ubd62-AOP5mRE8TokyCw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438506475-31012-1-git-send-email-geert@linux-m68k.org>
	<1438506593-31845-1-git-send-email-geert@linux-m68k.org>
	<55C9A2C3.1060001@ti.com>
In-Reply-To: <55C9A2C3.1060001@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Tomi,

On Tue, Aug 11, 2015 at 9:22 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 02/08/15 12:09, Geert Uytterhoeven wrote:
>> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
>> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
>> functionality only, can still be compiled if GPIOLIB is not enabled.
>>
>> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
>> appropriate.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>

> Applied to 4.3 fbdev.

Thanks!

> I do wonder why this is needed, though... I understand COMPILE_TEST if
> the dependency in question is difficult/impossible to enable with your
> kernel config (say, enabling OMAP SoC support with x86 config), but
> isn't GPIOLIB something that can be trivially enabled in any kernel config?

While there are a few mfd and pinctrl drivers that select GPIOLIB, the
presence of GPIOLIB is mostly a platform feature. Not all architectures support
GPIOLIB yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
