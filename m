From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 10 Nov 2010 09:45:20 +0000
Subject: [PATCH 3/3] OMAP: DSS: Fix documentation regarding 'vram' kernel parameter
Message-Id: <1289382320-17412-3-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

The DSS documentation didn't mention the option to give the VRAM start
address.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 Documentation/arm/OMAP/DSS |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 0af0e9e..888ae7b 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -255,9 +255,10 @@ framebuffer parameters.
 Kernel boot arguments
 ---------------------
 
-vram=<size>
-	- Amount of total VRAM to preallocate. For example, "10M". omapfb
-	  allocates memory for framebuffers from VRAM.
+vram=<size>[,<physaddr>]
+	- Amount of total VRAM to preallocate and optionally a physical start
+	  memory address. For example, "10M". omapfb allocates memory for
+	  framebuffers from VRAM.
 
 omapfb.mode=<display>:<mode>[,...]
 	- Default video mode for specified displays. For example,
-- 
1.7.1

