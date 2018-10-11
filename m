From: Rob Clark <robdclark@gmail.com>
Date: Thu, 11 Oct 2018 01:16:30 +0000
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
Message-Id: <CAF6AEGs3dStuF6GfhfL7Y+zOZFGrLU_CaiDMzdHrD4OQ3ynm=g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181010151801.21489-1-robdclark@gmail.com>
 <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
In-Reply-To: <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, Hans de Goede <j.w.r.degoede@gmail.com>

On Wed, Oct 10, 2018 at 11:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
> > BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> > FB_BACKLIGHT prevents it from being built as a module.  There
> > doesn't seem to be any particularly good reason for this, so
> > switch FB_BACKLIGHT over to tristate.
> >
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
>
> I don't see anything immediately wrong, but anything related to
> BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
> and FB_BACKLIGHT is really fragile in Kconfig, because of the
> way those interact with other options.
>
> I've applied your patch to my randconfig build tree for testing,
> let's see what happens there before you apply it.
>

thanks.. tbh the fragility of backlight vs kconfig is why I've
procrastinated on fixing this for a while.. in the end the solution
seems not as bad as I feared (and after a iteration or two makes rhel
kernel builds for various archs happy, at least).. but defn some
randconfig build testing is in order.

PS. discovering that the thing you need to fix (a) never really worked
as intended, and (b) involves backlight + fbdev.. is never a good way
to start your day ;-)

BR,
-R
