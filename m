From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 29 Oct 2019 19:02:11 +0000
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <87zhhjjryk.fsf@x220.int.ebiederm.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029182320.GA17569@mwanda>
In-Reply-To: <20191029182320.GA17569@mwanda> (Dan Carpenter's message of "Tue,
        29 Oct 2019 21:23:20 +0300")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrea Righi <righi.andrea@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Peter Rosin <peda@axentia.se>, Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, Julia Lawall <Julia.Lawall@lip6.fr>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> The "fix" struct has a 2 byte hole after ->ywrapstep and the
> "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
> on the compiler.
>
> Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I have 13 more similar places to patch...  I'm not totally sure I
> understand all the issues involved.

What I have done in a similar situation with struct siginfo, is that
where the structure first appears I have initialized it with memset,
and then field by field.

Then when the structure is copied I copy the structure with memcpy.

That ensures all of the bytes in the original structure are initialized
and that all of the bytes are copied.

The goal is to avoid memory that has values of the previous users of
that memory region from leaking to userspace.  Which depending on who
the previous user of that memory region is could tell userspace
information about what the kernel is doing that it should not be allowed
to find out.

I tried to trace through where "info" and thus presumably "info->fix" is
coming from and only made it as far as  register_framebuffer.  Given
that I suspect a local memset, and then a field by field copy right
before copy_to_user might be a sound solution.  But ick.  That is a lot
of fields to copy.


Eric



>  drivers/video/fbdev/core/fbmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 6f6fc785b545..b4ce6a28aed9 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1109,6 +1109,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			ret = -EFAULT;
>  		break;
>  	case FBIOGET_FSCREENINFO:
> +		memset(&fix, 0, sizeof(fix));
>  		lock_fb_info(info);
>  		fix = info->fix;
>  		if (info->flags & FBINFO_HIDE_SMEM_START)
