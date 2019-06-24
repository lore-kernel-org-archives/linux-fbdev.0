From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 24 Jun 2019 09:21:53 +0000
Subject: [PATCH] vga_switcheroo: Depend upon fbcon being built-in, if enabled
Message-Id: <20190624092153.23375-1-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Sean Paul <sean@poorly.run>, Stephen Rothwell <sfr@canb.auug.org.au>, Hans de Goede <hdegoede@redhat.com>, kbuild test robot <lkp@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, Yisheng Xie <ysxie@foxmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Sam Ravnborg <sam@ravnborg.org>

Fixes linking fail when fbcon/fbdev is modular and vgaswitcheroo is
enabled:

x86_64-linux-gnu-ld: drivers/gpu/vga/vga_switcheroo.o: in function `vga_switchto_stage2':
vga_switcheroo.c:(.text+0x997): undefined reference to `fbcon_remap_all'

v2: I first tried to fix this with an EXPORT_SYMBOL, but vga_switcheroo is
never a module, so this doesn't work.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 1cd51b5d200d ("vgaswitcheroo: call fbcon_remap_all directly")
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
--
wrt merging probably best if Maarten adds this to the topic branch we
have already and sends out an updated pull request.

Apologies for the mess.
-Daniel
---
 drivers/gpu/vga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index 84ab482d0db6..c8c770b05ed9 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -23,6 +23,7 @@ config VGA_SWITCHEROO
 	depends on X86
 	depends on ACPI
 	depends on PCI
+	depends on (FRAMEBUFFER_CONSOLE=n || FB=y)
 	select VGA_ARB
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
-- 
2.20.1
