From: Miles Lane <miles.lane@attbi.com>
Subject: Re: 2.5.51 -- rivafb is whacky (characters
	flipped on vertical axis, 640x480 usable area shown inside a higher-res
	area, etc).
Date: 11 Dec 2002 08:05:41 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1039622741.1111.21.camel@bellybutton.attbi.com>
References: <3DF6894E.3090802@attbi.com>
	 <1039610250.1147.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sccrmhc01.attbi.com ([204.127.202.61])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18M9Mr-0000vc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Dec 2002 08:05:49 -0800
In-Reply-To: <1039610250.1147.95.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-12-11 at 04:49, Antonino Daplas wrote:
> On Wed, 2002-12-11 at 05:39, Miles Lane wrote:
> > Hi,
> > 
> > I have tried getting rivafb to work in 2.5.51.  It is much better
> > than before (thanks!).  It compiles and sorta works.
> > 
> > Here are the problems:
> > 
> > When I run "fbset -a 640x480", I get display that fills
> > the screen and looks okay, but most of the characters are
> > flipped along the vertical axis, so they are backwards, so that:
> > 
> > +----		    ----+
> > |			|
> > +---    becomes	     ---+
> > |			|
> > |			|
> > 
> What's the hardware, is it on a big endian machine? I think there's a
> typo there (__BIG_ENDIAN__ instead of __BIG_ENDIAN).  This should
> produce the "mirroring" effect.

CPU: AMD Athlon(tm) Processor stepping 01

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller (rev 25)

01:05.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 256
DDR] (rev 10) (prog-if 00 [VGA])
        Subsystem: VISIONTEK: Unknown device 000b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at feaf0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

> Secondly, a lot of the changes there are for riva128, which may not
> apply for all cards. Try doing fbset -accel false/true and see if
> there's any effect. Or open linux/video/drivers/riva/fbdev.c, line 277
> and comment out the line with the FB_ACCELF_TEXT.  This should force the
> hardware to do everything in software.  

Thanks, I'll check this today.

	Miles




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
