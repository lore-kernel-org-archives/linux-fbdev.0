From: David Eger <eger@theboonies.us>
Subject: FB accel capabilities patch
Date: Wed, 19 May 2004 11:36:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S262488AbUESJcQ@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: Linux Frame Buffer Dev <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org


Dear Andrew,

A month or two ago I noticed that the framebuffer console driver doesn't
know to do proper framebuffer acceleration in Linux 2.6;  I've implemented
a solution Geert suggested where each framebuffer driver advertizes its 
hardware capabilities via fb_info->flags.  Please apply to -mm so I can 
get wider testing.

The patches are at:

http://www.yak.net/random/fbdev-patches/accel-cap-take2/relative2mainline/

The core of these patches is enabling the use of the following flags:

+/* FBIF = FB_Info.Flags */
+#define FBIF_MODULE		0x0001	/* Low-level driver is a module */
+#define FBIF_HWACCEL_DISABLED	0x0002
+
+/* hints */
+#define FBIF_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
+#define FBIF_READS_FAST		0x0080 /* soft-copy faster than rendering */
+
+/* hardware supported ops */
+#define FBIF_HWACCEL_NONE	0x0000
+#define FBIF_HWACCEL_COPYAREA	0x0100
+#define FBIF_HWACCEL_FILLRECT	0x0200
+#define FBIF_HWACCEL_ROTATE	0x0400
+#define FBIF_HWACCEL_IMAGEBLIT	0x0800
+#define FBIF_HWACCEL_XPAN	0x1000
+#define FBIF_HWACCEL_YPAN	0x2000
+#define FBIF_HWACCEL_YWRAP	0x4000

Patches to each individual driver will trickle in as I get to them;
Since these are only hints to the "application" of fbcon, the fact that 
the hints aren't yet accurate for all drivers (default is zero/one depending
on if the fb driver is a module) is OK, and nothing should break with these
patches.  Each driver also doesn't have to reimplement a noaccel flag 
(to disable acceleration, mainly for testing new accel code), since it
will be already in fb_info now ;-)

-dte

---
getting bounce messages from me? let me know and you'll go on my whitelist
