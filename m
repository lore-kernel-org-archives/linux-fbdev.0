From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 26 May 2011 03:54:26 +0000
Subject: Re: [PATCH 27/29] vt8500lcdfb: use display information in info not in
Message-Id: <BANLkTin6YzLUu=pjSigbH+bwMuXjcwX=dQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-28-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-28-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

2011/5/26 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> We must not use any information in the passed var besides xoffset,
> yoffset and vmode as otherwise applications might abuse it.

Agreed, thanks for the fix!

> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Alexey Charkov <alchark@gmail.com>
> ---
>  drivers/video/vt8500lcdfb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> index 0e120d6..c13c246 100644
> --- a/drivers/video/vt8500lcdfb.c
> +++ b/drivers/video/vt8500lcdfb.c
> @@ -210,8 +210,8 @@ static int vt8500lcd_pan_display(struct fb_var_screeninfo *var,
>        struct vt8500lcd_info *fbi = to_vt8500lcd_info(info);
>
>        writel((1 << 31)
> -               | (((var->xres_virtual - var->xres) * pixlen / 4) << 20)
> -               | (off >> 2), fbi->regbase + 0x20);
> +            | (((info->var.xres_virtual - info->var.xres) * pixlen / 4) << 20)
> +            | (off >> 2), fbi->regbase + 0x20);
>        return 0;
>  }
>
> --
> 1.7.3.4
>
>

Best regards,
Alexey
