From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 13 Jun 2018 15:45:48 +0000
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if translated by the bridge
Message-Id: <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org> <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> A host bridge is allowed to remap BAR addresses using _TRA attribute in
> _CRS windows.
>
> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>
> When a VGA device is behind such a host bridge and the resource is
> translated efifb driver is trying to do ioremap against bus address
> rather than the resource address and is failing to probe.
>
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x1e000000
> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> efifb: mode is 800x600x32, linelength200, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift$:16:8:0
>
> Use the host bridge offset information to convert bus address to
> resource address in the fixup.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Bartlomiej, could you please take these via the fbdev tree for v4.19?
Peter already gave his ack but Sinan dropped it (presumably because of
the split in v2)

Sinan, does this need to go to -stable? I.e., has it ever worked before?



> ---
>  drivers/video/fbdev/efifb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 6daac8d..429cc85 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -431,6 +431,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>                 .end = screen_info.lfb_base + screen_info.lfb_size - 1,
>                 .flags = IORESOURCE_MEM,
>         };
> +       struct pci_bus_region region;
>         int i;
>
>         if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> @@ -442,6 +443,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>         if (!screen_res.start)
>                 return;
>
> +       region.start = screen_res.start;
> +       region.end = screen_res.end;
> +       pcibios_bus_to_resource(dev->bus, &screen_res, &region);
> +
>         for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>                 struct resource *res = &dev->resource[i];
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
