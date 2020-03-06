From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 06 Mar 2020 13:12:16 +0000
Subject: Re: [v4] vgacon: Fix a UAF in vgacon_invert_region
Message-Id: <CAKMK7uF_JnyWi+2QUG9OscC9DUA+4wh4dZGAXXAyYeXMTzXFyw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200304022429.37738-1-zhangxiaoxu5@huawei.com>
 <20200306103846.GS2363188@phenom.ffwll.local>
 <CAHk-=wgA7wCXf2s+ihRopi7dzfzc7hWQ0jGiQiV8vMW-XVdD-A@mail.gmail.com>
In-Reply-To: <CAHk-=wgA7wCXf2s+ihRopi7dzfzc7hWQ0jGiQiV8vMW-XVdD-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@osdl.org>, Petr Mladek <pmladek@suse.com>, wangkefeng.wang@huawei.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Fri, Mar 6, 2020 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 6, 2020 at 4:38 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Linus, since this missed the -fixes pull from Dave maybe double check I'm
> > not grossly wrong here and apply directly?
>
> Hmm. I don't have the original email, mind just sending it to me (with
> the proper added sign-off chain)?

I'll stuff it into a pull and throw that your way, that's simplest.
btw we did add dri-devel to lore a while back, so should be there:

Message-ID: <20200304022429.37738-1-zhangxiaoxu5@huawei.com>
https://lore.kernel.org/dri-devel/20200304022429.37738-1-zhangxiaoxu5@huawei.com/

> It does strike me that there's nothing that seems to check for
> overflow in the "(width << 1) * height" calculation. Hmm?

Indeed I failed to hunt for that :-/ But I think we're good, in
vc_do_resize() we have

    if (cols > VC_RESIZE_MAXCOL || lines > VC_RESIZE_MAXROW)
        return -EINVAL;

And they're both (1<<15)-1 so I think should be good enough even on
32bit - I quickly checked and we're short of UINT_MAX:

$ echo $(((((1<<15)-1) << 1)*((1<<15)-1)))
2147352578

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
