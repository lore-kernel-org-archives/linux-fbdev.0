From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 31 Jul 2018 15:38:47 +0000
Subject: Re: [PATCH v3 1/2] console: Replace #if 0 with atomic var 'ignore_console_lock_warning'
Message-Id: <20180731113847.4ae433b0@gandalf.local.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180719101601.25076-1-tzimmermann@suse.de>
 <20180719101601.25076-2-tzimmermann@suse.de>
In-Reply-To: <20180719101601.25076-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, sergey.senozhatsky.work@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, hdegoede@redhat.com, akpm@linux-foundation.org

On Thu, 19 Jul 2018 12:16:00 +0200
Thomas Zimmermann <tzimmermann@suse.de> wrote:

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

You can also add a reference to that patch as well:

Link: http://lkml.kernel.org/r/20180712092938.22e33641@gandalf.local.home

-- Steve

> 
> Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  include/linux/console.h | 14 +++++++++-----
>  kernel/printk/printk.c  |  3 +++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index f59f3dbca65c..a3307bcab947 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -14,6 +14,7 @@
>  #ifndef _LINUX_CONSOLE_H_
>  #define _LINUX_CONSOLE_H_ 1
>  
> +#include <asm/atomic.h>
>  #include <linux/types.h>
>  
>  struct vc_data;
> @@ -201,11 +202,14 @@ void vcs_make_sysfs(int index);
>  void vcs_remove_sysfs(int index);
>  
>  /* Some debug stub to catch some of the obvious races in the VT code */
> -#if 1
> -#define WARN_CONSOLE_UNLOCKED()	WARN_ON(!is_console_locked() && !oops_in_progress)
> -#else
> -#define WARN_CONSOLE_UNLOCKED()
> -#endif
> +#define WARN_CONSOLE_UNLOCKED()						\
> +	WARN_ON(!atomic_read(&ignore_console_lock_warning) &&		\
> +		!is_console_locked() && !oops_in_progress)
> +/*
> + * Increment ignore_console_lock_warning if you need to quiet
> + * WARN_CONSOLE_UNLOCKED() for debugging purposes.
> + */
> +extern atomic_t ignore_console_lock_warning;
>  
>  /* VESA Blanking Levels */
>  #define VESA_NO_BLANKING        0
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 3f041e7cbfc9..7d32a86758cd 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -66,6 +66,9 @@ int console_printk[4] = {
>  	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
>  };
>  
> +atomic_t ignore_console_lock_warning __read_mostly = ATOMIC_INIT(0);
> +EXPORT_SYMBOL(ignore_console_lock_warning);
> +
>  /*
>   * Low level drivers may need that to know if they can schedule in
>   * their unblank() callback or not. So let's export it.

