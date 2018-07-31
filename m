From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 31 Jul 2018 10:45:15 +0000
Subject: Re: [PATCH v3 1/2] console: Replace #if 0 with atomic var 'ignore_console_lock_warning'
Message-Id: <2644500.Kme8HshdzX@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180719101601.25076-1-tzimmermann@suse.de>
 <CGME20180719101612epcas1p29065a3316708e93559057de579e990fd@epcas1p2.samsung.com>
 <20180719101601.25076-2-tzimmermann@suse.de>
In-Reply-To: <20180719101601.25076-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky.work@gmail.com, sergey.senozhatsky@gmail.com, dri-devel@lists.freedesktop.org, hdegoede@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org

On Thursday, July 19, 2018 12:16:00 PM Thomas Zimmermann wrote:
> The macro WARN_CONSOLE_UNLOCKED prints a warning when a thread enters
> the console's critical section without having acquired the console
> lock. The console lock can be ignored when debugging the console using
> printk, but this makes WARN_CONSOLE_UNLOCKED generate unnecessary
> warnings.
> 
> The variable ignore_console_lock_warning temporarily disables
> WARN_CONSOLE_UNLOCKED. Developers interested in debugging the console's
> critical sections should increment it before entering the CS and
> decrement it after leaving the CS. Setting ignore_console_lock_warning
> is only for debugging. Regular operation should not manipulate it.
> 
> Acknoledgements: This patch is based on an earlier version by Steven
> Rostedt. The use of atomic increment/decrement was suggested by Petr
> Mladek.
> 
> Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Patch queued for 4.19 (w/ <asm/atomic.h> -> <linux/atomic.h> fixup), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

