From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Date: Thu, 25 Feb 2016 14:35:00 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <DF3259B0-8A3A-4AB0-A805-F5A8F7295E5C@konsulko.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com> <B8A82546-46C7-4A21-92D8-62418E49FBB6@konsulko.com>
 <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
In-Reply-To: <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Linus,

> On Feb 25, 2016, at 15:43 , Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> On Wed, Feb 24, 2016 at 1:13 PM, Pantelis Antoniou
> <pantelis.antoniou@konsulko.com> wrote:
> 
>> IMHO DT+overlays handle all your cases just fine.
>> 
>> As far as I see these are the cases which we need to handle:
>> 
>> 1) The expansion board in question has some means of identification, whether it’s an
>> EEPROM or a GPIO keying combination etc. In that case it is the kernel’s job to match this
>> id value with a dtbo firmware file and apply it. The blob is located via means of request_firmware().
> 
> Since the dawn of time the x86 people used that console to display
> the early boot crawl and collect crash data. What you're suggesting
> is that we can't get the console up until after the filesystems and mounts
> are up so the kernel can read firmware files.
> 
> This kills of early boot graphics and getting crash logs on the fbdev
> console until that has happened.
> 
> It also means there is no way to get the console up without the right
> firmware files in the filesystem. I think that is really crap compared
> to what we have today where the display will always come up, and
> basically a regression.
> 
> I understand the stance with respect to things like add-on hardware
> like a Bluetooth board or WLAN or whatnot. But the fbdev console
> is just too basic, like a serial port IMO.
> 
> Sure in the ARM world we usually have a serial console, but this is
> seriously breaking current practice.
> 

As Tomi mentioned firmware files can be located in the kernel image; there is no
requirement to be in a filesystem, and that application can be performed really
early, before even early init.

The comparison with x86 is not absolutely valid, since on x86 you know that
the video hardware is going to be present, always.

This is not so in ARM world, especially in the case we’re talking about, an add-on board.

> Yours,
> Linus Walleij

Regards

— Pantelis

