From: Tom Gundersen <teg@jklm.no>
Date: Sat, 07 Sep 2013 13:02:22 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CAG-2HqXH7fgrhWDfP9yU-k2maYvs-eYqyvA=J5QynycAyuGL=w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Sep 7, 2013 at 2:25 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> On Sat, Sep 7, 2013 at 1:47 PM, Tom Gundersen <teg@jklm.no> wrote:
>> A related question: is it expected that simplefb should be
>> significantly slower than efifb, or is that something worth looking
>> into? My boot with simplefb is roughly five seconds slower than with
>> efifb. Coincidentally, I notice the same (or similar slowdown) with
>> inteldrmfb when I see the oops (but not otherwise).
>
> That is probably related to the missing write-combine tag in ioremap.
> Stephen, any objections to this attached patch?
> Tom, if this solves the speed-issues, I will send it out once I get home.

This solves the speed issues. Thanks!

Feel free to add my tested-by.

Cheers,

Tom

> From dbfb8e12166d494cd60823cbe84134d5d1a73ec8 Mon Sep 17 00:00:00 2001
> From: David Herrmann <dh.herrmann@gmail.com>
> Date: Sat, 7 Sep 2013 14:22:01 +0200
> Subject: [PATCH] devm/simplefb: introduce and use devm_ioremap_wc()
>
> We want to use devm_ioremap_nocache() or even devm_ioremap_wc() to speed
> up fbdev writes _a lot_. As devm_ioremap_wc() doesn't exist, yet,
> introduce it along the way. Note that ioremap_wc() is aliases to
> ioremap_nocache() in asm-generic/{io,iomem}.h so we can safely expect all
> architectures to either provide it or use the same alias.
>
> Reported-by: Tom Gundersen <teg@jklm.no>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/video/simplefb.c |  4 ++--
>  include/linux/io.h       |  2 ++
>  lib/devres.c             | 28 ++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 8d78106..a29f1c4 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -212,8 +212,8 @@ static int simplefb_probe(struct platform_device *pdev)
>
>   info->fbops = &simplefb_ops;
>   info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
> - info->screen_base = devm_ioremap(&pdev->dev, info->fix.smem_start,
> - info->fix.smem_len);
> + info->screen_base = devm_ioremap_wc(&pdev->dev, info->fix.smem_start,
> +    info->fix.smem_len);
>   if (!info->screen_base) {
>   framebuffer_release(info);
>   return -ENODEV;
> diff --git a/include/linux/io.h b/include/linux/io.h
> index f4f42fa..c529410 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -62,6 +62,8 @@ void __iomem *devm_ioremap(struct device *dev,
> resource_size_t offset,
>      unsigned long size);
>  void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>      unsigned long size);
> +void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> +      unsigned long size);
>  void devm_iounmap(struct device *dev, void __iomem *addr);
>  int check_signature(const volatile void __iomem *io_addr,
>   const unsigned char *signature, int length);
> diff --git a/lib/devres.c b/lib/devres.c
> index 8235331..34af7a9 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -72,6 +72,34 @@ void __iomem *devm_ioremap_nocache(struct device
> *dev, resource_size_t offset,
>  EXPORT_SYMBOL(devm_ioremap_nocache);
>
>  /**
> + * devm_ioremap_wc - Managed ioremap_wc()
> + * @dev: Generic device to remap IO address for
> + * @offset: BUS offset to map
> + * @size: Size of map
> + *
> + * Managed ioremap_wc().  Map is automatically unmapped on driver detach.
> + */
> +void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> +      unsigned long size)
> +{
> + void __iomem **ptr, *addr;
> +
> + ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> + if (!ptr)
> + return NULL;
> +
> + addr = ioremap_wc(offset, size);
> + if (addr) {
> + *ptr = addr;
> + devres_add(dev, ptr);
> + } else
> + devres_free(ptr);
> +
> + return addr;
> +}
> +EXPORT_SYMBOL(devm_ioremap_wc);
> +
> +/**
>   * devm_iounmap - Managed iounmap()
>   * @dev: Generic device to unmap for
>   * @addr: Address to unmap
> --
> 1.8.4
