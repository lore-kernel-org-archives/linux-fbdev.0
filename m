From: Anatolij Gustschin <agust@denx.de>
Date: Mon, 14 Nov 2011 00:32:45 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111114013245.516c4ed0@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Sun, 13 Nov 2011 22:48:02 -0500 (EST)
David J Ring Jr <n1ea@arrl.net> wrote:

> I get these drivers:
...

Thanks for the info. As Bruno already guessed you have a mainstream
Intel GPU, the driver for it in under drivers/gpu/. From the log I
can see that it is probed. Try to disable passing "nomodeset" option
on the kernel command line.

> Is there a universal driver?

You already got the right one, see below.

> [    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-2.6.32-5-6=
86 root=3DUUID=CB1268f1-4e20-4409-87b1-3d882c14102c ro nomodeset
...
> [    1.002504] Linux agpgart interface v0.103
> [    1.002638] agpgart-intel 0000:00:00.0: Intel Mobile Intel=AE GM45 Exp=
ress Chipset
> [    1.003092] agpgart-intel 0000:00:00.0: detected 32764K stolen memory
> [    1.034511] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000=
000
...
> [    8.825096] [drm] Initialized drm 1.1.0 20060810
> [    8.827153] uvcvideo: Found UVC 1.00 device Lenovo EasyCamera (04f2:b0=
90)
> [    8.830393] input: Lenovo EasyCamera as /devices/pci0000:00/0000:00:1d=
.7/usb3/3-3/3-3:1.0/input/input5
> [    8.830589] usbcore: registered new interface driver uvcvideo
> [    8.830712] USB Video Class driver (v0.1.0)
> [    8.872716] pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ =
16
> [    8.872790] pci 0000:00:02.0: setting latency timer to 64
> [    8.878968] mtrr: type mismatch for d0000000,10000000 old: write-back =
new: write-combining
> [    8.879055] [drm] MTRR allocation failed.  Graphics performance may su=
ffer.
...
> [    8.990393] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post:=
 no)
> [    8.990485] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on =
minor 0

The driver is already in the kernel, you have to disable passing
"nomodeset", as Bruno suggested.

Anatolij
