From: Lenny <darwinskernel@gmail.com>
Date: Wed, 29 Dec 2010 05:11:15 +0000
Subject: increase max fb size and i
Message-Id: <20101229051115.GA18465@WALL-E>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org


Guennadi: sorry for submitting twice. apparently linux-fbdev-users has
been migrated here.

i was just wondering if this commit by Guennadi Liakhovetski in -rc8:

	fbdev: sh_mobile_lcdc: increase maximum framebuffer size to support 1080p

would solve the probelm i've been having with 720p/1080p playback on my mac=
hine.
i'm using mplayer the err message i get is:

framebuffer too small for double-buffering, disabling

machine's graphic chip's spec. reported by lscpi -vv:

00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 Int=
egrated Graphics Controller (rev 03) (prog-if 00 [VGA controller])
	Subsystem: Apple Computer Inc. Device 00a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at 50100000 (64-bit, non-prefetchable) [size=3D1M]
	Region 2: Memory at 40000000 (64-bit, prefetchable) [size%6M]
	Region 4: I/O ports at 6110 [size=3D8]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: <access denied>
	Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 Integrated=
 Graphics Controller (rev 03)
	Subsystem: Apple Computer Inc. Device 00a1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAbort- <M=
Abort- >SERR- <PERR- INTx-
	Region 0: Memory at 50200000 (64-bit, non-prefetchable) [disabled] [size=
=3D1M]
	Capabilities: <access denied>

/proc/fb: 0 inteldrmfb

Kernel command line: rootflags=3Drw rootfstype=3Dbtrfs add_efi_memmap ro vi=
deo=3Dintelfb:mtrr=3D1,accel,vram%0

regards,
