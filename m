From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2020 08:26:24 +0000
Subject: Re: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
Message-Id: <20200916082624.GC509119@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <00000000000024be1505ad487cbb@google.com>
 <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
 <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
In-Reply-To: <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-fbdev@vger.kernel.org, syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, george.kennedy@oracle.com, natechancellor@gmail.com, jirislaby@kernel.org

On Wed, Sep 16, 2020 at 09:01:06AM +0900, Tetsuo Handa wrote:
> Greg, will you pick up this patch?
> 
> It seems that finding the real cause of [3] and actually fixing [3] will be difficult.
> Since I can't reproduce [3] locally, I will have to try flood of "#syz test" requests
> for debug printk() patches.

I agree with Daniel here, can you retest these against Linus's latest
tree please?

thanks,

greg k-h
