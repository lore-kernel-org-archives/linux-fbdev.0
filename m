From: Thomas Jahns <Thomas.Jahns@epost.de>
Subject: State of pm3fb driver
Date: Sun, 3 Oct 2004 14:53:43 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041003125343.GA7675@mercury.jahnsnet.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEQ2M-0003Mz-L2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 03:25:46 -0700
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEQ2K-0004v9-V3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 03:25:46 -0700
Received: from mercury.jahnsnet.de (149.225.18.36) by mail.epost.de (7.2.033.1)
        id 4160A238000094FD for linux-fbdev-devel@lists.sourceforge.net; Mon, 4 Oct 2004 12:18:32 +0200
Received: from mercury (tjahns@localhost [127.0.0.1])
	by mercury.jahnsnet.de (8.13.1/8.13.1/Debian-12) with ESMTP id i93Crh8i024630
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 3 Oct 2004 14:53:43 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

after I was quite unhappy with the support for my ATI Mach64 adapter in  
my Powermac 7500 I aquired a Formac Proformance III adapter that  
supposedly uses a Permedia 3 chip. Unfortunately it seems that the  
driver is broken in kernel 2.6.8 (at least to my incomplete  
understanding of the subject) for the following reasons:

a) drivers/video/pm3fb.c uses a number of includes no more present
	(I could fix that as shown in the attached patch)
b) even if I fixed the compile time errors the resulting kernel does  
not display anything to the console (but works without problems  
otherwise). Also the kernel log is flooded with repetitions of the  
following line (but that might have other reasons, because I noticed it  
also happens when I boot an older kernel without the pm3 driver:
IN from bad port 64 at c01a22a

c) drivers/video/pm3fb.c and include/video/pm3fb.h contain a number of  
#ifdef statements that check for KERNEL_2_2 and similar vars, but never  
for KERNEL_2_6. So I assume the source has not seen any maintainance in  
2.6?

The card identifies itself as follows in lspci -v -s 00:0e.0:

0000:00:0e.0 Display controller: 3DLabs GLINT R3 (rev 01)
        Subsystem: 3DLabs GLINT R3
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 24
        Memory at 80880000 (32-bit, non-prefetchable) [size=128K]
        Memory at 84000000 (32-bit, prefetchable) [size=64M]
        Memory at 90000000 (32-bit, prefetchable) [size=64M]
        I/O ports at 0800 [disabled] [size=16]
        Expansion ROM at 80840000 [disabled] [size=64K]
        Capabilities: <available only to root>

Any comments what I should try from here?

Ciao, Thomas Jahns
-- 
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9

--zYM0uCDKw75PZbzx
Content-Type: text/x-patch; charset=unknown-8bit
Content-Disposition: attachment; filename="pm3_includes.patch"

--- /tmp/kernel-source-2.6.8/drivers/video/pm3fb.c	2004-08-14 07:36:32.000000000 +0200
+++ /home/tjahns/tmp/debian_stuff/kernel-compile/2.6.8/kernel-source-2.6.8/drivers/video/pm3fb.c	2004-10-03 14:15:42.000000000 +0200
@@ -68,14 +68,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 
-#include <video/fbcon.h>
-#include <video/fbcon-mfb.h>
-#include <video/fbcon-cfb2.h>
-#include <video/fbcon-cfb4.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
+#include "console/fbcon.h"
 #include <video/pm3fb.h>
 
 #include <asm/io.h>

--zYM0uCDKw75PZbzx--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
