From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 19 Oct 2019 10:35:03 +0000
Subject: Re: [PATCH 00/46] ARM: pxa: towards multiplatform support
Message-Id: <87r239f2g8.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <87v9slg9k5.fsf@belgarion.home>
 <CAK8P3a1JDtHsOW=iaxEycbJ4TBkR9MHUyDMeJnwxCtb=tefnBQ@mail.gmail.com>
 <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
In-Reply-To: <CAK8P3a0376Anmoc8VWXcEBg+z2B+1vcxJoywYYROBQNxpVmZuA@mail.gmail.com>
 (Arnd Bergmann's message of "Fri, 18 Oct 2019 21:32:36 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-rtc@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, IDE-ML <linux-ide@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, linux-leds@vger.kernel.org, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Arnd Bergmann <arnd@arndb.de> writes:

> On Fri, Oct 18, 2019 at 9:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Oct 18, 2019 at 9:04 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> > Arnd Bergmann <arnd@arndb.de> writes:
>> >
>> > > Hi PXA maintainers,
>> > >
>> > > I'm in the process of getting the old ARM platforms to all build
>> > > in a single kernel. The largest part of that work is changing all
>> > > the device drivers to no longer require mach/*.h header files.
>> > >
>> > > This series does it for arch/pxa/.
>> > >
>> > > As with the omap1 and s3c24xx series I sent before, I don't
>> > > expect this all to be correct in the first version, though
>> > > a lot of the patches are fairly simple and I did exhaustive
>> > > compile-time testing on them.
>> > >
>> > > Please test if you have the hardware, or review!
>> >
>> > Hi Arnd,
>> >
>> > Would you have a git tree I can pull from ?
>> > That would make my life easier than applying manually 46 patches...
>>
>> I've now pushed it to
>>
>> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
>> pxa-multiplatform
>
> Sorry for the duplication, I had some problems with email configuration
> so my reply got rejected, let's see if it goes through this time.
I have it now, thanks, I'll test and review as soon as I can.

Cheers.

-- 
Robert
