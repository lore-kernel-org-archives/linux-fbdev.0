From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Oct 2018 15:35:29 +0000
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
Message-Id: <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181010151801.21489-1-robdclark@gmail.com>
In-Reply-To: <20181010151801.21489-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Hans de Goede <j.w.r.degoede@gmail.com>, linux-kernel@vger.kernel.org

On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
> BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> FB_BACKLIGHT prevents it from being built as a module.  There
> doesn't seem to be any particularly good reason for this, so
> switch FB_BACKLIGHT over to tristate.
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>

I don't see anything immediately wrong, but anything related to
BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
and FB_BACKLIGHT is really fragile in Kconfig, because of the
way those interact with other options.

I've applied your patch to my randconfig build tree for testing,
let's see what happens there before you apply it.

      Arnd
