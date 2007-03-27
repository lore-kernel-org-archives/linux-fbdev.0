From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: radeonfb doesn't work with an ati X800 pcie
 card
Date: Tue, 27 Mar 2007 18:58:34 +0200
Message-ID: <46094D3A.8040901@gmx.net>
References: <46093D22.3090401@gmx.net>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWF0M-0000BT-K1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 09:58:42 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWF0K-000365-Vg
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 09:58:42 -0700
In-Reply-To: <46093D22.3090401@gmx.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net

Some more news:

the radeon irq isn't identified in /proc/interrupts. In fact, we should
read something like this,

18:    2305987   IO-APIC-fasteoi   radeon@pci:0000:01:00.0

as it is reported in kern.log file !!

ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 18

Intead, i get,

# cat /proc/interrupts
           CPU0
  0:   24560170   IO-APIC-edge      timer
  1:      18202   IO-APIC-edge      i8042
  6:          5   IO-APIC-edge      floppy
  7:          0   IO-APIC-edge      parport0
  9:          0   IO-APIC-fasteoi   acpi
10:          0   IO-APIC-edge      MPU401 UART
14:     266877   IO-APIC-edge      libata
15:          0   IO-APIC-edge      libata
16:          3   IO-APIC-fasteoi   ohci1394
20:     385492   IO-APIC-fasteoi   ohci_hcd:usb2
21:          2   IO-APIC-fasteoi   ehci_hcd:usb1
22:          0   IO-APIC-fasteoi   libata, NVidia CK804
23:    3165506   IO-APIC-fasteoi   libata, eth0
NMI:       2812
LOC:   24557617
ERR:          0

and there is no irq for the radeon card available !



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
