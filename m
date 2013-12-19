From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 19 Dec 2013 16:18:30 +0000
Subject: [PATCH v2] x86: sysfb: fool-proof CONFIG_X86_SYSFB
Message-Id: <1387469910-24560-1-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387460330-13989-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1387460330-13989-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-fbdev@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, stable@vger.kernel.org

Turns out, people do not read help-texts of new config-options and enable
them nonetheless. So several reports came in with X86_SYSFB=y and
FB_SIMPLE=n, which in almost all situations prevents firmware-fbs from
being probed.

X86_SYSFB clearly states that it turns legacy vesa/efi framebuffers into a
format compatible to simplefb (and does nothing else..). So to avoid
further complaints about missing gfx-support during boot, simply depend on
FB_SIMPLE now.
As FB_SIMPLE is disabled by default and usually only enabled on selected
ARM architectures, x86 users should thus never see the X86_SYSFB
config-option. And if they do, everything is fine as simplefb will be
available.

Note that most of the sysfb code is enabled independently of X86_SYSFB.
The config option only selects a compatibility mode for simplefb. It was
introduced to ease the transition to SimpleDRM and disabling fbdev. As
this is still ongoing, there's no need for non-developers to care for
X86_SYSFB so we can safely hide it behind FB_SIMPLE.

Cc: <stable@vger.kernel.org> # 3.11+
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
v2:
 - keep the "If unsure, say Y"
 - (FB_SIMPLE = y) => FB_SIMPLE
 - adjust commit-msg

 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e903c71..c9d2952 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2298,6 +2298,7 @@ source "drivers/rapidio/Kconfig"
 
 config X86_SYSFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
+	depends on FB_SIMPLE
 	help
 	  Firmwares often provide initial graphics framebuffers so the BIOS,
 	  bootloader or kernel can show basic video-output during boot for
-- 
1.8.5.1

