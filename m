From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 16 Sep 2020 10:06:31 +0000
Subject: Re: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
Message-Id: <3233dcc2-31d5-42e7-3d9d-b36a65b660ea@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <00000000000024be1505ad487cbb@google.com>
 <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
 <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
 <20200916082624.GC509119@kroah.com>
In-Reply-To: <20200916082624.GC509119@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, george.kennedy@oracle.com, natechancellor@gmail.com, jirislaby@kernel.org

On 2020/09/16 17:26, Greg KH wrote:
> On Wed, Sep 16, 2020 at 09:01:06AM +0900, Tetsuo Handa wrote:
>> Greg, will you pick up this patch?
>>
>> It seems that finding the real cause of [3] and actually fixing [3] will be difficult.
>> Since I can't reproduce [3] locally, I will have to try flood of "#syz test" requests
>> for debug printk() patches.
> 
> I agree with Daniel here, can you retest these against Linus's latest
> tree please?
> 

syzbot already reproduced these bugs using the latest commit. ;-)

You can find

  ci-upstream-kasan-gce-root 	2020/09/15 15:18 	upstream 	fc4f28bb 

record for "KASAN: global-out-of-bounds Read in bit_putcs" and

  ci-upstream-kasan-gce-root 	2020/09/16 09:54 	upstream 	fc4f28bb

record for "KASAN: global-out-of-bounds Read in fbcon_resize".
