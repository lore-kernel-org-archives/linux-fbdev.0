From: David Herrmann <dh.herrmann@gmail.com>
Date: Sun, 30 Jun 2013 17:42:36 +0000
Subject: Re: [PATCH] fbmem: Export fb_get_options and (un)register_framebuffer symbols
Message-Id: <CANq1E4SZ3rVHpjoAtyiKwpgxjxVy_V0i_L8cUk6vr4KASTWRoQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372624575-7664-1-git-send-email-ismael.luceno@gmail.com>
In-Reply-To: <1372624575-7664-1-git-send-email-ismael.luceno@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

On Sun, Jun 30, 2013 at 10:36 PM, Ismael Luceno <ismael.luceno@gmail.com> wrote:
> Signed-off-by: Ismael Luceno <ismael.luceno@gmail.com>
> ---
>  drivers/video/fbmem.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 098bfc6..910909c 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1743,6 +1743,7 @@ register_framebuffer(struct fb_info *fb_info)
>
>         return ret;
>  }
> +EXPORT_SYMBOL(register_framebuffer);

These EXPORT_SYMBOL() calls should all be available at the end of fbmem.c.

Cheers
David

>
>  /**
>   *     unregister_framebuffer - releases a frame buffer device
> @@ -1771,6 +1772,7 @@ unregister_framebuffer(struct fb_info *fb_info)
>
>         return ret;
>  }
> +EXPORT_SYMBOL(unregister_framebuffer);
>
>  /**
>   *     fb_set_suspend - low level driver signals suspend
> @@ -1910,6 +1912,7 @@ int fb_get_options(char *name, char **option)
>
>         return retval;
>  }
> +EXPORT_SYMBOL(fb_get_options);
>
>  #ifndef MODULE
>  /**
> --
> 1.8.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
