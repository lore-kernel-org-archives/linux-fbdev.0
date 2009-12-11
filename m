From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Date: Fri, 11 Dec 2009 13:21:51 +0000
Subject: [PATCH 2/2] [Resend] OMAP: ams_delta_defconfig: enable LCD class device support
Message-Id: <200912111421.52555.jkrzyszt@tis.icnet.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <200911231857.55566.jkrzyszt@tis.icnet.pl> <200912111255.48176.jkrzyszt@tis.icnet.pl> <1260533259.10417.3.camel@tubuntu.research.nokia.com>
In-Reply-To: <1260533259.10417.3.camel@tubuntu.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The patch enables LCD class device support in ams_delta_defconfig in order =
to
get optional contrast control functional.

Created and tested against linux-omap for-next,
commit 155a75d9725e66e5ec8a383822957dee52427057.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Friday 11 December 2009 13:07:39 Tomi Valkeinen napisa=C5=82(a):
> On Fri, 2009-12-11 at 12:55 +0100, ext Janusz Krzysztofik wrote:
> >
> > Am I supposed to do anything about this series[1]? Resend to you?
>
> Yes, please resend to me. I don't seem to have the patches in my mailbox
> anymore.

--- a/arch/arm/configs/ams_delta_defconfig	2009-11-14 23:48:40.000000000 +0=
100
+++ b/arch/arm/configs/ams_delta_defconfig	2009-11-16 01:06:12.000000000 +0=
100
@@ -836,7 +836,8 @@
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
+CONFIG_LCD_CLASS_DEVICE=3Dy
=20
 #
 # Display device support



