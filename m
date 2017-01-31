From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 31 Jan 2017 10:31:10 +0000
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document  pinctrl-ingenic
Message-Id: <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
In-Reply-To: <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com

Hi,

> From the overlapping register addresses in the examples and this
> description, it looks like the pinctrlr and gpio controller are 1 
> block.
> If so, then there should only be 1 node.

Well, that's what I had until Linus W. just told me to do the opposite:

> Just pull all these down two levels and make them one device
> each instead of having them inside the pin controller node
> like this.

-Paul
