From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 14 Nov 2014 19:11:57 +0000
Subject: Re: [PATCH] x86, ia64: Do not lose track of the EFI default VGA device
Message-Id: <20141114191157.GA1648@polaris.bitmath.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415969610-1469-1-git-send-email-rydberg@euromail.se>
 <20141114154252.0fb66bba@pluto.restena.lu>
In-Reply-To: <20141114154252.0fb66bba@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bruno,

> So it would need to at least be select VGA_ARB if (PCI && !S390)
> in order to not have broken kernel configuration (in more or less
> exotic cases) while depends on VGA_ARB would be the only correct option
> if the rule 'select only allowed for leafs' is enforced.

Here is a tested patch that does just that, thanks for the suggestion.

Henrik

From 43c16bbc7adbcb17aac73d09f046bf2779771c4c Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 14 Nov 2014 20:01:21 +0100
Subject: [PATCH v2] x86, ia64: Do not lose track of the EFI default VGA dev=
ice
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Since commit 20cde694 in the 3.17 merge window, the EFI framebuffer
depends on the VGA arbitration layer. However, the configuration does
not reflect this, which leads to a hard-to-find bug when FB_EFI is
configured without VGA_ARB. Add a select clause to remedy this.

Cc: Bruno Pr=E9mont <bonbons@linux-vserver.org>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/video/fbdev/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c7bf606..1615a1b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -761,6 +761,7 @@ config FB_EFI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VGA_ARB if (PCI && !S390)
 	help
 	  This is the EFI frame buffer device driver. If the firmware on
 	  your platform is EFI 1.10 or UEFI 2.0, select Y to add support for
--=20
2.1.3

