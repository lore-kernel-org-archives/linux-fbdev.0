From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 16 Jul 2020 10:00:06 +0000
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <20200716100006.GN3278063@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
 <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
 <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
 <20200715151220.GE2571@kadam>
 <adfa8720-c411-dfe6-6b0f-7591dd95396c@i-love.sakura.ne.jp>
In-Reply-To: <adfa8720-c411-dfe6-6b0f-7591dd95396c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jul 16, 2020 at 12:29:00AM +0900, Tetsuo Handa wrote:
> On 2020/07/16 0:12, Dan Carpenter wrote:
> > I've complained about integer overflows in fbdev for a long time...
> > 
> > What I'd like to see is something like the following maybe.  I don't
> > know how to get the vc_data in fbmem.c so it doesn't include your checks
> > for negative.
> 
> Yes. Like I said "Thus, I consider that we need more sanity/constraints checks." at
> https://lore.kernel.org/lkml/b1e7dd6a-fc22-bba8-0abb-d3e779329bce@i-love.sakura.ne.jp/ ,
> we want basic checks. That's a task for fbdev people who should be familiar with
> necessary constraints.

I think the worldwide supply of people who understand fbdev and willing to
work on it is roughly 0. So if someone wants to fix this mess properly
(which likely means adding tons of over/underflow checks at entry points,
since you're never going to catch the driver bugs, there's too many and
not enough people who care) they need to fix this themselves.

Just to avoid confusion here.

> Anyway, my two patches are small and low cost; can we apply these patches regardless
> of basic checks?

Which two patches where?

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
