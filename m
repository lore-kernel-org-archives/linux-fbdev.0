From: =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
Date: Wed, 29 Jul 2020 08:19:00 +0000
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-Id: <c5a73038-f441-602b-584b-3d84622b1fb1@nsfocus.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
In-Reply-To: <c1f267aa-dfb3-91fa-3111-30c1676f1a91@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jirislaby@kernel.org>, b.zolnierkie@samsung.com
Cc: Security Officers <security@kernel.org>, Kyungtae Kim <kt0755@gmail.com>, Anthony Liguori <aliguori@amazon.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-distros@vs.openwall.org, Solar Designer <solar@openwall.com>, Yang Yingliang <yangyingliang@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>

On 2020/7/29 16:11, Jiri Slaby wrote:
> But the loop checks for the overflow:
>   if (vgacon_scrollback_cur->tail >= vgacon_scrollback_cur->size)
>         vgacon_scrollback_cur->tail = 0;
> 
> So the first 2 iterations would write to the end of the buffer and this
> 3rd one should have zeroed ->tail.

In the 2nd  iteration before the check:
vgacon_scrollback_cur->tail is 65360 which is still less then
vgacon_scrollback_cur->size(65440), so the ->tail won't be zeroed.

Then it gose to the 3rd  iteration, overflow occurs.

Regards,
Yunhai Zhang / NSFOCUS Security Team
