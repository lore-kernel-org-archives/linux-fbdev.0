From: viking <viking@flying-brick.caverock.net.nz>
Subject: Tridentfb troubles
Date: Tue, 22 Mar 2005 11:26:57 +1200
Message-ID: <20050321232657.GB7281@flying-brick.caverock.net.nz>
References: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz> <20050320164129.44d3a065.akpm@osdl.org> <20050321072601.GA31826@flying-brick.caverock.net.nz> <20050320233227.2c7b8013.akpm@osdl.org> <20050321202546.GA7281@flying-brick.caverock.net.nz> <20050321124426.53d75b3e.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDWN1-0007CE-2a
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 15:31:39 -0800
Received: from [203.184.24.70] (helo=brick.flying-brick.caverock.net.nz)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DDWMv-0004Zz-J9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 15:31:37 -0800
Content-Disposition: inline
In-Reply-To: <20050321124426.53d75b3e.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Mar 21, 2005 at 12:44:26PM -0800, Andrew Morton wrote:
> 
> Guys, we seem to have a tridentfb regression in 2.6.12-rc1.
> 
> viking <viking@flying-brick.caverock.net.nz> wrote:
> >
> > Also (and this is something I've noticed since I tried tridentfb) the video
> >  buffer never seems to get cleared, except when I change virtual terminals,
> >  then change back to the terminal concerned. THEN it's cleared. So for the
> >  moment, I've gone back to using VESAfb.

**********
Actually, it's in every release I've ever tested. 
**********

I hadn't mentioned it before, because vesafb does what I want, apart from not
being resizable.  I have a Apollo MVP4, VIA686A (or B) video chipset, though
the Video shows itself as a CyberBlade/i7:

brick$ lspci -v -v
...
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i7 (rev 5d)
(prog-if 00 [VGA])
Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9915
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 32
Interrupt: pin A routed to IRQ 10
Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=8M]
Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=128K]
Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
Expansion ROM at <unassigned> [disabled] [size=64K]
Capabilities: [80] AGP version 1.0
Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3-
Rate=x1,x2
Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
Capabilities: [90] Power Management version 1
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-


I have via-agp and agpgart loaded, though those aren't for 2d. Not sure what
else to tell you, to be honest. If I put BOTH the vesafb AND the tridentfb
into the kernel, and select vesafb on lilo (video=vesafb:mtrr,ypan), the
kernel boots up using tridentfb regardless.

The 640x480-60 (the one the kernel seems to boot up on unless told otherwise)
screenmode looks absolutely shocking, with a very wiggly screen mainly in the
X direction. That's probably due to the definition in drivers/video/modedb.c,
something I can either tweak myself, or avoid using.

I'll do more testing, see what I come up with aside from that. You may need to
tell me what other details you want though.

Andrew - you still wish to be CC:ed on this video issue?

-- 
 /|   _,.:*^*:.,   |\  Cheers from the Viking family, including Pippin, our cat
| |_/'  viking@ `\_| |
|    flying-brick    | $FunnyMail   : What do you mean, I've lost the plot?
 \_.caverock.net.nz_/     5.40      : I planted them carrots right here!!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
