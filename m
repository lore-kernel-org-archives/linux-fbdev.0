From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 13 Jun 2018 15:42:11 +0000
Subject: Re: [PATCH V2 1/2] efi/fb: Simplify fixup code to prefer struct resource
Message-Id: <CAKv+Gu-LkJBa+QKwROqWApfKHjZ8huDYPi9FanU2AhKECv=dog@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> Get rid of base and size variables in favor of a struct resource.
> The conditional for checking window can be replaced with
> resource_contains().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/video/fbdev/efifb.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 46a4484..6daac8d 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -426,17 +426,20 @@ static void record_efifb_bar_resource(struct pci_dev *dev, int idx, u64 offset)
>
>  static void efifb_fixup_resources(struct pci_dev *dev)
>  {
> -       u64 base = screen_info.lfb_base;
> -       u64 size = screen_info.lfb_size;
> +       struct resource screen_res = {
> +               .start = screen_info.lfb_base,
> +               .end = screen_info.lfb_base + screen_info.lfb_size - 1,
> +               .flags = IORESOURCE_MEM,
> +       };
>         int i;
>
>         if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>                 return;
>
>         if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -               base |= (u64)screen_info.ext_lfb_base << 32;
> +               screen_res.start |= (u64)screen_info.ext_lfb_base << 32;
>
> -       if (!base)
> +       if (!screen_res.start)
>                 return;
>
>         for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
> @@ -445,8 +448,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>                 if (!(res->flags & IORESOURCE_MEM))
>                         continue;
>
> -               if (res->start <= base && res->end >= base + size - 1) {
> -                       record_efifb_bar_resource(dev, i, base - res->start);
> +               if (resource_contains(res, &screen_res)) {
> +                       u64 win_offset =  screen_res.start - res->start;
> +
> +                       record_efifb_bar_resource(dev, i, win_offset);
>                         break;
>                 }
>         }
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
