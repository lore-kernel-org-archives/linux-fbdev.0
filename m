From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 14 Nov 2014 12:53:30 +0000
Subject: [PATCH] x86, ia64: Do not lose track of the EFI default VGA device
Message-Id: <1415969610-1469-1-git-send-email-rydberg@euromail.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Jones <pjones@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>

Since commit 20cde694027e ("x86, ia64: Move EFI_FB
vga_default_device() initialization to pci_vga_fixup()") in the 3.17
merge window, the EFI framebuffer depends on the VGA arbitration
layer. However, the configuration does not reflect this, which leads
to a hard-to-find bug when FB_EFI is configured without VGA_ARB. Add a
select clause to remedy this.

Cc: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Peter,

I stumbled upon this bug from the 3.17 merge window when updating to
Linus's 3.18 git head yesterday. The patch has been tested on two
different EFI machines; one that needs the patch and one that does not.

Thanks,
Henrik

 drivers/video/fbdev/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c7bf606..81b21bc 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -761,6 +761,7 @@ config FB_EFI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VGA_ARB
 	help
 	  This is the EFI frame buffer device driver. If the firmware on
 	  your platform is EFI 1.10 or UEFI 2.0, select Y to add support for
--=20
2.1.3

