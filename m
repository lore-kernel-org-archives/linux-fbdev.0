From: Michal Suchanek <hramrach@gmail.com>
Date: Thu, 28 Aug 2014 20:31:03 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctS=E=ztjOzGru+jBkgJoYrGZ+Yb6Wv3j-Yv7iT+D9jyVQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather>
 <20140826080432.GD17263@ulmo> <20140826135341.GM15297@lukather>
 <20140826143550.GB3027@ulmo> <53FCE704.4030103@redhat.com>
 <20140827093121.GA23186@ulmo> <53FDB46C.5010609@redhat.com>
 <20140827125613.GF23186@ulmo> <53FDE0CE.5030807@redhat.com>
 <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
 <CAKON4OyXPjXx4q828kFgMsC_u7u3nqLPLxOp-kRZbS27yRKOEg@mail.gmail.com>
 <CAMuHMdU+zxUCU05YOpyuP1fx=Dgb5SZu=vbaJW13sQAaMBwU_w@mail.gmail.com>
 <CAKON4Oy8X9CSpZjYnTRgZ_MsxXQ=zaP+kxiZ2b7Es4GjN+1iJw@mail.gmail.com>
 <CAOMqctRvNbvFTb9dixCO1D0PfOWDgmBBs2U3yR5pvL8dFM_Lvw@mail.gmail.com>
 <CAKON4OyB55L5q7fVo43V8kgtqHRZ3vkBMaA+Htxpob-FA1obaA@mail.gmail.com>
In-Reply-To: <CAKON4OyB55L5q7fVo43V8kgtqHRZ3vkBMaA+Htxpob-FA1obaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 28 August 2014 18:34, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Thu, Aug 28, 2014 at 12:25 PM, Michal Suchanek <hramrach@gmail.com> wrote:
>> On 28 August 2014 16:33, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>> On Thu, Aug 28, 2014 at 10:20 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Thu, Aug 28, 2014 at 3:22 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>>>>> 2) We don't want to hardcode these clocks into the kernel (sunxi) clk
>>>>>> driver, instead the bootloader should tell the kernel about these clocks.
>>>>>>
>>>>>> So the only point of discussion left seems to be how to do 2...
>>>>>
>>>>> Wouldn't it be a lot simpler just to use existing fbdev (not KMS) and
>>>>> whip together a device specific driver that claims the proper
>>>>> resources? And just implement the minimal about of fbdev possible?
>>>>> fbdev already is a driver library.
>>>>
>>>> Like... drivers/video/fbdev/offb.c?
>>>
>>> I'd probably reclassify drivers/video/fbdev/simplefb.c as a skeleton
>>> and use it as a template for making device specific versions of it.
>>>
>>> I don't see why there is so much resistance to just making device
>>> specific fb drivers.  Whenever the KMS driver gets written just
>>> disable the device specific fb driver in the build.
>>
>> Except that is not the goal here. The simplefb or whatever replacement
>> is supposed to stay as a  generic driver compiled into kernel whereas
>
> There is no generic solution to this problem as this entire thread has
> illustrated. The clocks/regulators needed by each SOC vary.
>
> So there are two solutions..
> 1) modify simplefb to have some kind of heuristic that tries to guess
> what needs to be protected. A heuristic that is probably going to fail
> on every new SOC.

You do not need a heuristic when the bootloader that enabled the
clocks and regulators can tell you which.

And this patch was initially about adding support to simplefb to read
from DT where u-boot fills in the clocks that are needed for HDMI
output to keep running on sunxi.

>
> 2) Spend a day implementing a device specific fbdev driver that does
> the correct thing all of the time. These drivers would sit in initrd
> and load before the clock/regulator clean up shuts everything off. Use
> the existing simplefb code as a template for doing this.

But then you need to spend a day implementing such driver for every
SoC and it will not work before initrd is loaded.

In contrast simplefb with resource management support can work on any
platform where the bootloader enables framebuffer and then can be
compiled into generic kernel and work before even initrd is loaded.

Thanks

Michal
