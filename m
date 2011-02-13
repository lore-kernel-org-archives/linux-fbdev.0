From: Martin Decky <martin@decky.cz>
Date: Sun, 13 Feb 2011 19:28:40 +0000
Subject: [PATCH] Fix EDID macros H_SYNC_WIDTH and H_SYNC_OFFSET
Message-Id: <4D5830E8.50900@decky.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Martin Decky <martin@decky.cz>

The macros for getting the values for horizontal sync width and offset
do not respect the EDID specification. Both these values are 10 bit
values according to [1], not 6 bit values. The lower 8 bits are stored
in byte 8 and byte 9 of the DTD respectively, while two additional bits
for each value are stored in byte 11. The original macros just slammed
the bits together.

Although the original macros usually worked fine because the higher two
bits are rarely used, it can cause severe problems on plasma panels
running at 1920x1080 @ 50 Hz with drivers that rely on the correct
parsing of the EDID data by fbmon.c (e.g. udlfb).

The patch should apply cleanly to both the fbdev-2.6.git branch and
linux-next.git branch.

[1] VESA Enhanced Extended Display Identification Data Standard,
     Release A, Revision 2, page 34, notes 7 & 8, VESA, Sep 2006

Signed-off-by: Martin Decky <martin@decky.cz>
----
diff -Naurp fbdev-2.6.orig/drivers/video/edid.h fbdev-2.6/drivers/video/edid.h
--- fbdev-2.6.orig/drivers/video/edid.h	2011-02-13 19:45:22.000000000 +0100
+++ fbdev-2.6/drivers/video/edid.h	2011-02-13 19:56:02.080350929 +0100
@@ -101,8 +101,8 @@
  #define V_SYNC_WIDTH       COMBINE_HI_4LO( V_SYNC_WIDTH_HI, V_SYNC_WIDTH_LO )
  #define V_SYNC_OFFSET      COMBINE_HI_4LO( V_SYNC_OFFSET_HI, V_SYNC_OFFSET_LO )

-#define H_SYNC_WIDTH       COMBINE_HI_4LO( H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO )
-#define H_SYNC_OFFSET      COMBINE_HI_4LO( H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO )
+#define H_SYNC_WIDTH       COMBINE_HI_8LO( H_SYNC_WIDTH_HI, H_SYNC_WIDTH_LO )
+#define H_SYNC_OFFSET      COMBINE_HI_8LO( H_SYNC_OFFSET_HI, H_SYNC_OFFSET_LO )

  #define H_SIZE_LO          (unsigned)block[ 12 ]
  #define V_SIZE_LO          (unsigned)block[ 13 ]
