From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date: Fri, 20 Jul 2018 12:08:00 +0000
Subject: Re: [PATCH v3 0/2] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180720120800.GB11590@tigerII.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180719101601.25076-1-tzimmermann@suse.de>
In-Reply-To: <20180719101601.25076-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky.work@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, sergey.senozhatsky@gmail.com, hdegoede@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org

On (07/19/18 12:15), Thomas Zimmermann wrote:
> this is version 3 of the WARN_CONSOLE_UNLOCKED patch set. The
> macro prints a warning if the console's critical sections are
> entered without holding the console lock. This patch set allows
> to disable the warnings while debugging the console.
> 
> In the original approach, WARN_CONSOLE_UNLOCKED was disabled by
> setting ignore_console_lock_warning of type bool. As suggested by
> Petr Mladek, the new implementation is based on atomic_t and allows
> multiple threads to manipulate the warning state concurrently.
> 
> With version 3, the patch set now includes the patch for introducing
> ignore_console_lock_warning. This patch superseds all previous patches
> of the same purpose.
> 
> Best regards
> Thomas
> 
> v3:
> 	- implement ignore_console_lock_warning with atomic_t
> v2:
> 	- restore ignore_console_lock_warning if lock_fb_info() fails

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
