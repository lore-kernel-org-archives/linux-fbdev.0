From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API
Date: Thu, 05 Jun 2008 17:26:54 -0500
Message-ID: <1212704814.4241.37.camel@localhost.localdomain>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

On Thu, 2008-06-05 at 23:13 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Convert console/sticore.c file to use PCI ROM API.
> 
> Addresses http://bugzilla.kernel.org/show_bug.cgi?id=9425
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> ---
> This patch was fixed and tested by Helge Deller on his
> PARISC machine.
> 
> 
> diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
> index e9ab657..df30499 100644
> --- a/drivers/video/console/sticore.c
> +++ b/drivers/video/console/sticore.c
> @@ -780,11 +780,13 @@ out_err:
>  }
>  
>  static struct sti_struct * __devinit
> -sti_try_rom_generic(unsigned long address, unsigned long hpa, struct pci_dev *pd)
> +sti_try_rom_generic(unsigned long address, unsigned long hpa,
> +		    struct pci_dev *pd)
>  {
> +	char __iomem *rom_base = (char __iomem *) address;
>  	struct sti_struct *sti;
>  	int ok;
> -	u32 sig;
> +	__le32 sig;
>  
>  	if (num_sti_roms >= MAX_STI_ROMS) {
>  		printk(KERN_WARNING "maximum number of STI ROMS reached !\n");
> @@ -808,7 +810,7 @@ test_rom:
>  	sig = gsc_readl(address);

Since gsc_readl() has (designedly) no endianness type, doesn't this give
a sparse warning?
 
>  	/* check for a PCI ROM structure */
> -	if ((le32_to_cpu(sig)==0xaa55)) {
> +	if (sig == cpu_to_le32(0xaa55)) {
>  		unsigned int i, rm_offset;
>  		u32 *rm;
>  		i = gsc_readl(address+0x04);
> @@ -868,10 +870,8 @@ test_rom:
>  	/* disable STI PCI ROM. ROM and card RAM overlap and
>  	 * leaving it enabled would force HPMCs
>  	 */
> -	if (sti->pd) {
> -		unsigned long rom_base;
> -		rom_base = pci_resource_start(sti->pd, PCI_ROM_RESOURCE);	
> -		pci_write_config_dword(sti->pd, PCI_ROM_ADDRESS, rom_base & ~PCI_ROM_ADDRESS_ENABLE);
> +	if (sti->pd && rom_base) {
> +		pci_unmap_rom(sti->pd, rom_base);
>  		DPRINTK((KERN_DEBUG "STI PCI ROM disabled\n"));
>  	}
>  
> @@ -930,28 +930,25 @@ static int __devinit sticore_pci_init(struct pci_dev *pd,
>  		const struct pci_device_id *ent)
>  {
>  #ifdef CONFIG_PCI
> -	unsigned long fb_base, rom_base;
> -	unsigned int fb_len, rom_len;
> +	unsigned long fb_base;
> +	unsigned int fb_len;
> +	char __iomem *rom_base;
> +	size_t rom_len;
>  	struct sti_struct *sti;
>  	
>  	pci_enable_device(pd);
>  
>  	fb_base = pci_resource_start(pd, 0);
>  	fb_len = pci_resource_len(pd, 0);
> -	rom_base = pci_resource_start(pd, PCI_ROM_RESOURCE);
> -	rom_len = pci_resource_len(pd, PCI_ROM_RESOURCE);
> -	if (rom_base) {
> -		pci_write_config_dword(pd, PCI_ROM_ADDRESS, rom_base | PCI_ROM_ADDRESS_ENABLE);
> -		DPRINTK((KERN_DEBUG "STI PCI ROM enabled at 0x%08lx\n", rom_base));
> -	}
> +	rom_base = pci_map_rom(pd, &rom_len);

I'm really not sure this is such a good idea.  pci_map_rom() can do an
ioremap() on the region.  In that case, gsc_readl which punches through
our virtual memory into physical I/O space will fail.  What assurance do
we have that all STI roms are correctly set up so pci_map_rom() isn't
inclined to ioremap them?

James


