From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Thu, 02 Feb 2017 10:07:02 +0000
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Message-Id: <20170202100702.GE2053@lahna.fi.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170131090432.72a1b1b8@bbrezillon>
 <20170131084447.GD8311@dtor-ws>
 <20170131100721.22c2388d@bbrezillon>
 <20170131091155.GH8311@dtor-ws>
 <20170131102424.7b68c0d4@bbrezillon>
 <20170131183936.GB13642@dtor-ws>
 <20170131204202.7b589ca6@bbrezillon>
 <CACRpkdbr6BGm3mJ_2XOAuootK-ruibiGsG8=LvKhrz1cpUrnhA@mail.gmail.com>
 <20170201142228.053e2041@bbrezillon>
 <CACRpkdaO=1+JHs2qtVULyN1B1pfajc=UF-V_N+Ej_i5SMv-pPQ@mail.gmail.com>
In-Reply-To: <CACRpkdaO=1+JHs2qtVULyN1B1pfajc=UF-V_N+Ej_i5SMv-pPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>

On Wed, Feb 01, 2017 at 03:51:06PM +0100, Linus Walleij wrote:
> fwnode_get_named_gpiod()
> devm_get_gpiod_from_child()
> 
> Both are taking a fwnode as argument and the naming is as
> inconsistent as it can be.
> 
> Some more churn should be expected as a side
> effect of naming this function wrong in the first place.
> The fwnode API change was on fast-forward and mistakes
> were made, also by me, mea culpa.

The name fwnode_get_named_gpiod() tries to follow of_get_named_gpio() so
that we can easily convert a driver to use fwnodes instead. The other
function is named so because we look child fwnodes under a device. For
that, yes certainly we could have invented a better name ;-)
