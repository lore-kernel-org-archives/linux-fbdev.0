From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Thu, 28 Aug 2014 14:33:43 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4Oy8X9CSpZjYnTRgZ_MsxXQ=zaP+kxiZ2b7Es4GjN+1iJw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com> <20140827141632.GB32243@ulmo>
 <53FF1D6C.6090205@redhat.com>
 <CAKON4OyXPjXx4q828kFgMsC_u7u3nqLPLxOp-kRZbS27yRKOEg@mail.gmail.com>
 <CAMuHMdU+zxUCU05YOpyuP1fx=Dgb5SZu=vbaJW13sQAaMBwU_w@mail.gmail.com>
In-Reply-To: <CAMuHMdU+zxUCU05YOpyuP1fx=Dgb5SZu=vbaJW13sQAaMBwU_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 28, 2014 at 10:20 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Aug 28, 2014 at 3:22 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>> 2) We don't want to hardcode these clocks into the kernel (sunxi) clk
>>> driver, instead the bootloader should tell the kernel about these clocks.
>>>
>>> So the only point of discussion left seems to be how to do 2...
>>
>> Wouldn't it be a lot simpler just to use existing fbdev (not KMS) and
>> whip together a device specific driver that claims the proper
>> resources? And just implement the minimal about of fbdev possible?
>> fbdev already is a driver library.
>
> Like... drivers/video/fbdev/offb.c?

I'd probably reclassify drivers/video/fbdev/simplefb.c as a skeleton
and use it as a template for making device specific versions of it.

I don't see why there is so much resistance to just making device
specific fb drivers.  Whenever the KMS driver gets written just
disable the device specific fb driver in the build.


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Jon Smirl
jonsmirl@gmail.com
