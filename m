From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Feb 2016 15:36:17 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdbi+cJFP8gUvuLKEWVVU_LScZDvnWH59RC7ug-xt2PK4Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com>
 <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com>
 <B8A82546-46C7-4A21-92D8-62418E49FBB6@konsulko.com>
 <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
 <DF3259B0-8A3A-4AB0-A805-F5A8F7295E5C@konsulko.com>
In-Reply-To: <DF3259B0-8A3A-4AB0-A805-F5A8F7295E5C@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 25, 2016 at 3:35 PM, Pantelis Antoniou
<pantelis.antoniou@konsulko.com> wrote:
>> On Feb 25, 2016, at 15:43 , Linus Walleij <linus.walleij@linaro.org> wrote:

>> It also means there is no way to get the console up without the right
>> firmware files in the filesystem. I think that is really crap compared
>> to what we have today where the display will always come up, and
>> basically a regression.
>>
>> I understand the stance with respect to things like add-on hardware
>> like a Bluetooth board or WLAN or whatnot. But the fbdev console
>> is just too basic, like a serial port IMO.
>>
>> Sure in the ARM world we usually have a serial console, but this is
>> seriously breaking current practice.
>
> As Tomi mentioned firmware files can be located in the kernel image; there is no
> requirement to be in a filesystem, and that application can be performed really
> early, before even early init.

Are you thinking about exploiting an appended DT with
CONFIG_ARM_APPENDED_DTB or something else?

Yours,
Linus Walleij
