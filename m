From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 15 Mar 2018 09:32:03 +0000
Subject: Re: fbcon non-desktop display use
Message-Id: <CAKMK7uER_hCNqrfAkHYsece7FNc05Cwd_PTkx9Hfv2wUuPjL4A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGu26P8B-JNPnRrvgKCirE+rE2vGpgo56Hxh_tKYxY2jrwcNRQ@mail.gmail.com>
In-Reply-To: <CAGu26P8B-JNPnRrvgKCirE+rE2vGpgo56Hxh_tKYxY2jrwcNRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Charles Lohr <lohr85@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: David Airlie <airlied@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>

On Thu, Mar 15, 2018 at 4:32 AM, Charles Lohr <lohr85@gmail.com> wrote:
> There was a patch submitted by Keith Packard which prevents fbcon from using
> non-desktop displays, but this breaks vive, and other HMD development/use on
> embedded and other fbdev systems (
> https://patchwork.kernel.org/patch/10053989/ ).
>
> Even if the vive is the only device connected, it will still not permit it
> to be operated.  See https://github.com/linux-sunxi/linux-sunxi/issues/291
> for dri with a lot of debugging turned on.
>
> I can understand that most users would probably prefer that the vive isn't
> automatically used if no other displays are available, however, the current
> behavior prevents use of the vive on all devices that use fbdev for their
> primary output.
>
> This patch allows enabling of non-desktop devices both as a kernel command
> line as well as by setting
> /sys/module/drm_kms_helper/parameters/drm_fbdev_permit_non_desktop.

Why exactly are you developing new userspace on top of fbdev? fbdev
never ever supported HMDs in any meaningful fashion (those things
didn't exist 20 years ago when fbdev was designed), and we have fbdev
in feature freeze mode since a few years now. Please explain a bit
more about what exactly you're trying to do here, and what's running
in userspace that makes you require fbdev.

Adding fbdev lists&maintainer.

Also please note that for graphics stuff we require a fully open
sourced userspace side of the stack when adding new support, which
this very much feels like. See:

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements>

> I've never sent an email to the kernel devel list, so I'm still a little
> nervous.  Especially because this is against a different branch, and I'm
> starting to think that I should be messaging there, but this is something
> that really needs to go upstream.

Welcome to upstream! You're doing perfectly fine. We're trying really
hard to be welcoming and respectful in the graphics subsystem, and
have an enforced Code of Conduct to that effect:

https://dri.freedesktop.org/docs/drm/gpu/introduction.html#code-of-conduct
-Daniel



>
> Signed-off-by:
>
> diff --git a/drivers/gpu/drm/drm_fb_helper.c
> b/drivers/gpu/drm/drm_fb_helper.c
> index 035784ddd..8bfaf79ff 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -55,6 +55,11 @@ MODULE_PARM_DESC(drm_fbdev_overalloc,
>                  "Overallocation of the fbdev buffer (%) [default="
>                  __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");
>
> +static bool drm_fbdev_permit_non_desktop;
> +module_param(drm_fbdev_permit_non_desktop, bool, 0644);
> +MODULE_PARM_DESC(drm_fbdev_permit_non_desktop,
> +               "Allow the framebuffer to use non-desktop displays
> [default=off]");
> +
>  static LIST_HEAD(kernel_fb_helper_list);
>  static DEFINE_MUTEX(kernel_fb_helper_lock);
>
> @@ -2109,7 +2114,7 @@ static bool drm_connector_enabled(struct drm_connector
> *connector, bool strict)
>  {
>         bool enable;
>
> -       if (connector->display_info.non_desktop)
> +       if (connector->display_info.non_desktop &&
> !drm_fbdev_permit_non_desktop)
>                 return false;
>
>         if (strict)
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
