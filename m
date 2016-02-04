From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Feb 2016 09:34:23 +0000
Subject: Re: fb_write missing in skeleton
Message-Id: <CAMuHMdUrFvRbr7JWAfngQ-LWhD1aU+UhM6P+65ES=XrsW-hgPQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAJ2oMhJb_GJYAmd8Ey=4uZGOo69oKk6BhuR2=AUcACGi=0irDw@mail.gmail.com>
In-Reply-To: <CAJ2oMhJb_GJYAmd8Ey=4uZGOo69oKk6BhuR2=AUcACGi=0irDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Ran,

On Thu, Feb 4, 2016 at 10:22 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> On Thu, Feb 4, 2016 at 10:16 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Feb 3, 2016 at 9:54 PM, Ran Shalit <ranshalit@gmail.com> wrote:
>>> Is there any reason why fb_write is missing in skeletonfb.c  ?
>>> Isn't it required ?
>>
>> No, it's not required, cfr. the comments in include/linux/fb.h:
>>
>>         /* For framebuffers with strange non linear layouts or that do not
>>          * work with normal memory mapped access
>>          */
>>         ssize_t (*fb_read)(struct fb_info *info, char __user *buf,
>>                            size_t count, loff_t *ppos);
>>         ssize_t (*fb_write)(struct fb_info *info, const char __user *buf,
>>                             size_t count, loff_t *ppos);
>>
>> If not implemented, drivers/video/fbdev/core/fbmem.c:fb_write() will use
>> normal memory mapped access.

> But When we do:
>     > cp mybitmap > /dev/fb0
> Which method is called (isn't fb_write is called) ?

drivers/video/fbdev/core/fbmem.c:fb_write()

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
