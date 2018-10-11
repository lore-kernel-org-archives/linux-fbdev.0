From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Oct 2018 12:52:56 +0000
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
Message-Id: <CAK8P3a3RDzxj8H8Kd6ywsm5K25Nc5RApBjzUDdDyCaTtMHCudg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181010151801.21489-1-robdclark@gmail.com> <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
 <CAF6AEGs3dStuF6GfhfL7Y+zOZFGrLU_CaiDMzdHrD4OQ3ynm=g@mail.gmail.com>
 <CAK8P3a1zWzm4AS8C18NRQE7gaMy1jjo70+0b1h=yrxE395-2fg@mail.gmail.com> <CAF6AEGvXVv6iurN-FBd1F4NNufsuSP9=PaLBnMgMZNaAVVSKsg@mail.gmail.com>
In-Reply-To: <CAF6AEGvXVv6iurN-FBd1F4NNufsuSP9=PaLBnMgMZNaAVVSKsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Hans de Goede <j.w.r.degoede@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 10/11/18, Rob Clark <robdclark@gmail.com> wrote:
> On Thu, Oct 11, 2018 at 3:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Oct 11, 2018 at 3:16 AM Rob Clark <robdclark@gmail.com> wrote:
>> >
>> > On Wed, Oct 10, 2018 at 11:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> > >
>> > > On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
>> > > > BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
>> > > > FB_BACKLIGHT prevents it from being built as a module.  There
>> > > > doesn't seem to be any particularly good reason for this, so
>> > > > switch FB_BACKLIGHT over to tristate.
>> > > >
>> > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
>> > >
>> > > I don't see anything immediately wrong, but anything related to
>> > > BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
>> > > and FB_BACKLIGHT is really fragile in Kconfig, because of the
>> > > way those interact with other options.
>> > >
>> > > I've applied your patch to my randconfig build tree for testing,
>> > > let's see what happens there before you apply it.
>> > >
>> >
>> > thanks.. tbh the fragility of backlight vs kconfig is why I've
>> > procrastinated on fixing this for a while.. in the end the solution
>> > seems not as bad as I feared (and after a iteration or two makes rhel
>> > kernel builds for various archs happy, at least).. but defn some
>> > randconfig build testing is in order.
>>
>> Ok, my overnight testing shows no regression, so please add
>>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks
>
>>
>> > PS. discovering that the thing you need to fix (a) never really worked
>> > as intended, and (b) involves backlight + fbdev.. is never a good way
>> > to start your day ;-)
>>
>> I still have a bunch of related fixes in my tree that address
>> randconfig builds that never worked. I think at one point
>> I got a few 'Reviewed-by' replies from DRM folks, but then
>> nobody picked it up and subsequently it stopped applying.
>> I need to go back and dig out all the dependent patches from
>> my randconfig tree and resend that.
>
> I assume those patches (and this one) would be picked up via fbdev tree?

I think the others should go through the DRM tree, but I don't think
I'll have time to revisit them before the merge window, so don't wait
for that.

      Arnd
