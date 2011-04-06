From: Peter Jones <pjones@redhat.com>
Date: Wed, 06 Apr 2011 17:34:59 +0000
Subject: [PATCH 2/2] efifb: Add override for 11" Macbook Air 3,1
Message-Id: <1302111299-10561-2-git-send-email-pjones@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Matthew Garrett <mjg@redhat.com>

The 11" Macbook Air appears to claim that its stride is 1366, when it's
actually 2048. Override it.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/video/efifb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
index 2359b64..4eb38db 100644
--- a/drivers/video/efifb.c
+++ b/drivers/video/efifb.c
@@ -53,6 +53,7 @@ enum {
 	M_MB_7_1,	/* MacBook, 7th rev. */
 	M_MB_SR,	/* MacBook, 2nd gen, (Santa Rosa) */
 	M_MBA,		/* MacBook Air */
+	M_MBA_3,	/* Macbook Air, 3rd rev */
 	M_MBP,		/* MacBook Pro */
 	M_MBP_2,	/* MacBook Pro 2nd gen */
 	M_MBP_2_2,	/* MacBook Pro 2,2nd gen */
@@ -97,6 +98,8 @@ static struct efifb_dmi_info {
 	[M_MB_6_1] = { "macbook61", 0x80010000, 2048 * 4, 1280, 800, OVERRIDE_NONE },
 	[M_MB_7_1] = { "macbook71", 0x80010000, 2048 * 4, 1280, 800, OVERRIDE_NONE },
 	[M_MBA] = { "mba", 0x80000000, 2048 * 4, 1280, 800, OVERRIDE_NONE },
+	/* 11" Macbook Air 3,1 passes the wrong stride */
+	[M_MBA_3] = { "mba3", 0, 2048 * 4, 0, 0, OVERRIDE_STRIDE },
 	[M_MBP] = { "mbp", 0x80010000, 1472 * 4, 1440, 900, OVERRIDE_NONE },
 	[M_MBP_2] = { "mbp2", 0, 0, 0, 0, OVERRIDE_NONE }, /* placeholder */
 	[M_MBP_2_2] = { "mbp22", 0x80010000, 1472 * 4, 1440, 900, OVERRIDE_NONE },
@@ -147,6 +150,7 @@ static const struct dmi_system_id dmi_system_table[] __initconst = {
 	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook6,1", M_MB_6_1),
 	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook7,1", M_MB_7_1),
 	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir1,1", M_MBA),
+	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir3,1", M_MBA_3),
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro1,1", M_MBP),
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,1", M_MBP_2),
 	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,2", M_MBP_2_2),
-- 
1.7.4

