From: Stian Hartviksen <stian.hartviksen@kitrus.com>
Subject: Some small problems...
Date: 22 Jan 2003 22:23:27 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043270608.1879.53.camel@laptop-STIAN>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns2.kitrus.no ([212.4.54.162] helo=is1.itr.no)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18bSLu-0002gd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Jan 2003 13:24:07 -0800
Received: from is1.itr.no (localhost [127.0.0.1])
	by is1.itr.no (8.11.6/8.11.6) with ESMTP id h0MLO0S03643
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Jan 2003 22:24:00 +0100
Received: from laptop-STIAN.kontor.itsopen.no (fou-fw.sts.no [212.4.54.130] (may be forged))
	by is1.itr.no (8.11.6/8.11.6) with ESMTP id h0MLO0T03637
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 22 Jan 2003 22:24:00 +0100
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi, all !

I'm having a slight trouble with getting my hardware to work together
with the new 2.5.59 development kernel. The problems is as follows :

1. When compiling, the following framebuffer devices does not compile :
	- Cirrus Logic
	- Matrox
	- Riva (had some warnings)
	- Ati (Had to do some small hack in aty_base.c to get this compiling)

2. When I'm doing make modules_install everything stops. This I got
around by installing module-init-tools-0.9.8 - This is not a good
solutions (Or at least there should be some notes that you have to
install some external software packages to get the kernel compiled.)

3. When the compiling sequence is finished, and it is time for reboot,
there is no output on the screen after the grub startup manager.
(Sometimes I get the following : Uncompressing Linux... Ok, booting the
kernel.)The disk is working, and services are starting - But no output
on the monitor. I've tried different parameter to the vga= command, but
all have the same result.

4. Are there a list of framebuffer drivers that are verified on the
2.5.59 kernel ?


WBR Stian Hartviksen



My test equipment is as follows :

Machine #1:
- Pentium II, 266MHz, 128Mb
- ATI Rage Pro 3D (AGP)
- Nvidia Geforce 2 (PCI)
- Nvidia TNT 2 (PCI)
- Matrox Millenium II (PCI)
- Herkules S3virge (PCI)
- Cirrus Logic GD5434-8 (PCI)


Machine #2:
- Pentium 4, 2,4GHz, 512Mb
- Nvidia Geforce 4 MX420 (AGP)
- Nvidia Geforce 2 (PCI)
- Nvidia TNT 2 (PCI)
- Matrox Millenium II (PCI)
- Herkules S3virge (PCI)
- Cirrus Logic GD5434-8 (PCI)


Machine #3:
- Pentium 4, 2,4GHz, 256Mb
- ATI Radeon Mobility M6



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
