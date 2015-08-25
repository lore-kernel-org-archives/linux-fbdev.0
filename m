From: Rob Clark <robdclark@gmail.com>
Date: Tue, 25 Aug 2015 19:24:08 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <CAF6AEGu54g+5Q0ZQXeMd7HLHkGWPw+sdo-FZ4qVS=9nB6nLwtw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
In-Reply-To: <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Tue, Aug 25, 2015 at 9:45 AM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> When the usual fbcon legacy options are enabled we have
> ->register_framebuffer
>   ->fb notifier chain calls into fbcon
>     ->fbcon sets up console on new fbi
>       ->fbi->set_par
>         ->drm_fb_helper_set_par exercises full kms api
>
> And because of locking inversion hilarity all of register_framebuffer
> is done with the console lock held. Which means that the first time on
> driver load we exercise _all_ the kms code (all probe paths and
> modeset paths for everything connected) is under the console lock.
> That means if anything goes belly-up in that big pile of code nothing
> ever reaches logfiles (and the machine is dead).
>
> Usual tactic to debug that is to temporarily remove those console_lock
> calls to be able to capture backtraces. I'm fed up writing this patch
> and recompiling kernels. Hence this patch here to add an unsafe,
> kernel-taining option to do this at runtime.
>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

This one was causing me some problems, if I tried to enable
lockless_register_fb.  It *looks* like it should work, so I'm not
quite sure what the deal is.  But I'm 110% fan of getting something
like this working, because console_lock is pretty much the bane of kms
developer's existence..

I'll have to debug further on a system where I can see more than the
bottom three lines of the second to last backtrace..

BR,
-R

> ---
>  drivers/video/fbdev/core/fbmem.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 0705d8883ede..4e73b6f6b1c0 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1608,6 +1608,11 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
>         return 0;
>  }
>
> +static bool lockless_register_fb;
> +module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
> +MODULE_PARM_DESC(lockless_register_fb,
> +       "Lockless framebuffer registration for debugging [default=off]");
> +
>  static int do_register_framebuffer(struct fb_info *fb_info)
>  {
>         int i, ret;
> @@ -1675,15 +1680,18 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>         registered_fb[i] = fb_info;
>
>         event.info = fb_info;
> -       console_lock();
> +       if (!lockless_register_fb)
> +               console_lock();
>         if (!lock_fb_info(fb_info)) {
> -               console_unlock();
> +               if (!lockless_register_fb)
> +                       console_unlock();
>                 return -ENODEV;
>         }
>
>         fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
>         unlock_fb_info(fb_info);
> -       console_unlock();
> +       if (!lockless_register_fb)
> +               console_unlock();
>         return 0;
>  }
>
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
