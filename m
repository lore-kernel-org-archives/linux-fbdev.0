From: Thomas Jahns <Thomas.Jahns@epost.de>
Subject: Re: Mach64 GX driver problems in post 2.4.22 kernels
Date: Sun, 6 Jun 2004 12:45:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040606104530.GA2231@mercury.jahnsnet.de>
References: <20040605185647.GG5668@mercury.jahnsnet.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BX0tH-00081b-Mq
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 09:52:59 -0700
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BX0tH-0006lC-9D
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 09:52:59 -0700
Received: from mercury.jahnsnet.de (149.225.16.94) by mail.epost.de (6.7.015)
        id 40C0B2F30007164D for linux-fbdev-devel@lists.sourceforge.net; Sun, 6 Jun 2004 18:52:57 +0200
Received: from mercury (tjahns@localhost [127.0.0.1])
	by mercury.jahnsnet.de (8.12.11/8.12.11/Debian-5) with ESMTP id i56AjX8h017488
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 6 Jun 2004 12:45:35 +0200
Content-Disposition: inline
In-Reply-To: <20040605185647.GG5668@mercury.jahnsnet.de> (from Thomas.Jahns@epost.de on Sat, Jun 05, 2004 at 20:56:47 +0200)
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

Hi again,

On 06/05/04 20:56:47, Thomas Jahns wrote:
>> dmesg | grep -i \(aty\|console\)
> Kernel command line: root=/dev/sda7 video=atyfb:vmode:18:cmode:8  
> panic=60
> Console: colour dummy device 80x25
> atyfb: mach64GX (ATI888GX00) [0x00d7 rev 0x03] 4M VRAM, 14.31818 MHz  
> XTAL, 135
> MHz PLL, 50 Mhz MCLK
> Console: switching to colour frame buffer device 144x54
> fb0: ATY Mach64 frame buffer device on PCI
> MacOS display is /bandit/ATY,mach64

classic error, the above line reads the same as that below because copy  
and paste swallowed exactly the part of the line which is different, so  
here it comes again (now hopefully complete):

atyfb: mach64GX (ATI888GX00) [0x00d7 rev 0x03] 4M VRAM, 14.31818 MHz  
XTAL, 135 MHz PLL, 50 Mhz MCLK, 50 Mhz XCLK

> I noticed one of these lines reads differently on my 2.4.22 kernel:
> 
> atyfb: mach64GX (ATI888GX00) [0x00d7 rev 0x03] 4M VRAM, 14.31818 MHz
> XTAL, 135 MHz PLL, 50 Mhz MCLK
                                 ^^^^^^^^^^^

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
