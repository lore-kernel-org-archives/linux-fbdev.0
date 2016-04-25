From: Eric Engestrom <eric@engestrom.ch>
Date: Mon, 25 Apr 2016 00:24:21 +0000
Subject: [PATCH 24/41] Documentation: fb: fix spelling mistakes
Message-Id: <1461543878-3639-25-git-send-email-eric@engestrom.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
In-Reply-To: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Eric Engestrom <eric@engestrom.ch>, Bernie Thompson <bernie@plugable.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org

Signed-off-by: Eric Engestrom <eric@engestrom.ch>
---
 Documentation/fb/udlfb.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/fb/udlfb.txt b/Documentation/fb/udlfb.txt
index 57d2f29..c985cb6 100644
--- a/Documentation/fb/udlfb.txt
+++ b/Documentation/fb/udlfb.txt
@@ -9,7 +9,7 @@ pairing that with a hardware framebuffer (16MB) on the other end of the
 USB wire.  That hardware framebuffer is able to drive the VGA, DVI, or HDMI
 monitor with no CPU involvement until a pixel has to change.
 
-The CPU or other local resource does all the rendering; optinally compares the
+The CPU or other local resource does all the rendering; optionally compares the
 result with a local shadow of the remote hardware framebuffer to identify
 the minimal set of pixels that have changed; and compresses and sends those
 pixels line-by-line via USB bulk transfers.
@@ -66,10 +66,10 @@ means that from a hardware and fbdev software perspective, everything is good.
 At that point, a /dev/fb? interface will be present for user-mode applications
 to open and begin writing to the framebuffer of the DisplayLink device using
 standard fbdev calls.  Note that if mmap() is used, by default the user mode
-application must send down damage notifcations to trigger repaints of the
+application must send down damage notifications to trigger repaints of the
 changed regions.  Alternatively, udlfb can be recompiled with experimental
 defio support enabled, to support a page-fault based detection mechanism
-that can work without explicit notifcation.
+that can work without explicit notification.
 
 The most common client of udlfb is xf86-video-displaylink or a modified
 xf86-video-fbdev X server. These servers have no real DisplayLink specific
-- 
2.8.0

