From: Kees Cook <keescook@chromium.org>
Date: Wed, 19 Aug 2020 22:07:46 +0000
Subject: Re: [PATCH v3] vt: Reject zero-sized screen buffer size.
Message-Id: <202008191452.0278B57D43@keescook>
List-Id: <linux-fbdev.vger.kernel.org>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jiri Slaby <jslaby@suse.com>, syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>, Dmitry Vyukov <dvyukov@google.com>

On Sun, Jul 12, 2020 at 08:10:12PM +0900, Tetsuo Handa wrote:
> [...]
> @@ -1125,6 +1134,11 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  	if (!*vc->vc_uni_pagedir_loc)
>  		con_set_default_unimap(vc);
>  
> +	err = -EINVAL;
> +	if (vc->vc_cols > VC_MAXCOL || vc->vc_rows > VC_MAXROW ||
> +	    vc->vc_screenbuf_size > KMALLOC_MAX_SIZE || !vc->vc_screenbuf_size)
> +		goto err_free;
> +	err = -ENOMEM;
>  	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
>  	if (!vc->vc_screenbuf)
>  		goto err_free;

I realize this patch already landed, but I wanted to remind folks to
use the check_*_overflow() helpers, which can make a lot of this kind
of stuff easier to deal with.

For example, in this case, I think visual_init() could likely be changed
to return success/failure and do all the sanity checking:

	if (check_shl_overflow(vc->vc_cols, 1, &vc->vc_size_row) ||
	    check_mul_overflow(vc->vc_rows, vc->vc_size_row, &vc->vc_screenbuf_size))
		return -EINVAL;


-- 
Kees Cook
