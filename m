From: Miles Lane <miles.lane@gmail.com>
Date: Fri, 15 Jan 2010 04:18:14 +0000
Subject: 2.6.33-rc4-git1 -- [drm:i915_gem_execbuffer] *ERROR*
Message-Id: <a44ae5cd1001142018k1f6b741buf560edbda0ca6e33@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: LKML <linux-kernel@vger.kernel.org>, DRI for Linux <dri-devel@lists.sourceforge.net>, David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org

I just hit this with 2.6.33-rc4-git1 and DRI modesetting enabled.  I
don't know what event triggered the error.  I had resumed from suspend
a long time before the error appeared in my dmesg output:

[ 8505.847430] [drm:i915_gem_execbuffer] *ERROR*
i915_gem_do_execbuffer returns -512

00:02.0 VGA compatible controller: Intel Corporation Mobile 945GME
Express Integrated Graphics Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc. Device 8340
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f7f00000 (32-bit, non-prefetchable) [sizeQ2K]
	Region 1: I/O ports at dc00 [size=3D8]
	Region 2: Memory at d0000000 (32-bit, prefetchable) [size%6M]
	Region 3: Memory at f7ec0000 (32-bit, non-prefetchable) [size%6K]
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=3D0/0 =
Enable-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: i915

CONFIG_AGP=3Dy
CONFIG_AGP_INTEL=3Dy
CONFIG_VGA_ARB=3Dy
CONFIG_DRM=3Dy
CONFIG_DRM_KMS_HELPER=3Dy
CONFIG_DRM_I915=3Dy
CONFIG_DRM_I915_KMS=3Dy
CONFIG_VIDEO_OUTPUT_CONTROL=3Dy
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy
