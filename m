From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: New kernel API for ROMs
Date: Sat, 7 Aug 2004 15:16:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408071515350.3475@waterleaf.sonytel.be>
References: <20040806212133.22637.qmail@web14923.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040806212133.22637.qmail@web14923.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 6 Aug 2004, Jon Smirl wrote:

> This patch provides a new kernel API for access ROMs from device
> drivers. If you're working on a driver that uses the ROM (most video
> drivers) please give this patch a try and send some feedback/bugs.
>
> pci_map_rom() - map the rom and provide virtual address, transparently
> return shadow/copy if needed. Normal drivers call this
>
> pci_map_rom_copy() - same as pci_map_rom except the ROM will copied,
> future reads of ROM will use copy. Hardware with minimal decoding calls
> use this
>
> pci_unmap_rom() - release the ioremap if there is one
>
> The ROMs also appear in sysfs and you can use hexdump to see them.
>
> If the Radeon ROM is all FFFF. Load a radeon device driver and it will
> appear. Radeon cards have a bug that loading the driver will fix.

> +unsigned char *
> +pci_map_rom_copy(struct pci_dev *dev, size_t *size) {
> +	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
> +	unsigned char *rom;
> +
> +	rom = pci_map_rom(dev, size);
> +	if (!rom)
> +		return NULL;
> +
> +	if (res->flags & (PCI_ROM_COPY | PCI_ROM_SHADOW))
> +		return rom;
> +
> +	res->start = (unsigned long)kmalloc(*size, GFP_KERNEL);

What's the maximum size of a PCI ROM? Larger than kmalloc() can handle?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
