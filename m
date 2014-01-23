From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 23 Jan 2014 14:15:03 +0000
Subject: [PATCH 11/11] x86/sysfb: allow sysfb+simpledrm combination
Message-Id: <1390486503-1504-12-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ingo Molnar <mingo@kernel.org>

We used to protect X86_SYSFB by depending on FB_SIMPLE so users don't
accidentally end up without a kernel console. Now that DRM_SIMPLEDRM also
provides a simple-framebuffer driver, we can whitelist this driver, too.
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 93df439..f3eae6a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2299,7 +2299,7 @@ source "drivers/rapidio/Kconfig"
 
 config X86_SYSFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
-	depends on FB_SIMPLE
+	depends on FB_SIMPLE || DRM_SIMPLEDRM
 	select SYSFB
 	help
 	  Firmwares often provide initial graphics framebuffers so the BIOS,
-- 
1.8.5.3

