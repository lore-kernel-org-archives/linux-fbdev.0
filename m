From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 28 Apr 2017 19:51:25 +0000
Subject: [PATCH] fbdev: sti: don't select CONFIG_VT
Message-Id: <20170428195151.57706-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, jejb@parisc-linux.org, Alexander Beregalov <a.beregalov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

While working on another build error, I ran into several variations of
this dependency loop:

subsection "Kconfig recursive dependency limitations"
drivers/input/Kconfig:8:	symbol INPUT is selected by VT
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/tty/Kconfig:12:	symbol VT is selected by FB_STI
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/video/fbdev/Kconfig:677:	symbol FB_STI depends on FB
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/video/fbdev/Kconfig:5:	symbol FB is selected by DRM_KMS_FB_HELPER
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/drm/Kconfig:72:	symbol DRM_KMS_FB_HELPER is selected by DRM_KMS_CMA_HELPER
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/drm/Kconfig:137:	symbol DRM_KMS_CMA_HELPER is selected by DRM_HDLCD
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/drm/arm/Kconfig:6:	symbol DRM_HDLCD depends on OF
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/of/Kconfig:4:	symbol OF is selected by X86_INTEL_CE
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/x86/Kconfig:523:	symbol X86_INTEL_CE depends on X86_IO_APIC
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/x86/Kconfig:1011:	symbol X86_IO_APIC depends on X86_LOCAL_APIC
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/x86/Kconfig:1005:	symbol X86_LOCAL_APIC depends on X86_UP_APIC
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
arch/x86/Kconfig:980:	symbol X86_UP_APIC depends on PCI_MSI
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/pci/Kconfig:11:	symbol PCI_MSI is selected by AMD_IOMMU
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/iommu/Kconfig:106:	symbol AMD_IOMMU depends on IOMMU_SUPPORT
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/iommu/Kconfig:5:	symbol IOMMU_SUPPORT is selected by DRM_ETNAVIV
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/drm/etnaviv/Kconfig:2:	symbol DRM_ETNAVIV depends on THERMAL
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/thermal/Kconfig:5:	symbol THERMAL is selected by ACPI_VIDEO
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/acpi/Kconfig:183:	symbol ACPI_VIDEO is selected by INPUT

This doesn't currently show up as I fixed the 'THERMAL' part of it,
but I noticed that the FB_STI dependency should not be there but
was introduced by slightly incorrect bug-fix patch that tried to
fix a link error.

Instead of selecting 'VT' to make us enter the drivers/video/console
directory at compile-time, it's sufficient to build the
drivers/video/console/sticore.c file by adding its directory
to when CONFIG_FB_STI is enabled. Alternatively, we could move the
sticore code to another directory that is always built when we
have at STI_CONSOLE or FB_STI enabled.

Fixes: 17085a934592 ("parisc: stifb: should depend on STI_CONSOLE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/Makefile      | 1 +
 drivers/video/fbdev/Kconfig | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9ad3c17d6456..445b2c230b56 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-$(CONFIG_HDMI)                += hdmi.o
 
 obj-$(CONFIG_VT)		  += console/
+obj-$(CONFIG_FB_STI)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 obj-y				  += backlight/
 
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 4e36e14d878f..a5797a697114 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -680,8 +680,6 @@ config FB_STI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select STI_CONSOLE
-	select VT
 	default y
 	---help---
 	  STI refers to the HP "Standard Text Interface" which is a set of
-- 
2.9.0

