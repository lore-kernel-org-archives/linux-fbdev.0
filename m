From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Wed, 06 Jan 2010 17:59:13 +0000
Subject: Re: 2.6.33-rc3 -- Intel 945GME (inteldrmfb) -- Two Tux images
Message-Id: <20100106185913.39003329@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a44ae5cd1001060916s4db1d94fsb7e012ab80ce6add@mail.gmail.com>
In-Reply-To: <a44ae5cd1001060916s4db1d94fsb7e012ab80ce6add@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-fbdev@vger.kernel.org

On Wed, 06 January 2010 Miles Lane <miles.lane@gmail.com> wrote:
> For a long time I have gotten two pictures of Tux showing up when I
> include the Tux display option in my custom kernel builds.  I don't
> know how many kernel revisions ago it was when I started noticing
> this.  It seems like it might have been early in the 2.6 series
> kernels.

Unless your system has exactly one CPU without hyperthreading and with
exactly one core this is the correct bahavior, one tux per logical CPU.

If you just want a single tux you can run your kernel on a system with
only one logical CPU, boot it with maxcpus=3D1 or rebuild it with
CONFIG_SMP=3Dn... though in those case you will not be able to benefit
from all of your CPU's resources..

Bruno

> dmesg:
>=20
> Linux agpgart interface v0.103
> agpgart-intel 0000:00:00.0: Intel 945GME Chipset
> agpgart-intel 0000:00:00.0: detected 7932K stolen memory
> agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
> [drm] Initialized drm 1.1.0 20060810
> i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> i915 0000:00:02.0: setting latency timer to 64
> [drm] set up 7M of stolen space
> integrated sync not supported
> ACPI: Battery Slot [BAT0] (battery present)
> [drm] initialized overlay support
> [drm] LVDS-8: set mode 1024x600 27
> Console: switching to colour frame buffer device 128x37
> fb0: inteldrmfb frame buffer device
> registered panic notifier
> [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
>=20
> # lspci -vvxxx -s 2.1
>=20
> 00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME,
> 943/940GML Express Integrated Graphics Controller (rev 03)
> 	Subsystem: ASUSTeK Computer Inc. Device 8340
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Region 0: Memory at f7f80000 (32-bit, non-prefetchable)
> [sizeQ2K] Capabilities: [d0] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=3D0
> DScale=3D0 PME- 00: 86 80 a6 27 07 00 90 00 03 00 80 03 00 00 80 00
> 10: 00 00 f8 f7 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 40 83
> 30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 48 00 00 00 09 00 09 71 23 25 4a a1
> 50: 0e 00 30 00 1b 00 00 00 00 00 00 00 00 00 80 7f
> 60: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 88 40 64 34 10 00 00 00 86 0f 05 00 00 00 00 00
>=20
> From .config:
>=20
> # Graphics support
> #
> CONFIG_AGP=3Dy
> CONFIG_AGP_INTEL=3Dy
> CONFIG_VGA_ARB=3Dy
> CONFIG_DRM=3Dy
> CONFIG_DRM_KMS_HELPER=3Dy
> CONFIG_DRM_I915=3Dy
> CONFIG_DRM_I915_KMS=3Dy
> CONFIG_VIDEO_OUTPUT_CONTROL=3Dy
> CONFIG_FB=3Dy
> CONFIG_FIRMWARE_EDID=3Dy
> CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_MODE_HELPERS=3Dy
> CONFIG_FB_TILEBLITTING=3Dy
>=20
> # Frame buffer hardware drivers
> #
> CONFIG_FB_VESA=3Dy
> CONFIG_FB_EFI=3Dy
> CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> CONFIG_LCD_CLASS_DEVICE=3Dy
> CONFIG_LCD_PLATFORM=3Dy
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
>=20
> # Display device support
> #
> CONFIG_DISPLAY_SUPPORT=3Dy
>=20
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
> CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=128
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> CONFIG_LOGO=3Dy
> CONFIG_LOGO_LINUX_CLUT224=3Dy
