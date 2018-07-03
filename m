From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 03 Jul 2018 07:34:52 +0000
Subject: Re: [PATCH] video/console/vgacon: Print big fat warning with nomodeset
Message-Id: <20180703073452.GD7880@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180702210442.18648-1-lyude@redhat.com>
In-Reply-To: <20180702210442.18648-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lyude Paul <lyude@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>

On Mon, Jul 02, 2018 at 05:04:40PM -0400, Lyude Paul wrote:
> It's been a pretty good while since kernel modesetting was introduced.
> It has almost entirely replaced previous solutions which required
> userspace modesetting, and I can't even recall any drivers off the top
> of my head for modern day hardware that don't only support one or the
> other. Even nvidia's ugly blob does not require the use of nomodeset,
> and only requires that nouveau be blacklisted.
> 
> Effectively, the only thing nomodeset does in the year 2018 is disable
> your graphics drivers. Since VESA is a thing, this will give many users
> the false impression that they've actually fixed an issue they were
> having with their machine simply because the laptop will boot up to a
> degraded GUI. This of course, is never actually the case.
> 
> Things get even worse when you consider that there's still an enormous
> amount of tutorials users find on the internet that still suggest adding
> nomodeset, along with various users who have been around long enough to
> still suggest it.
> 
> There really isn't any legitimate reason I can see for this to be an
> option that's used by anyone else other then developers, or properly
> informed users. So, let's end the confusion and start printing warnings
> whenever it's enabled.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Yeah makes tons of sense. I think we should also perhaps mark the option
as a tainting one, but I think that's only wired up for module option.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/console/vgacon.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index f09e17b60e45..09731b2f6815 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -112,6 +112,11 @@ EXPORT_SYMBOL(vgacon_text_force);
>  static int __init text_mode(char *str)
>  {
>  	vgacon_text_mode_force = true;
> +
> +	pr_warning("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
> +	pr_warning("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
> +	pr_warning("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
> +
>  	return 1;
>  }
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
