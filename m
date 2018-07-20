From: Petr Mladek <pmladek@suse.com>
Date: Fri, 20 Jul 2018 09:07:42 +0000
Subject: Re: [PATCH v3 1/2] console: Replace #if 0 with atomic var 'ignore_console_lock_warning'
Message-Id: <20180720090742.4v4gjyq332htja2j@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180719101601.25076-1-tzimmermann@suse.de>
 <20180719101601.25076-2-tzimmermann@suse.de>
In-Reply-To: <20180719101601.25076-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, sergey.senozhatsky.work@gmail.com, hdegoede@redhat.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, sergey.senozhatsky@gmail.com, rostedt@goodmis.org, akpm@linux-foundation.org

On Thu 2018-07-19 12:16:00, Thomas Zimmermann wrote:
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

Acked-by: Petr Mladek <pmladek@suse.com>

I have vacation the following two weeks. I prefer this version over
the previous one but I could live with both.

Best Regards,
Petr
