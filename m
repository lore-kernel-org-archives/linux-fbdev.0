From: Ran Shalit <ranshalit@gmail.com>
Date: Thu, 04 Feb 2016 09:22:15 +0000
Subject: Re: fb_write missing in skeleton
Message-Id: <CAJ2oMh+9ks5h6DG9_iL1kaQtZFSLggzs9KXCSydiTxo1QRqNFg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAJ2oMhJb_GJYAmd8Ey=4uZGOo69oKk6BhuR2=AUcACGi=0irDw@mail.gmail.com>
In-Reply-To: <CAJ2oMhJb_GJYAmd8Ey=4uZGOo69oKk6BhuR2=AUcACGi=0irDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Feb 4, 2016 at 10:16 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Ran,
>
> On Wed, Feb 3, 2016 at 9:54 PM, Ran Shalit <ranshalit@gmail.com> wrote:
>> Is there any reason why fb_write is missing in skeletonfb.c  ?
>> Isn't it required ?
>
> No, it's not required, cfr. the comments in include/linux/fb.h:
>
>         /* For framebuffers with strange non linear layouts or that do not
>          * work with normal memory mapped access
>          */
>         ssize_t (*fb_read)(struct fb_info *info, char __user *buf,
>                            size_t count, loff_t *ppos);
>         ssize_t (*fb_write)(struct fb_info *info, const char __user *buf,
>                             size_t count, loff_t *ppos);
>
> If not implemented, drivers/video/fbdev/core/fbmem.c:fb_write() will use
> normal memory mapped access.
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

Thanks  Geert !

But When we do:
    > cp mybitmap > /dev/fb0
Which method is called (isn't fb_write is called) ?

Is there a readme/tutorial which list the relation between userspace
operations (read/write/ioctl etc) to framebuffer drivers callbacks ?
I couldn't find any.

Best Regards,
Ran
