From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Linux kernel PCI IDs vs Xfree
Date: Sat, 9 Aug 2003 12:23:06 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030809192306.10704.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14910.mail.yahoo.com ([216.136.225.62])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19lZIw-0008VI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 09 Aug 2003 12:23:06 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, dri-devel <dri-devel@lists.sourceforge.net>

linux/pci_ids.h and xf86PciInfo.h are in disagreement
for several Rage128 PCI ids. Xfree appears to be
correct and the kernel file is wrong. This impacts the
Rage framebuffer driver when loading. I verified these
with two PCI databases.

Rage Mobility 128 AGP 4x
#define PCI_CHIP_RAGE128MF              0x4D46
#define PCI_DEVICE_ID_ATI_RADEON_LF     0x4d46

Rage Mobility 128 AGP
#define PCI_CHIP_RAGE128ML              0x4D4C
missing

Rage 128 SE/4x PCI
#define PCI_CHIP_RAGE128SE              0x5345
#define PCI_DEVICE_ID_ATI_RAGE128_RM    0x5345

Rage 128 SF/4x AGP 2x
#define PCI_CHIP_RAGE128SF              0x5346
#define PCI_DEVICE_ID_ATI_RAGE128_RN    0x5346

Rage 128 SG/4x AGP 4x
#define PCI_CHIP_RAGE128SG              0x5347
#define PCI_DEVICE_ID_ATI_RAGE128_RO    0x5347

Rage 128 SH/4x
#define PCI_CHIP_RAGE128SH              0x5348
missing

Rage 128 SK/4x
#define PCI_CHIP_RAGE128SK              0x534B
#define PCI_DEVICE_ID_ATI_RAGE128_RG    0x534b

Rage 128 SL/4x AGP 2x
#define PCI_CHIP_RAGE128SL              0x534C
#define PCI_DEVICE_ID_ATI_RAGE128_RH    0x534c

Rage 128 SM/4x AGP 4x
#define PCI_CHIP_RAGE128SM              0x534D
#define PCI_DEVICE_ID_ATI_RAGE128_RI    0x534d

Rage 128 4x
#define PCI_CHIP_RAGE128SN              0x534E
missing

Rage 128 Pro Ultra TF
#define PCI_CHIP_RAGE128TF              0x5446
#define PCI_DEVICE_ID_ATI_RAGE128_U1    0x5446

Rage 128 Pro Ultra TL
#define PCI_CHIP_RAGE128TL              0x544C
#define PCI_DEVICE_ID_ATI_RAGE128_U2    0x544C

Rage 128 Pro Ultra TS
#define PCI_CHIP_RAGE128TS              0x5453
missing

Rage 128 Pro Ultra TT
#define PCI_CHIP_RAGE128TT              0x5454
missing

Rage 128 Pro Ultra TU
#define PCI_CHIP_RAGE128TU              0x5455
missing



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
