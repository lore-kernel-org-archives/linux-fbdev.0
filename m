From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 17:28:03 +0000
Subject: Re: [PATCH v3 06/10] pwm: add PWM modes
Message-Id: <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Mark Rutland <mark.rutland@arm.com>, milo.kim@ti.com, linux-fbdev@vger.kernel.org, Sean Young <sean@mess.org>, devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, kamil@wypas.org, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, Linux LED Subsystem <linux-leds@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, kgene@k

On Thu, Feb 22, 2018 at 2:01 PM, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
> Add PWM normal and complementary modes.

> +- PWM_DTMODE_COMPLEMENTARY: PWM complementary working mode (for PWM
> +channels two outputs); if not specified, the default for PWM channel will
> +be used

What DT stands for?

-- 
With Best Regards,
Andy Shevchenko
