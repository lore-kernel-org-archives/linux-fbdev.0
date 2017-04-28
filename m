From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 28 Apr 2017 20:08:10 +0000
Subject: [PATCH v4 00/14] Ingenic JZ4740 / JZ4780 pinctrl driver
Message-Id: <20170428200824.10906-1-paul@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170402204244.14216-2-paul@crapouillou.net>
In-Reply-To: <20170402204244.14216-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

This is the v5 of my Ingenic pinctrl / GPIO patch set.

The pinctrl driver now probes its children devices without using the MFD
subsystem; the GPIO driver now uses the 'reg' property to know the bank
number.

Best regards,
- Paul

