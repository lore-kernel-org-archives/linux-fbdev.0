From: Yann Dirson <ydirson@altern.org>
Subject: Radeon AIW 8500DV support ?
Date: Sun, 18 Aug 2002 01:27:03 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020817232703.GD928@bylbo.nowhere.earth>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from postfix3-2.free.fr ([213.228.0.169])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17gBzf-0001YB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 17 Aug 2002 15:24:27 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net

Hi,

I just bought a 8500DV, and find out that the fb device does not know about
it yet.  I'd be happy to play with the driver and test stuff, but I lack
knowledge of the driver's architecture, and of the hardware...  Needless to
say, if you have any pointers that could help me much :)

I've looked at the driver code and have a couple of questions:

- I notice there is already a PCI id for 8500 (R200 chip), and the 8500DV
uses a different ID.  I suppose I should add it, but I'm wondering about the
naming conventions used for PCI_DEVICE_ID_RADEON_*  (I'd be tempted to use
DV, but well... :)

BTW, the device info is as follows, I suppose the ID to add is 4242 ?

# lspci -s 1:0.0
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon 8500 DV
# lspci -s 1:0.0 -vv -n
01:00.0 Class 0300: 1002:4242
        Subsystem: 1002:02aa
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at b800 [size=256]
        Region 2: Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
        Region 4: Memory at dfed0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at dfea0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		
		
- I'll suppose I'll have to add an entry to radeon_get_pllinfo() - what are
those pll fields, and how am I supposed to find out the values ?

- should there be any additional info to add, aside from this and the small
stuff in radeonfb_pci_register() ?

- the drm module appears to recognize the card (I still have to fetch
XFree86 4.2 to check whether this works) - is there any chance there is
any info to get from their implementation ?

# cat /proc/dri/0/name
radeon 0xe200


Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
     http://ydirson.free.fr/        | Check <http://www.debian.org/>


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
