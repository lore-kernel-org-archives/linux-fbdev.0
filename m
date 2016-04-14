From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 14 Apr 2016 19:17:44 +0000
Subject: [PATCH v5 24/24] pwm: add information about polarity, duty cycle and period to debugfs
Message-Id: <1460661464-11216-25-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Stephen Barber <smbarber@chromium.org>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger

From: Heiko St=C3=BCbner <heiko@sntech.de>

The pwm-states make it possible to also output the polarity, duty cycle
and period information in the debugfs pwm summary-outout.
This makes it easier to gather overview information about pwms without
needing to walk through the sysfs attributes of every pwm.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index aefffcf..9f4e97e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -959,6 +959,11 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct=
 seq_file *s)
 		if (state.enabled)
 			seq_puts(s, " enabled");
=20
+		seq_printf(s, " period:%uns", state.period);
+		seq_printf(s, " duty:%uns", state.duty_cycle);
+		seq_printf(s, " polarity:%s",
+			   state.polarity ? "inverse" : "normal");
+
 		seq_puts(s, "\n");
 	}
 }
--=20
2.5.0

