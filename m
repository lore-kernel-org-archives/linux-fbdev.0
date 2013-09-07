From: David Herrmann <dh.herrmann@gmail.com>
Date: Sat, 07 Sep 2013 11:16:23 +0000
Subject: Re: [PATCH] simplefb: print some info about the registered fb
Message-Id: <CANq1E4Rxo3Az0hwCzzQyKz6z_uyVq-9bgAzNzm9StkWoAbkN_A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378467880-1040-1-git-send-email-teg@jklm.no>
	<1378468153-1375-1-git-send-email-teg@jklm.no>
In-Reply-To: <1378468153-1375-1-git-send-email-teg@jklm.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Gundersen <teg@jklm.no>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Stephen Warren <swarren@wwwdotorg.org>

Hi Tom

On Fri, Sep 6, 2013 at 1:49 PM, Tom Gundersen <teg@jklm.no> wrote:
> This is similar to the output printed by efifb.
>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> ---
>
> Hi,
>
> Sorry for the resend, got the ml address wrong.
>
> -t
>
>  drivers/video/simplefb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 8d78106..4196686 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -220,6 +220,14 @@ static int simplefb_probe(struct platform_device *pdev)
>         }
>         info->pseudo_palette = (void *)(info + 1);
>
> +       dev_info(&pdev->dev, "framebuffer at 0x%lx, mapped to 0x%p\n",
> +                            info->fix.smem_start, info->screen_base);

Could we get smem_len, too? Something like:
      dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%lx bytes, mapped
to 0x%p\n",
                           info->fix.smem_start, (unsigned
long)info->fix.smem_len, info->screen_base);

(smem_len is __u32, so cast it to avoid truncation if it's defined as
long somewhere. Not sure whether we actually have 16bit int somewhere,
though)

Cheers
David

> +       dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
> +                            params.format->name,
> +                            info->var.xres, info->var.yres,
> +                            info->var.bits_per_pixel,
> +                            info->fix.line_length);
> +
>         ret = register_framebuffer(info);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
> --
> 1.8.4
>
