From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 15 Jul 2020 15:29:00 +0000
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <adfa8720-c411-dfe6-6b0f-7591dd95396c@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
 <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
 <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
 <20200715151220.GE2571@kadam>
In-Reply-To: <20200715151220.GE2571@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On 2020/07/16 0:12, Dan Carpenter wrote:
> I've complained about integer overflows in fbdev for a long time...
> 
> What I'd like to see is something like the following maybe.  I don't
> know how to get the vc_data in fbmem.c so it doesn't include your checks
> for negative.

Yes. Like I said "Thus, I consider that we need more sanity/constraints checks." at
https://lore.kernel.org/lkml/b1e7dd6a-fc22-bba8-0abb-d3e779329bce@i-love.sakura.ne.jp/ ,
we want basic checks. That's a task for fbdev people who should be familiar with
necessary constraints.

Anyway, my two patches are small and low cost; can we apply these patches regardless
of basic checks?
