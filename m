From: simran singhal <singhalsimran0@gmail.com>
Date: Mon, 27 Feb 2017 18:26:28 +0000
Subject: [PATCH 5/5] staging: gdm724x: Remove unnecessary else after return
Message-Id: <1488219268-3006-5-git-send-email-singhalsimran0@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488219268-3006-1-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1488219268-3006-1-git-send-email-singhalsimran0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, outreachy-kernel@googlegroups.com

This patch fixes the checkpatch warning that else is not generally
useful after a break or return.

This was done using Coccinelle:
@@
expression e2;
statement s1;
@@
if(e2) { ... return ...; }
-else
         s1

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/gdm724x/gdm_endian.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_endian.c b/drivers/staging/gdm724x/gdm_endian.c
index d0b43e2..4ef728f 100644
--- a/drivers/staging/gdm724x/gdm_endian.c
+++ b/drivers/staging/gdm724x/gdm_endian.c
@@ -26,30 +26,26 @@ __dev16 gdm_cpu_to_dev16(struct gdm_endian *ed, u16 x)
 {
 	if (ed->dev_ed = ENDIANNESS_LITTLE)
 		return (__force __dev16)cpu_to_le16(x);
-	else
-		return (__force __dev16)cpu_to_be16(x);
+	return (__force __dev16)cpu_to_be16(x);
 }
 
 u16 gdm_dev16_to_cpu(struct gdm_endian *ed, __dev16 x)
 {
 	if (ed->dev_ed = ENDIANNESS_LITTLE)
 		return le16_to_cpu((__force __le16)x);
-	else
-		return be16_to_cpu((__force __be16)x);
+	return be16_to_cpu((__force __be16)x);
 }
 
 __dev32 gdm_cpu_to_dev32(struct gdm_endian *ed, u32 x)
 {
 	if (ed->dev_ed = ENDIANNESS_LITTLE)
 		return (__force __dev32)cpu_to_le32(x);
-	else
-		return (__force __dev32)cpu_to_be32(x);
+	return (__force __dev32)cpu_to_be32(x);
 }
 
 u32 gdm_dev32_to_cpu(struct gdm_endian *ed, __dev32 x)
 {
 	if (ed->dev_ed = ENDIANNESS_LITTLE)
 		return le32_to_cpu((__force __le32)x);
-	else
-		return be32_to_cpu((__force __be32)x);
+	return be32_to_cpu((__force __be32)x);
 }
-- 
2.7.4

