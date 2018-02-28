From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Wed, 28 Feb 2018 20:04:52 +0000
Subject: Re: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
Message-Id: <87r2p4hod7.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
 <20180228194429.GD22932@mithrandir>
In-Reply-To: <20180228194429.GD22932@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: mark.rutland@arm.com, milo.kim@ti.com, linux-fbdev@vger.kernel.org, sean@mess.org, devicetree@vger.kernel.org, airlied@linux.ie, mturquette@baylibre.com, kamil@wypas.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, pavel@ucw.cz, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, daniel.thompson@linaro.org, linux-samsung-soc@vger.kernel.org, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux@armlinux.org.uk, krzk@kernel.org, kgene@kernel.org, linux-input@vger.kernel.org, linux@roeck-us.net, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, jdelvare@suse.com, b.zolnierkie@samsung.com, intel-gfx@lists.freedesktop.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, rodrigo.vivi@intel.com, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.or

On Wed, 28 Feb 2018, Thierry Reding <thierry.reding@gmail.com> wrote:
> Anyone that needs something other than normal mode should use the new
> atomic PWM API.

At the risk of revealing my true ignorance, what is the new atomic PWM
API? Where? Examples of how one would convert old code over to the new
API?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
