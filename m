From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 15 Jul 2020 00:24:06 +0000
Subject: Re: [PATCH] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <a2433659-4f95-d508-11de-8273fd2b6632@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
 <CGME20200714072231eucas1p17c53f0a661346ebfd316ebd5796ca346@eucas1p1.samsung.com>
 <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
 <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
 <c5bf6d5c-8d0a-8df5-2a11-38bf37a11d67@oracle.com>
In-Reply-To: <c5bf6d5c-8d0a-8df5-2a11-38bf37a11d67@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: George Kennedy <george.kennedy@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Dan Carpenter <dan.carpenter@oracle.com>, Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>

On 2020/07/15 2:15, George Kennedy wrote:
> Can you try the a.out built from the original Syzkaller modified repro C program? It walks 0-7 through xres and yres of the fb_var_screeninfo struct.

I'm not familiar with exploit code. What do you want to explain via this program?

>   struct fb_var_screeninfo *varp = (struct fb_var_screeninfo *)0x200001c0;
>   struct fb_var_screeninfo *starting_varp = malloc(sizeof(struct fb_var_screeninfo *));

>     memcpy(starting_varp, varp, sizeof(struct fb_var_screeninfo));

>             memcpy(varp, starting_varp, sizeof(struct fb_var_screeninfo));

At least, I suspect there is a memory corruption bug in this program
because of malloc()ing only sizeof(struct fb_var_screeninfo *) bytes.
