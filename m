From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Mar 2015 23:49:51 +0000
Subject: Re: [PATCH v1 03/47] devres: add devm_ioremap_wc()
Message-Id: <CALCETrX5K4pZE0DqcEwJiKYZofCr6yjJGK8MhjhPXMHNLJ4TTQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com> <1426893517-2511-4-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-4-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> We have devm_ioremap_nocache() but no devm_ioremap_wc()
> so add that. This will be used later.
>
> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>

Looks good to me.

> ---
>  Documentation/driver-model/devres.txt |  1 +
>  include/linux/io.h                    |  2 ++
>  lib/devres.c                          | 29 +++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index e1e2bbd..831a536 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -276,6 +276,7 @@ IOMAP
>    devm_ioport_unmap()
>    devm_ioremap()
>    devm_ioremap_nocache()
> +  devm_ioremap_wc()
>    devm_ioremap_resource() : checks resource, requests memory region, ioremaps
>    devm_iounmap()
>    pcim_iomap()
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 4cc299c..91101a1 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -72,6 +72,8 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>                            resource_size_t size);
>  void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>                                    resource_size_t size);
> +void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> +                             resource_size_t size);
>  void devm_iounmap(struct device *dev, void __iomem *addr);
>  int check_signature(const volatile void __iomem *io_addr,
>                         const unsigned char *signature, int length);
> diff --git a/lib/devres.c b/lib/devres.c
> index 0f1dd2e..2eb2bfe 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -72,6 +72,35 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>  EXPORT_SYMBOL(devm_ioremap_nocache);
>
>  /**
> + * devm_ioremap_wc - Managed ioremap_wc()
> + * @dev: Generic device to remap IO address for
> + * @offset: BUS offset to map
> + * @size: Size of map
> + *
> + * Managed ioremap_wc().  Map is automatically unmapped on driver
> + * detach.
> + */
> +void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
> +                             resource_size_t size)
> +{
> +       void __iomem **ptr, *addr;
> +
> +       ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> +       if (!ptr)
> +               return NULL;
> +
> +       addr = ioremap_wc(offset, size);
> +       if (addr) {
> +               *ptr = addr;
> +               devres_add(dev, ptr);
> +       } else
> +               devres_free(ptr);
> +
> +       return addr;
> +}
> +EXPORT_SYMBOL_GPL(devm_ioremap_wc);
> +
> +/**
>   * devm_iounmap - Managed iounmap()
>   * @dev: Generic device to unmap for
>   * @addr: Address to unmap
> --
> 2.3.2.209.gd67f9d5.dirty
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
