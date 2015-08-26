From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 26 Aug 2015 19:48:13 +0000
Subject: Re: [PATCH -next] drivers/video/fbdev: Add dependencies on !S390
Message-Id: <20150826194813.GY8051@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440588770-17774-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1440588770-17774-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>


Hey Guenter,

thanks so much for your patch, my feedback below! I'll proactively
Cc Andrew and Steven as they're the other ones who I've seen as
hawks to compile issues on linux-next so I expect they'll soon
run into this as well if they are also testing against s390.

On Wed, Aug 26, 2015 at 04:32:50AM -0700, Guenter Roeck wrote:
> s390:allmodconfig fails to build with:
> 
> ERROR: "pci_iomap_wc" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: "pci_iomap_wc" [drivers/video/fbdev/s3fb.ko] undefined!
> ERROR: "pci_iomap_wc" [drivers/video/fbdev/arkfb.ko] undefined!
> 
> Those functions are currently only available in generic PCI iomap code,
> which is not used on S390.
> 
> Fixes: 81bdef04d3bc ("drivers/video/fbdev/vt8623fb: Use arch_phys_wc_add() and pci_iomap_wc()")
> Fixes: 4edcd2ab1255 ("drivers/video/fbdev/s3fb: Use arch_phys_wc_add() and pci_iomap_wc()")
> Fixes: c823a48ac47f ("drivers/video/fbdev/arkfb.c: Use arch_phys_wc_add() and pci_iomap_wc()")

Those commit IDs are only sepcific to linux-next and as such are
ephemeral.

> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/video/fbdev/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 8b1d371b5404..6b1893e5c769 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1442,6 +1442,7 @@ config FB_ATY_BACKLIGHT
>  config FB_S3
>  	tristate "S3 Trio/Virge support"
>  	depends on FB && PCI
> +	depends on !S390
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> @@ -1649,6 +1650,7 @@ config FB_VOODOO1
>  config FB_VT8623
>  	tristate "VIA VT8623 support"
>  	depends on FB && PCI
> +	depends on !S390
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> @@ -1683,6 +1685,7 @@ config FB_TRIDENT
>  config FB_ARK
>  	tristate "ARK 2000PV support"
>  	depends on FB && PCI
> +	depends on !S390
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT

Although this is one way to resolve it, the patch does not explain why
its needed, and this would also mean its a reactive solution, we either
test-compile and find issues or expect and hope developers will also
annotate this themselves when using this new API. I rather we define
it S390, which I do below.

The reason S390 requires its own S390 requires its own pci_iomap*()
calls is because it has its "BAR spaces are not disjunctive on s390
so we need the bar parameter of pci_iomap to find the corresponding
device and create the mapping cookie." but in summary, it has its own
lookup/lock solution. It does not include asm-generic/pci_iomap.h
and requires implementing the generic solutoins on its own then.

As for write-combining, it has no specific solution for this so
its ioremap_wc() is a direct mapping, so we can just do a 1-1
mapping to the non-wc calls as well then. If we do this then we
don't have to go on fixing drivers when they use this new API and
if and when S390 gets some form of WC it can go and update its
implementation but right now it has none.

I've tested the patch below on linux-next with make.cross ARCH=s390
with allyesconfig and it fixes the compile issue. I'll post this as
a patch fix. Let me know if this is agreeable to you.

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index cb5fdf3a78fc..437e9af96688 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -57,6 +57,8 @@ static inline void ioport_unmap(void __iomem *p)
  */
 #define pci_iomap pci_iomap
 #define pci_iounmap pci_iounmap
+#define pci_iomap_wc pci_iomap
+#define pci_iomap_wc_range pci_iomap_range
 
 #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
 #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
