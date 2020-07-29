From: Jiri Slaby <jirislaby@kernel.org>
Date: Wed, 29 Jul 2020 08:11:57 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200729070249.20892-1-jslaby@suse.cz>
 <55075898-bf95-1805-3358-b0d1438feaa9@nsfocus.com>
In-Reply-To: <55075898-bf95-1805-3358-b0d1438feaa9@nsfocus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>, b.zolnierkie@samsung.com
Cc: Security Officers <security@kernel.org>, Kyungtae Kim <kt0755@gmail.com>, Anthony Liguori <aliguori@amazon.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-distros@vs.openwall.org, Solar Designer <solar@openwall.com>, Yang Yingliang <yangyingliang@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>

Hi,

On 29. 07. 20, 9:53, 张云海 wrote:
> This patch dosen't fix the issue, the check should be in the loop.
> 
> The change of the VT sze is before vgacon_scrollback_update, not in the
> meantime.
> 
> Let's consider the following situation:
> 	suppose:
> 		vgacon_scrollback_cur->size is 65440
> 		vgacon_scrollback_cur->tail is 64960
> 		c->vc_size_row is 160
> 		count is 5
> 	
> 	Reset c->vc_size_row to 200 by VT_RESIZE, then call
> vgacon_scrollback_update.
> 	
> 	This will pass the check, since (vgacon_scrollback_cur->tail +
> c->vc_size_row)
> 	is 65160 which is less then vgacon_scrollback_cur->size(65440).
> 
> 	However, in the 3rd iteration of the loop, vgacon_scrollback_cur->tail
> is update
> 	to 65360, the memcpy will overflow.

But the loop checks for the overflow:
  if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
        vgacon_scrollback_cur->tail = 0;

So the first 2 iterations would write to the end of the buffer and this
3rd one should have zeroed ->tail.

thanks,
-- 
js
suse labs
