From: Thomas Jahns <Thomas.Jahns@epost.de>
Subject: Mach64 GX driver problems in post 2.4.22 kernels
Date: Sat, 5 Jun 2004 20:56:47 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040605185647.GG5668@mercury.jahnsnet.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWgLr-0003Yx-Vw
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Jun 2004 11:57:07 -0700
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BWgLr-0003ZD-Hp
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Jun 2004 11:57:07 -0700
Received: from mercury.jahnsnet.de (149.225.10.206) by mail.epost.de (6.7.015)
        id 40C09F250003C876 for linux-fbdev-devel@lists.sourceforge.net; Sat, 5 Jun 2004 20:57:07 +0200
Received: from mercury (tjahns@localhost [127.0.0.1])
	by mercury.jahnsnet.de (8.12.11/8.12.11/Debian-5) with ESMTP id i55IunIL008317
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 5 Jun 2004 20:56:49 +0200
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
Content-Type: text/plain; format="Flowed"; delsp="Yes"; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I have the following problem when I try to build a new kernel for my  
PowerMac 7500 (604e CPU, PCI adapters: Adaptec 2940UW SCSI, Apple  
Mach64 GX card):

Kernel versions newer than my last build (of 2.4.22 plus preempt, benh,  
lowlatency, ea+acl+nfsacl, cryptoloop patches, all from debian sid  
source packages of that time) show a blank screen when switching to the  
Mach64 framebuffer (BootX pre-boot messages are fine). The kernel  
continues to boot and even activates the atyfb driver so I can login  
blind on the console or remotely via ssh.

I have so far built the following kernels: 2.4.25 from debian package  
kernel-source-2.4.25_2.4.25-3, with and without the debian kernel- 
patch-2.4.25-powerpc patch derived from Benjamin Herrenschmidt's source  
tree, a kernel from each of www.kernel.org 2.4.26 and 2.4.25 archives  
(without any patches) and a downloaded kernel from Benjamin's site  
directly (rsync'ed on 2004/06/01, ca. 16:30). All of these builds show  
the behaviour outlined above: kernel boots fine but screen blanks  
immediatly.

As Mach64 is obviously quite important to a number of PowerMacs I hope  
someone already stumbled across the same problem, although I couldn't  
find anything truely specific by googling.

Please tell if you need any more specific logs or info, I'll include  
the dmesg lines and lspci -v output relevant to the card for a start:

> dmesg | grep -i \(aty\|console\)
Kernel command line: root=/dev/sda7 video=atyfb:vmode:18:cmode:8  
panic=60
Console: colour dummy device 80x25
atyfb: mach64GX (ATI888GX00) [0x00d7 rev 0x03] 4M VRAM, 14.31818 MHz  
XTAL, 135
MHz PLL, 50 Mhz MCLK
Console: switching to colour frame buffer device 144x54
fb0: ATY Mach64 frame buffer device on PCI
MacOS display is /bandit/ATY,mach64

I noticed one of these lines reads differently on my 2.4.22 kernel:

atyfb: mach64GX (ATI888GX00) [0x00d7 rev 0x03] 4M VRAM, 14.31818 MHz
XTAL, 135 MHz PLL, 50 Mhz MCLK
                   ^^^^^^^^^^^
Would that be a sign of the culprit?

> lspci -v -s 00:0f.0
0000:00:0f.0 VGA compatible controller: ATI Technologies Inc 210888GX  
[Mach64
GX] (rev 03) (prog-if 00 [VGA])
       Flags: stepping, medium devsel, IRQ 25
       Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
       Expansion ROM at <unassigned> [disabled] [size=64K]



Thanks for any input you can provide with respect to my problem.

Ciao, Thomas Jahns
-- 
"Computers are good at following instructions,
 but not at reading your mind."
D. E. Knuth, The TeXbook, Addison-Wesley 1984, 1986, 1996, p. 9


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
