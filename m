From: Petr Mladek <pmladek@suse.com>
Date: Thu, 19 Jul 2018 08:53:03 +0000
Subject: Re: [PATCH v2 1/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180719085303.mkxu7i7zl4suybcz@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718093002.4596-1-tzimmermann@suse.de>
 <20180718093002.4596-2-tzimmermann@suse.de>
In-Reply-To: <20180718093002.4596-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, sergey.senozhatsky.work@gmail.com, hdegoede@redhat.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, sergey.senozhatsky@gmail.com, rostedt@goodmis.org, akpm@linux-foundation.org

On Wed 2018-07-18 11:30:02, Thomas Zimmermann wrote:
> If the console is unlocked during registration, the console subsystem
> generates significant amounts of warnings, which obfuscate actual
> debugging messages. Setting ignore_console_lock_warning while debugging
> console registration avoid the noise.
> 
> v2:
> 	- restore ignore_console_lock_warning if lock_fb_info() fails
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/fbmem.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 9e2f9d3c760e..432c26eeabfb 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1627,6 +1627,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>  	int i, ret;
>  	struct fb_event event;
>  	struct fb_videomode mode;
> +	bool saved_ignore_console_lock_warning = ignore_console_lock_warning;

Hmm, this approach is racy if there are other users
saving/setting/restoring ignore_console_lock_warning in parallel.
I mean that this works only when the entire safe/set/restore
operation is nested or sequential.

We might need another approach if there are more users,
e.g. use an atomic counter for ignore_console_lock_warning.

On the other hand, I wonder if there ever will be other user.
Also it is "just" for debugging. We could keep it simple for now.
It might be enough to add a comment into include/linux/console.h,
something like:

/*
 * Set ignore_console_lock_warning to true if you need to quiet
 * WARN_CONSOLE_UNLOCKED() for debugging purposes. Might need
 * another approach if manipulated by more users in parallel.
 */

Best Regards,
Petr
