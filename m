From: Hartley Sweeten <HartleyS@visionengravers.com>
Date: Fri, 24 Jul 2015 16:29:30 +0000
Subject: RE: [PATCH] ARM/fb: ep93xx: switch framebuffer to use modedb only
Message-Id: <BY1PR0101MB10638236FA06D785A5D8B741D0810@BY1PR0101MB1063.prod.exchangelabs.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437744688-29915-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1437744688-29915-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, July 24, 2015 6:31 AM, Linus Walleij wrote:
> All the EP93xx boards exclusively use modedb to look up video
> modes from the command line. Root out the parametrization of
> custom video modes from the platform data and board files
> and simplify the driver.
>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

