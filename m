From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Merge of Luca and Ben's sysfs work for Radeon
Date: Wed, 24 Sep 2003 23:05:24 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030925060524.24191.qmail@web14909.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2PFl-0008CN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Sep 2003 23:05:25 -0700
Received: from web14909.mail.yahoo.com ([216.136.225.61])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2PFk-0005Cg-OV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Sep 2003 23:05:24 -0700
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Here is a sample of what sysfs looks like with the new radeon driver. I have an
Intel 875 chipset so there are three buses: 0 - system, 1 - AGP, 2 - PCI. Note
that the EDID block is available.

I was thinking about adding these attributes to the fb device: geometry,
timings, interlaced, hsync, vsync. and then writing a new fbset command.

[jonsmirl@smirl sys]$ ls
block  bus  cdev  class  devices  firmware  power
[jonsmirl@smirl sys]$ ls bus/pci/devices
0000:00:00.0  0000:00:1d.1  0000:00:1d.7  0000:00:1f.1  0000:00:1f.5 
0000:02:01.0
0000:00:01.0  0000:00:1d.2  0000:00:1e.0  0000:00:1f.2  0000:01:00.0 
0000:02:02.0
0000:00:1d.0  0000:00:1d.3  0000:00:1f.0  0000:00:1f.3  0000:01:00.1 
0000:02:0c.0
[jonsmirl@smirl sys]$ ls bus/pci/drivers
agpgart-intel  Intel ICH           parport_pc  radeonfb    uhci-hcd
e1000          Intel ICH Joystick  PCI IDE     RZ1000 IDE
ehci_hcd       ohci1394            PIIX IDE    serial
[jonsmirl@smirl sys]$ ls bus/pci/drivers/radeonfb
0000:01:00.0  0000:01:00.1  new_id
[jonsmirl@smirl sys]$ ls class
graphics  i2c-adapter  input  net  scsi_device  scsi_host  tty  usb  usb_host
[jonsmirl@smirl sys]$ ls class/graphics
fb0
[jonsmirl@smirl sys]$ ls class/graphics/fb0
dev  device  driver
[jonsmirl@smirl sys]$  ls class/graphics/fb0/device
class   detach_state  edid1  i2c-1  i2c-3  power     subsystem_device  vendor
config  device        i2c-0  i2c-2  irq    resource  subsystem_vendor
[jonsmirl@smirl sys]$ ls class/graphics/fb0/driver
0000:01:00.0  0000:01:00.1  new_id
[jonsmirl@smirl sys]$




=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
