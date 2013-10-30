From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 30 Oct 2013 07:49:05 +0000
Subject: Re: [PATCH 2/2] simplefb: use write-combined remapping
Message-Id: <CANq1E4SRWsKf4uqF01Rju-uSNF-gj9zL9_+0zAqsgPMjv8Q3Uw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380725919-1961-1-git-send-email-dh.herrmann@gmail.com>
	<1380725919-1961-2-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1380725919-1961-2-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-kernel <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Alexandre Courbot <acourbot@nvidia.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi Tomi

Ping?

Thanks
David

On Wed, Oct 2, 2013 at 4:58 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Framebuffers shouldn't be cached and it is usually very uncommon to read
> them. Therefore, use ioremap_wc() to get significant speed improvements on
> systems which provide it. On all other systems it's aliased to
> ioremap_nocache() which is also fine.
>
> Reported-by: Tom Gundersen <teg@jklm.no>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Tested-by: Tom Gundersen <teg@jklm.no>
> Tested-by: Alexandre Courbot <acourbot@nvidia.com>
> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
>  drivers/video/simplefb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 74b016c..64db54a 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -219,8 +219,8 @@ static int simplefb_probe(struct platform_device *pdev)
>
>         info->fbops = &simplefb_ops;
>         info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
> -       info->screen_base = ioremap(info->fix.smem_start,
> -                                   info->fix.smem_len);
> +       info->screen_base = ioremap_wc(info->fix.smem_start,
> +                                      info->fix.smem_len);
>         if (!info->screen_base) {
>                 framebuffer_release(info);
>                 return -ENODEV;
> --
> 1.8.4
>
