From: Miles Lane <miles@megapathdsl.net>
Subject: Re: Rivafb not working properly in kernel
	2.5.15.
Date: 12 May 2002 11:26:54 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1021228015.16966.2.camel@turbulence.megapathdsl.net>
References: <Pine.BSF.4.44.0205121032480.6581-100000@shell.unixbox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from front2.mail.megapathdsl.net ([66.80.60.30])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 176y3k-0002a2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 May 2002 11:27:04 -0700
In-Reply-To: <Pine.BSF.4.44.0205121032480.6581-100000@shell.unixbox.com>
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
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2002-05-12 at 10:34, Ani Joshi wrote:
> What video board and arch (i'm assuming i386)?


May 12 07:08:53 turbulence kernel: Linux version 2.4.19-pre8-ac2
(root@turbulence.megapathdsl.net) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-98)) #1 Sun May 12 00:41:02 PDT 2002
May 12 07:08:54 turbulence kernel: Kernel command line: ro
root=/dev/hda6 hdd=ide-scsi console=ttyS0,38400 console=tty0
video=riva:1600x1200-16
May 12 07:08:54 turbulence kernel: Local APIC disabled by BIOS --
reenabling.
May 12 07:08:54 turbulence kernel: Found and enabled local APIC!
May 12 07:08:54 turbulence kernel: Initializing CPU#0
May 12 07:08:54 turbulence kernel: CPU: Before vendor init, caps:
0183fbff c1c3fbff 00000000, vendor = 2
May 12 07:08:54 turbulence kernel: CPU: L1 I Cache: 64K (64 bytes/line),
D cache 64K (64 bytes/line)
May 12 07:08:54 turbulence kernel: CPU: L2 Cache: 512K (64 bytes/line)
May 12 07:08:54 turbulence kernel: CPU: After vendor init, caps:
0183fbff c1c3fbff 00000000 00000000
May 12 07:08:54 turbulence kernel: Intel machine check architecture
supported.
May 12 07:08:54 turbulence kernel: Intel machine check reporting enabled
on CPU#0.
May 12 07:08:54 turbulence kernel: CPU:     After generic, caps:
0183fbff c1c3fbff 00000000 00000000
May 12 07:08:54 turbulence kernel: CPU:             Common caps:
0183fbff c1c3fbff 00000000 00000000
May 12 07:08:56 turbulence kernel: rivafb: RIVA MTRR set to ON
May 12 07:08:57 turbulence kernel: rivafb: PCI nVidia NV10 framebuffer
ver 0.9.3 (GeForce-DDR, 32MB @ 0xE8000000)

01:05.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR
(rev 10) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 000b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at feaf0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


> 
> 
> ani
> 
> On Sat, 11 May 2002, Miles Lane wrote:
> 
> > I am running development kernel 2.5.15 and am having some
> > trouble getting rivafb to display in the correct mode.
> >
> > After booting with "video=riva:1600x1200-16", fbset says:
> >
> > mode "1600x1200-60"
> >      # D: 162.022 MHz, H: 75.010 kHz, V: 60.008 Hz
> >      geometry 1600 1200 1600 1200 16
> >      timings 6172 304 64 46 1 192 3
> >      hsync high
> >      vsync high
> >      accel true
> >      rgba 5/11,6/5,5/0,0/0
> > endmode
> >
> > But the Tux logo is all purple.  After running fbset -a "1600x1200-76",
> > I seem to have the correct mode:
> >
> > mode "1600x1200-76"
> >      # D: 197.981 MHz, H: 95.183 kHz, V: 76.146 Hz
> >      geometry 1600 1200 1600 1200 8
> >      timings 5051 304 40 42 3 136 5
> >      accel true
> >      rgba 8/0,8/0,8/0,0/0
> > endmode
> >
> > What do I need to change about my append= line in order to get
> > the corrent mode set at boot time or is this a bug in the
> > rivafb code in 2.5.15?
> >
> >
> > _______________________________________________________________
> >
> > Have big pipes? SourceForge.net is looking for download mirrors. We supply
> > the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
> > _______________________________________________
> > Linux-fbdev-devel mailing list
> > Linux-fbdev-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> >
> 


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
