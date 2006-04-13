From: Pavel Kysilka <goldenfish@bsys.cz>
Subject: [aty128fb]  fbset -a not working
Date: Thu, 13 Apr 2006 05:44:51 +0200
Message-ID: <20060413034451.GA2846@prog3>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FTslN-0006X1-6K
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Apr 2006 20:44:57 -0700
Received: from ns.bsys.cz ([212.71.156.90] helo=pan.hq.bsys.cz)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FTslL-0001sJ-MV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Apr 2006 20:44:57 -0700
Received: from pan.hq.bsys.cz (localhost [127.0.0.1])
	by mail.hq.bsys.cz (Postfix) with ESMTP id DE7E8B2
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Apr 2006 05:44:51 +0200 (CEST)
Received: from prog3.hq.bsys.cz (prog3.hq.bsys.cz [192.168.64.218])
	by pan.hq.bsys.cz (Postfix) with ESMTP id BB6E6AD
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Apr 2006 05:44:51 +0200 (CEST)
Received: from prog3.hq.bsys.cz (localhost [127.0.0.1])
	by prog3.hq.bsys.cz (8.13.6/8.13.6/Debian-1) with ESMTP id k3D3ipGm002941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Apr 2006 05:44:51 +0200
Received: (from goldenfish@localhost)
	by prog3.hq.bsys.cz (8.13.6/8.13.6/Submit) id k3D3ipd0002940
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Apr 2006 05:44:51 +0200
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


   Hi,

i have ATI Rage128 AGP card.
I was testing framebuffer. Switching resolution in one console working.
Switching all consoles do not working. Only aktual console is switched.

modprobe aty128fb
chvt 1
fbset

mode "640x480-60"
    # D: 25.171 MHz, H: 31.463 kHz, V: 59.930 Hz
    geometry 640 480 640 480 8
    timings 39729 48 16 33 10 96 2
    rgba 8/0,8/0,8/0,0/0
endmode

fbset -a 800x600-100 -depth 32

mode "800x600-100"
    # D: 67.490 MHz, H: 62.491 kHz, V: 99.985 Hz
    geometry 800 600 800 600 32
    timings 14817 216 0 14 7 64 4
    hsync high
    vsync high
    accel true
    rgba 8/16,8/8,8/0,8/24
endmode

chvt 2
fbset

mode "640x480-60"
    # D: 25.171 MHz, H: 31.463 kHz, V: 59.930 Hz
    geometry 640 480 640 480 8
    timings 39729 48 16 33 10 96 2
    rgba 8/0,8/0,8/0,0/0
endmode

Error is independent with color depth end resolution. intelfb and matroxfb
driver working with this feature correctly.

 
less /var/log/kernel.log

Apr 13 05:22:15 prog3 kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 19
Apr 13 05:22:15 prog3 kernel: aty128fb: Found Intel x86 BIOS ROM Image
Apr 13 05:22:15 prog3 kernel: aty128fb: Rage128 BIOS located
Apr 13 05:22:15 prog3 kernel: aty128fb: Rage128 TF Ultra AGP [chip rev 0x4] 32M 128-bit SDR SGRAM (1:1)
Apr 13 05:22:15 prog3 kernel: Console: switching to colour frame buffer device 80x30
Apr 13 05:22:15 prog3 kernel: fb0: ATY Rage128 frame buffer device on Rage128 TF Ultra AGP
Apr 13 05:22:15 prog3 kernel: aty128fb: Rage128 MTRR set to ON

goldenfish@prog3:~$ lspci -s "01:00.0" -nv
0000:01:00.0 0300: 1002:5446
        Subsystem: 1787:0100
        Flags: bus master, stepping, 66MHz, medium devsel, latency 32, IRQ 19
        Memory at f0000000 (32-bit, prefetchable) [size=64M]
        I/O ports at 9800 [size=256]
        Memory at ff820000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at ff800000 [disabled] [size=128K]
        Capabilities: <available only to root>

For testing and another information contact me. I am subscribed in the list.

  thanks
   Pavel Kysilka
    programmer http://www.bsys.cz/


________ Information from NOD32 ________
This message was checked by NOD32 Antivirus System for Linux Mail Server.

http://www.nod32.com


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
