From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Wed, 29 Jan 2020 14:40:52 +0000
Subject: Re: KASAN: slab-out-of-bounds Write in vgacon_scroll
Message-Id: <20200129143754.GA15445@jagdpanzerIV.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAA=061EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com>
 <CGME20200128124918eucas1p1f0ce2b2b7b33a5d63d33f876ef30f454@eucas1p1.samsung.com>
 <20200128124912.chttagasucdpydhk@pathway.suse.cz>
 <4ab69855-6112-52f4-bee2-3358664d0c20@samsung.com>
 <20200129141517.GA13721@jagdpanzerIV.localdomain>
 <20200129141759.GB13721@jagdpanzerIV.localdomain>
In-Reply-To: <20200129141759.GB13721@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anon anon <742991625abc@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Petr Mladek <pmladek@suse.com>, wangkefeng.wang@huawei.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, syzkaller@googlegroups.com, linux-fbdev@vger.kernel.org

Cc-ing Dmitry and Tetsuo

Original Message-id: CAA1EoW8AmjUrBLsJy5nTDz-1jeArLeB+z6HJuyZud0zZXug@mail.gmail.com

On (20/01/29 23:17), Sergey Senozhatsky wrote:
> > Hmm. There is something strange about it. I use vga console quite
> > often, and scrolling happens all the time, yet I can't get the same
> > out-of-bounds report (nor have I ever seen it in the past), even with
> > the reproducer. Is it supposed to be executed as it is, or are there
> > any preconditions? Any chance that something that runs prior to that
> > reproducer somehow impacts the system? Just asking.
> 
> These questions were addressed to anon anon (742991625abc@gmail.com),
> not to Bartlomiej.

Could this be GCC_PLUGIN related?

	-ss
