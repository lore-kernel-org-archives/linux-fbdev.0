From: Paul Cercueil <paul@crapouillou.net>
Date: Sun, 02 Apr 2017 20:42:30 +0000
Subject: [PATCH v4 00/14] Ingenic JZ4740 / JZ4780 pinctrl driver
Message-Id: <20170402204244.14216-1-paul@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170125185207.23902-2-paul@crapouillou.net>
In-Reply-To: <20170125185207.23902-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

This is the v4 of my patchset that introduces the pinctrl-ingenic and
gpio-ingenic drivers. The drivers were rewritten based on the feedback
received on the v3 version.

The pinctrl-ingenic driver now contains the pinmux/pinconf information of
each compatible SoC, so the devicetree bindings have been simplified greatly.

The driver now uses regmap for accessing the registers. This regmap is shared
to optional instances of the gpio-ingenic driver, that are instanciated as
MFD cells of the pinctrl-ingenic driver.

