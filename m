From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Silicon Motion SM501 Voyager GX fb driver development
Date: Thu, 09 Dec 2004 11:44:45 +0100
Message-ID: <41B82C9D.7040105@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcLlg-0006uK-UD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 02:43:28 -0800
Received: from moutng.kundenserver.de ([212.227.126.190])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CcLlg-00024C-0b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 02:43:28 -0800
Received: from [212.227.126.209] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CcLld-00026S-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 11:43:25 +0100
Received: from [62.225.237.186] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CcLlc-0003eP-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 11:43:24 +0100
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hello!

Well, I am about to implement a fbdev for the Silicon Motion Inc.'s
SM501 (alias Voyager GX) embedded graphics controller for our
next projects. (http://www.siliconmotion.com/sm501.htm)

The goal is to get a stable fb up and running on a current Kernel 2.6.x
The Platform is currently a PowerMac G4 Windtunnel (CRUX PPC 2.0)
and later on it will be a Freescale MPC8540 embedded processor.
The SM501 hardware is the PCI Demo Board from SMI.

I've started from the latest ix86 released driver from SMI and I
got some basic functionality working. (There appears some (sometimes 
garbled) image on the panel, driver has memory leaks, as there are
pci_resource and ioremap problems ...)
So, the point is, I want to "fix" or better re-write the code
from SMI to get an up-to-date driver for Kernel 2.6.

My question is: Where is a good way to start to learn from
already existing code? radeonfb or aty128fb or which driver
is the most current and Kernel 2.6 aware driver.
Later on I will also need to implement power management and
try to get the other SM501 peripherals working (USB, Audio,
Touchpanel,...)

It's my first framebuffer thing I do, so there might be some
novice questions or completely ungeek mistakes.
Currently I want to fix the module load/unload (ioremap/iounmap)
thing if ioremap is really the current way to do it.
For sure, you can get my code if you want. But it's still in
pretty ugly condition.

Best greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
