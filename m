From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 06 Mar 2020 12:55:05 +0000
Subject: Re: [v4] vgacon: Fix a UAF in vgacon_invert_region
Message-Id: <CAHk-=wgA7wCXf2s+ihRopi7dzfzc7hWQ0jGiQiV8vMW-XVdD-A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200304022429.37738-1-zhangxiaoxu5@huawei.com>
 <20200306103846.GS2363188@phenom.ffwll.local>
In-Reply-To: <20200306103846.GS2363188@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrew Morton <akpm@osdl.org>, Petr Mladek <pmladek@suse.com>, wangkefeng.wang@huawei.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Fri, Mar 6, 2020 at 4:38 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Linus, since this missed the -fixes pull from Dave maybe double check I'm
> not grossly wrong here and apply directly?

Hmm. I don't have the original email, mind just sending it to me (with
the proper added sign-off chain)?

It does strike me that there's nothing that seems to check for
overflow in the "(width << 1) * height" calculation. Hmm?

            Linus
