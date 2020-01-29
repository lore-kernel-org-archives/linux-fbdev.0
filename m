From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 29 Jan 2020 14:59:07 +0000
Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
Message-Id: <CACT4Y+bavHG8esK3jsv0V40+9+mUOFaSdOD1+prpw6L4Wv816g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz>
 <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
 <20200129141517.GA13721@jagdpanzerIV.localdomain>
 <20200129141759.GB13721@jagdpanzerIV.localdomain>
 <20200129143754.GA15445@jagdpanzerIV.localdomain>
In-Reply-To: <20200129143754.GA15445@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, anon anon <742991625abc@gmail.com>, syzkaller <syzkaller@googlegroups.com>, DRI <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Wed, Jan 29, 2020 at 3:40 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> Cc-ing Dmitry and Tetsuo
>
> Original Message-id: CAA1EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com
>
> On (20/01/29 23:17), Sergey Senozhatsky wrote:
> > > Hmm. There is something strange about it. I use vga console quite
> > > often, and scrolling happens all the time, yet I can't get the same
> > > out-of-bounds report (nor have I ever seen it in the past), even with
> > > the reproducer. Is it supposed to be executed as it is, or are there
> > > any preconditions? Any chance that something that runs prior to that
> > > reproducer somehow impacts the system? Just asking.
> >
> > These questions were addressed to anon anon (742991625abc@gmail.com),
> > not to Bartlomiej.
>
> Could this be GCC_PLUGIN related?

syzkaller repros are meant to be self-contained, but they don't
capture the image and VM setup (or actual hardware). I suspect it may
have something to do with these bugs.
syzbot has reported a bunch of similar bugs in one of our internal kernels:

KASAN: slab-out-of-bounds Read in vgacon_scroll
KASAN: slab-out-of-bounds Read in vgacon_invert_region
KASAN: use-after-free Write in vgacon_scroll
KASAN: use-after-free Read in vgacon_scroll
KASAN: use-after-free Read in vgacon_invert_region
BUG: unable to handle kernel paging request in vgacon_scroll

But none on upstream kernels. That may be some difference in config?
I actually don't know what affects these things. When I tried to get
at least some coverage of that code in syzkaller I just understood
that relations between all these
tty/pty/ptmx/vt/pt/ldisc/vcs/vcsu/fb/con/dri/drm/etc are complex to
say the least...
