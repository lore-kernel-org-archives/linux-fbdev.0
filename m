From: Miles Lane <miles@megapathdsl.net>
Subject: Re: Rivafb not working properly in kernel 2.5.15.
Date: Sun, 12 May 2002 17:51:46 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3CDF0E22.9020005@megapathdsl.net>
References: <3CDD34E4.4040803@megapathdsl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from front1.mail.megapathdsl.net ([66.80.60.31])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17744H-0001oj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 May 2002 17:52:01 -0700
Received: from [216.36.113.151] (HELO megapathdsl.net)
  by front1.mail.megapathdsl.net (CommuniGate Pro SMTP 3.5.8)
  with ESMTP-TLS id 27714381 for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 May 2002 17:45:28 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hmm.  I just realised may still not have given enough information.
Here is a bit more.

vendor_id 
: AuthenticAMD
cpu family	: 6
model 
	: 2
model name	: AMD Athlon(tm) Processor
cpu MHz		: 848.383

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] 
System Controller (rev 25)
	Flags: bus master, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at fc9ff000 (32-bit, prefetchable) [size=4K]
	I/O ports at ffe4 [disabled] [size=4]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: e4800000-f48fffff

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA 
(rev 01)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE 
(rev 03) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at cb00 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Flags: medium devsel

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB 
(rev 06) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 16, IRQ 10
	Memory at febfe000 (32-bit, non-prefetchable) [size=4K]

00:0f.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
	Subsystem: Adaptec: Unknown device 3869
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at f800 [disabled] [size=256]
	Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at febe0000 [disabled] [size=64K]
	Capabilities: <available only to root>

00:11.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Flags: bus master, medium devsel, latency 40, IRQ 11
	Memory at febfb000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:11.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Flags: bus master, medium devsel, latency 40, IRQ 5
	Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:11.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 01) 
(prog-if 20)
	Subsystem: NEC Corporation: Unknown device 00e0
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at febfdf00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:12.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 
(rev 07)
	Subsystem: Creative Labs CT4831 SBLive! Value
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at ff80 [size=32]
	Capabilities: <available only to root>

00:12.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 64
	I/O ports at fff0 [size=8]
	Capabilities: <available only to root>

00:13.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at fc00 [size=128]
	Memory at febfde80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: <available only to root>

00:14.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
	Flags: medium devsel
	Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	16-bit legacy interface ports at 0001

00:14.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 03)
	Flags: medium devsel
	Memory at 10001000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	16-bit legacy interface ports at 0001


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
