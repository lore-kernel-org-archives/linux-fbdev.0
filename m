From: Jon Smirl <jonsmirl@gmail.com>
Subject: removing direct use of PCI_ROM_ADDRESS_ENABLE
Date: Thu, 17 Mar 2005 11:01:27 -0500
Message-ID: <9e47339105031708016804d775@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBxRC-00033F-9A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 08:01:30 -0800
Received: from rproxy.gmail.com ([64.233.170.201])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBxRA-0003SJ-Tt
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 08:01:30 -0800
Received: by rproxy.gmail.com with SMTP id y7so606781rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 08:01:27 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

These drivers need to be fixed to use the new kernel ROM API.
PCI_ROM_ADDRESS_ENABLE is going to get deprecated soon. See the new
radeonfb for an example. You don't have to worry about shadow RAM
copies, the ROM code will handle it for you.

video/console/sticore.c:               
pci_write_config_dword(sti->pd, PCI_ROM_ADDRESS, rom_base &
~PCI_ROM_ADDRESS_ENABLE);
video/console/sticore.c:                pci_write_config_dword(pd,
PCI_ROM_ADDRESS, rom_base | PCI_ROM_ADDRESS_ENABLE);

video/matrox/matroxfb_misc.c:   pci_write_config_dword(pdev,
PCI_ROM_ADDRESS, (fbbase & PCI_ROM_ADDRESS_MASK) |
PCI_ROM_ADDRESS_ENABLE);

video/sis/sis_main.c:                   (ivideo->video_base &
PCI_ROM_ADDRESS_MASK) | PCI_ROM_ADDRESS_ENABLE);

New routines:
/* ROM control related routines */
void __iomem *pci_map_rom(struct pci_dev *pdev, size_t *size);
void __iomem *pci_map_rom_copy(struct pci_dev *pdev, size_t *size);
void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
void pci_remove_rom(struct pci_dev *pdev);

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
