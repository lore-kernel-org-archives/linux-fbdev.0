From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:46:02 +0000
Subject: [RFC 14/14] bootsplash: Update MAINTAINERS
Message-Id: <20171025124602.28292-15-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a74227ad082e..ee792797cee9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2705,6 +2705,15 @@ S:	Supported
 F:	drivers/net/bonding/
 F:	include/uapi/linux/if_bonding.h
 
+BOOTSPLASH
+M:	Max Staudt <mstaudt@suse.de>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/fb/bootsplash.txt
+F:	drivers/video/fbdev/core/bootsplash*.*
+F:	drivers/video/fbdev/core/dummycon.c
+F:	include/linux/bootsplash.h
+
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
-- 
2.12.3

