From: Kamil Debski <k.debski@samsung.com>
Date: Fri, 01 Apr 2016 08:29:57 +0000
Subject: RE: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where appropriate
Message-Id: <00e701d18bf0$ade6efe0$09b4cfa0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Boris Brezillon' <boris.brezillon@free-electrons.com>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: 'Milo Kim' <milo.kim@ti.com>, linux-fbdev@vger.kernel.org, 'Heiko Stuebner' <heiko@sntech.de>, linux-doc@vger.kernel.org, 'David Airlie' <airlied@linux.ie>, 'Mike Turquette' <mturquette@baylibre.com>, 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, 'Alexandre Belloni' <alexandre.belloni@free-electrons.com>, 'Daniel Vetter' <daniel.vetter@intel.com>, 'Lee Jones' <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Alexander Shiyan' <shc_work@mail.ru>, 'Jonathan Corbet' <corbet@lwn.net>, 'Robert Jarzmik' <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, 'Chen-Yu Tsai' <wens@csie.org>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, 'Jean-Christophe

Hi Boris,

From: Boris Brezillon [mailto:boris.brezillon@free-electrons.com]
Sent: Wednesday, March 30, 2016 10:04 PM
Subject: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where
appropriate
> 
> The PWM framework has clarified the concept of reference PWM config (the
> platform dependent config retrieved from the DT or the PWM lookup table)
> and real PWM state.
> 
> Use pwm_get_args() when the PWM user wants to retrieve this reference
> config and not the current state.
> 
> This is part of the rework allowing the PWM framework to support hardware
> readout and expose real PWM state even when the PWM has just been
> requested (before the user calls pwm_config/enable/disable()).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Kamil Debski <k.debski@samsung.com>

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland


