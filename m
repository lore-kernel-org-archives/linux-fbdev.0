From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 11 Aug 2020 15:10:12 +0000
Subject: Re: [PATCH] vt: defer kfree() of vc_screenbuf in vc_do_resize()
Message-Id: <20200811151012.GA427920@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <0c9d8003-ba3f-8f2d-7c5a-56c5ca7db750@i-love.sakura.ne.jp>
 <20200804125831.GA221149@kroah.com>
 <6053bc22-0876-f503-c1b6-3181a70d97de@i-love.sakura.ne.jp>
In-Reply-To: <6053bc22-0876-f503-c1b6-3181a70d97de@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>, Jiri Slaby <jslaby@suse.com>

On Wed, Aug 12, 2020 at 12:02:03AM +0900, Tetsuo Handa wrote:
> On 2020/08/04 21:58, Greg Kroah-Hartman wrote:
> > On Tue, Aug 04, 2020 at 08:15:43PM +0900, Tetsuo Handa wrote:
> >> Do you think this approach is acceptable? Or, do we need to modify set_origin() ?
> >>
> > I think what you have here is fine, as cleaning up set_orgin() might be
> > hard to do at this point in time.
> > 
> 
> Seems that there is no comment. Greg, will you pick up this patch?

Yes, will do after -rc1 is out.

thanks,

greg k-h
