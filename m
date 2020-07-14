From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Tue, 14 Jul 2020 13:37:27 +0000
Subject: Re: [PATCH] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
 <CGME20200714072231eucas1p17c53f0a661346ebfd316ebd5796ca346@eucas1p1.samsung.com>
 <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
 <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
In-Reply-To: <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On 2020/07/14 19:27, Tetsuo Handa wrote:
> On 2020/07/14 16:22, Bartlomiej Zolnierkiewicz wrote:
>> How does this patch relate to:
>>
>> 	https://marc.info/?l=linux-fbdev&m9415024816722&w=2
>>
>> ?
>>
>> It seems to address the same issue, I've added George and Dan to Cc:.
> 
> George Kennedy's patch does not help for my case.
> 

OK. You can add

Reported-and-tested-by: syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>

to my patch.

By the way, if

  /* bitfill_aligned() assumes that it's at least 8x8 */

is true, don't we need to also check that the rect to fill is at least
8x8 in bit_clear_margins() ? (Well, I feel did it mean multiple of 8x8 ?
Then, what is bitfill_unaligned() for ?)
