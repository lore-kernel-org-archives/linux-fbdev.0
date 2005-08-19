From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/9] fbdev: Update framebuffer feature list
Date: Sat, 20 Aug 2005 00:40:31 +0800
Message-ID: <43060B7F.5060007@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HHM-0002No-ON
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:08 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HHK-0000mk-Sp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:08 -0700
Received: by wproxy.gmail.com with SMTP id i3so655781wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:31:58 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Update feature-list-2.6.txt about the framebuffer layer. Adds what user
    needs to know to get a working framebuffer console in 2.6, major
    differences between 2.4 and 2.6, and some features added to the layer that
    were not present in 2.4.

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 feature-list-2.6.txt |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/feature-list-2.6.txt b/Documentation/feature-list-2.6.txt
--- a/Documentation/feature-list-2.6.txt
+++ b/Documentation/feature-list-2.6.txt
@@ -481,6 +481,17 @@ procps.
 
 Framebuffer layer.
 ~~~~~~~~~~~~~~~~~~
+- GOTCHAS
+  - Just enabling CONFIG_FRAMEBUFFER is not enough to enable a framebuffer
+    console.  CONFIG_FRAMEBUFFER_CONSOLE needs to be set. If
+    CONFIG_FRAMEBUFFER_CONSOLE=m, you need to do a 'modprobe fbcon' to get
+    a framebuffer console.
+  - "stty rows r cols c" may behave differently compared to 2.4.  Where stty
+    just changes the window size without changing the video mode in 2.4, in
+    2.6, stty may also change the video mode, depending on the driver.
+  - initialization sequence for multiple framebuffers is fixed in 2.6. But
+    one can choose which driver gets mapped to the console using the boot
+    option "fbcon:map:n"
 - James Simmons has reworked the framebuffer/console layer considerably for
   2.6. Support for some cards is still lagging a little, but it should be
   functionally no different than previous incarnations.
@@ -489,15 +500,22 @@ Framebuffer layer.
     append = "video=radeon:1024x768-24@100"
   needs to become..
     append = "video=radeonfb:1024x768-24@100"
-- Current userspace tools (fbset for eg) are not yet updated,
-  and won't function as expected.
-- The VESA framebuffer now enables MTRRs for the framebuffer memory range during
-  initialisation (Note: PCI cards only).
-  If you notice screen corruption, please report this, along with an lspci output,
-  so your card can be blacklisted.
+- Current userspace tools (fbset for eg) need not be updated, but prior to
+  kernels older than linux-2.6.8, they won't function as expected.
+- The VESA framebuffer now enables MTRRs for the framebuffer memory range
+  during initialisation (Note: PCI cards only).
+  If you notice screen corruption, please report this, along with an lspci
+  output, so your card can be blacklisted.
+- Support for parsing the EDID (aka Plug and Play Displays) are available
+  for several drivers. If this feature is available, the driver can
+  automatically detect the best mode for your display.
+- There are now three ways to change the video mode.  The first is by using the
+  venerable fbset. It is the most powerful and the one recommended for main
+  use. The second is by sysfs and the third is by stty, as mentioned above.
+  Note that using sysfs or stty is dependent on the number of video modes
+  currently supported internally by the driver.
 - Any problems should go to <jsimmons@infradead.org>
 
-
 IDE.
 ~~~~
 - The IDE code rewrite was subject to much criticism in early 2.5.x, which



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
