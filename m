From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 06 Mar 2020 13:24:05 +0000
Subject: Re: [v4] vgacon: Fix a UAF in vgacon_invert_region
Message-Id: <CAHk-=wi-vJ9-snUQeotBD0Zmb-Y=ggPQcY3yP=M2qjsXttvCOQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200304022429.37738-1-zhangxiaoxu5@huawei.com>
 <20200306103846.GS2363188@phenom.ffwll.local>
 <CAHk-=wgA7wCXf2s+ihRopi7dzfzc7hWQ0jGiQiV8vMW-XVdD-A@mail.gmail.com>
 <CAKMK7uF_JnyWi+2QUG9OscC9DUA+4wh4dZGAXXAyYeXMTzXFyw@mail.gmail.com>
In-Reply-To: <CAKMK7uF_JnyWi+2QUG9OscC9DUA+4wh4dZGAXXAyYeXMTzXFyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrew Morton <akpm@osdl.org>, Petr Mladek <pmladek@suse.com>, wangkefeng.wang@huawei.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Fri, Mar 6, 2020 at 7:12 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> I'll stuff it into a pull and throw that your way, that's simplest.

Thanks.

> btw we did add dri-devel to lore a while back, so should be there:

Indeed. I tried (incompetently) to look up your message ID, but I
didn't put the dri-devel part and saw the 404, and assumed it wasn't
there.

My bad.

> > It does strike me that there's nothing that seems to check for
> > overflow in the "(width << 1) * height" calculation. Hmm?
>
> Indeed I failed to hunt for that :-/ But I think we're good, in
> vc_do_resize() we have
>
>     if (cols > VC_RESIZE_MAXCOL || lines > VC_RESIZE_MAXROW)
>         return -EINVAL;

Perfect. I just looked at the quoted patch itself.

            Linus
