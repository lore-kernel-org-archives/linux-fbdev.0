From: Miles Lane <miles@megapathdsl.net>
Subject: 2.5.20 + latest fbdev patch -- Rivafb appears to hang machine
Date: Wed, 05 Jun 2002 01:18:21 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3CFDC94D.6090707@megapathdsl.net>
References: <3CFDBCE4.9050807@megapathdsl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from front1.mail.megapathdsl.net ([66.80.60.31])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17FW1j-00020P-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Jun 2002 01:20:19 -0700
Received: from [216.36.113.151] (HELO megapathdsl.net)
  by front1.mail.megapathdsl.net (CommuniGate Pro SMTP 3.5.8)
  with ESMTP id 30200393 for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 Jun 2002 01:12:37 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

What happens is that when the rivafb driver is loaded, the video
mode changes and the whole screen is covered with colored
static which has areas that are primarily one or another color.
It looks like the video mode is wrong.  Note that with the same
rivafb parameter value and running 2.5.20-dj2, I get a usable
VT, but the colors are off.

I am booting with "video=riva:1600x1200-16"

This is an Athlon UP machine.

01:05.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 10) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 000b
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at feaf0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0

Gnu C                  3.0.4
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.14
e2fsprogs              1.26
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
