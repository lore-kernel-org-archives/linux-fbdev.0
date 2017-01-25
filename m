From: Paul Cercueil <paul@crapouillou.net>
Date: Wed, 25 Jan 2017 18:51:53 +0000
Subject: [PATCH v3 00/14] Ingenic JZ4740 / JZ4780 pinctrl driver
Message-Id: <20170125185207.23902-1-paul@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
In-Reply-To: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com

Hi,

This is my v3 of my ingenic pinctrl patch series.
Not much is changed here, just cosmetic changes reported by coccinelle
as well as a missing header include.

To clear up any doubts: I left the GPIO base for the gpio-ingenic driver
configurable, for the reason that the QI_LB60 platform still uses global
GPIO numbers. When this code will eventually be cleaned up I will send
a patch to remove this mechanism.

Best regards,
- Paul

