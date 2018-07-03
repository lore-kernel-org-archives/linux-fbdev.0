From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 03 Jul 2018 12:28:13 +0000
Subject: [PATCH] video: fbdev: metronomefb: fix some off by one bugs
Message-Id: <20180703122813.hb75xlkxybogqpoq@kili.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org

The "mem" buffer has "size" bytes.  The ">" should be ">=" to prevent
reading one character beyond the end of the array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 9085e9525341..bb4fee52e501 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -233,7 +233,7 @@ static int load_waveform(u8 *mem, size_t size, int m, int t,
 
 	/* check temperature range table checksum */
 	cksum_idx = sizeof(*wfm_hdr) + wfm_hdr->trc + 1;
-	if (cksum_idx > size)
+	if (cksum_idx >= size)
 		return -EINVAL;
 	cksum = calc_cksum(sizeof(*wfm_hdr), cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
@@ -245,7 +245,7 @@ static int load_waveform(u8 *mem, size_t size, int m, int t,
 	/* check waveform mode table address checksum */
 	wmta = get_unaligned_le32(wfm_hdr->wmta) & 0x00FFFFFF;
 	cksum_idx = wmta + m*4 + 3;
-	if (cksum_idx > size)
+	if (cksum_idx >= size)
 		return -EINVAL;
 	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
@@ -257,7 +257,7 @@ static int load_waveform(u8 *mem, size_t size, int m, int t,
 	/* check waveform temperature table address checksum */
 	tta = get_unaligned_le32(mem + wmta + m * 4) & 0x00FFFFFF;
 	cksum_idx = tta + trn*4 + 3;
-	if (cksum_idx > size)
+	if (cksum_idx >= size)
 		return -EINVAL;
 	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
@@ -270,7 +270,7 @@ static int load_waveform(u8 *mem, size_t size, int m, int t,
 	metromem buffer. this does runlength decoding of the waveform */
 	wfm_idx = get_unaligned_le32(mem + tta + trn * 4) & 0x00FFFFFF;
 	owfm_idx = wfm_idx;
-	if (wfm_idx > size)
+	if (wfm_idx >= size)
 		return -EINVAL;
 	while (wfm_idx < size) {
 		unsigned char rl;
@@ -292,7 +292,7 @@ static int load_waveform(u8 *mem, size_t size, int m, int t,
 	}
 
 	cksum_idx = wfm_idx;
-	if (cksum_idx > size)
+	if (cksum_idx >= size)
 		return -EINVAL;
 	cksum = calc_cksum(owfm_idx, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
