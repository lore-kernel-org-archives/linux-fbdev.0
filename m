From: Jan Altenberg <jan.altenberg@linutronix.de>
Subject: [PATCH] AT91: include atmel_lcdc.h in at91sam926{1,3}_devices.c
Date: Wed, 01 Aug 2007 15:22:52 +0200
Message-ID: <1185974572.3854.52.camel@bender.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763374AbXHANXL@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
To: Andrew Victor <andrew@sanpeople.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Jan Altenberg <jan.altenberg@linutronix.de>, Patrice Vilchez <patrice.vilchez@rfo.atmel.com>, Nicolas Ferre <nicolas.ferre@rfo.atmel.com>

Hi all,

current git doesn't compile for CONFIG_ARCH_AT91SAM926{1,3} and
and CONFIG_FB_ATMEL enabled, due to a missing inclusion of atmel_lcdc.h=
:

/home/jan/kernel/git/linux-2.6/arch/arm/mach-at91/at91sam9263_devices.c=
: In function =E2=80=98at91_add_device_lcdc=E2=80=99:
/home/jan/kernel/git/linux-2.6/arch/arm/mach-at91/at91sam9263_devices.c=
:688: error: dereferencing pointer to incomplete type
/home/jan/kernel/git/linux-2.6/arch/arm/mach-at91/at91sam9263_devices.c=
:688: error: =E2=80=98lcdc_data=E2=80=99 has an incomplete type

This error should also have occured in the past, because atmel_lcdc.h
has never been included.

Signed-off-by: Jan Altenberg <jan.altenberg@linutronix.de>

---
 arch/arm/mach-at91/at91sam9261_devices.c |    2 ++
 arch/arm/mach-at91/at91sam9263_devices.c |    2 ++
 2 files changed, 4 insertions(+)

Index: linux-2.6/arch/arm/mach-at91/at91sam9261_devices.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/arm/mach-at91/at91sam9261_devices.c
+++ linux-2.6/arch/arm/mach-at91/at91sam9261_devices.c
@@ -15,6 +15,8 @@
=20
 #include <linux/platform_device.h>
=20
+#include <video/atmel_lcdc.h>
+
 #include <asm/arch/board.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/at91sam9261.h>
Index: linux-2.6/arch/arm/mach-at91/at91sam9263_devices.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/arm/mach-at91/at91sam9263_devices.c
+++ linux-2.6/arch/arm/mach-at91/at91sam9263_devices.c
@@ -14,6 +14,8 @@
=20
 #include <linux/platform_device.h>
=20
+#include <video/atmel_lcdc.h>
+
 #include <asm/arch/board.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/at91sam9263.h>
