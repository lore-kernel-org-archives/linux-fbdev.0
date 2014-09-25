From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Sep 2014 10:14:59 +0000
Subject: Re: [PATCH] drm/exynos/fbdev: set smem_len for fbdev
Message-Id: <CAMuHMdVrd0fLEhv+uSfKeJ_skHTSiJbAWqW-Q4WjL1xAvb=YwA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408891857-14258-1-git-send-email-djkurtz@chromium.org>
 <CAMuHMdUoh6+gDcZty76HJhcQcJvM5DyBiD4YrZGuAX9e+F32-w@mail.gmail.com>
 <CAGS+omD055Bk+czk5=SDMRu1g-HGZHBobgasKC9PjF80Ci-czA@mail.gmail.com>
In-Reply-To: <CAGS+omD055Bk+czk5=SDMRu1g-HGZHBobgasKC9PjF80Ci-czA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, DRI Development <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <me@guenthernoack.de>

On Thu, Sep 25, 2014 at 12:07 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Thu, Sep 25, 2014 at 5:32 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sun, Aug 24, 2014 at 4:50 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>>> Commit [0] stopped setting fix.smem_start and fix.smem_len when creating
>>> the fbdev.
>>>
>>> [0] 2f1eab8d8ab59e799f7d51d62410b398607a7bc3
>>>   drm/exynos/fbdev: don't set fix.smem/mmio_{start,len}
>>>
>>> However, smem_len is used by some userland applications to calculate the
>>> size for mmap.  In particular, it is used by xf86-video-fbdev:
>>>
>>> http://cgit.freedesktop.org/xorg/xserver/tree/hw/xfree86/fbdevhw/fbdevhw.c?id=xorg-server-1.15.99.903#n571
>>>
>>> So, let's restore setting the smem_len to unbreak things for these users.
>>>
>>> Note: we are still leaving smem_start set to 0.
>>
>> Doesn't this cause a system crash when userspace (e.g. fbtest) writes into
>> the mmap()ed /dev/fb*, as the wrong MMIO region is mapped?
>
> Do you see a crash during testing, or is your question hypothetical?

It was hypothetical.

> I don't think there will be one.  exynos's fbev defines its own
> fb_ops.fb_mmap, which uses dma_mmap_attrs() to mmap the fb's gem
> buffer, which was allocated by dma_alloc_attrs().  This bypasses the
> code in drivers/video/fbmem.c:fb_mmap() that references
> fix.smem_start.
>
> But, perhaps I am missing something?

Thanks, having your own mapping function explains the lack of crashes.

Still, some weird software may map /dev/mem instead of /dev/fb0, and
use fb_fix.smem_start. But that's also unsafe in the context of LPAE.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
