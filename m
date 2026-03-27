Received: from outbound.mr.icloud.com (p-west2-cluster4-host3-snip4-10.eps.apple.com [57.103.69.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893FD3D3331
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Mar 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602902; cv=none; b=PwnNzOqJE7cvGVruH2mGugM/DkNIXERyzSR79UyEqOCrSKTtmEQyEMkQE62jxtaaB2rqilUmymzQ7Vm0o52qGylYfz/hUG0pBXEHS69t+uqfVsFq0VPh0iUBb2UkMyePYj5aTO3CRRYWfvhG5BypMCamiwjt7lnJ/zugKrrlisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602902; c=relaxed/simple;
	bh=/ohvbbJzWVBK12meg1Kzg3kdBNB/gA4ULErSd0EhV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdesRHBbc6dA3TjE+3yoKXjsiULn0Y0AzuKoitnJDKzkeUwoA7g0S5WWpKAUTAlp60p5QPN9NNAzGqZ/04e+UdgN+vuCNg2/VINxON0FzdReq8vCpGn+DUYypYqVqWLiXI1xb1YEz5EK7TSvTqMaHo5P6Nlkc6UpfUu7ukTGZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lnBUd6b3; arc=none smtp.client-ip=57.103.69.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lnBUd6b3"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id A0A9818002DE;
	Fri, 27 Mar 2026 09:14:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1774602899; x=1777194899; bh=lkvpEpyyATm8UsHZFHU2HKw43bExAWX6FIfop4OJU3Y=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=lnBUd6b3sln9HJyZaRVDpGLen988eCGUaEab3T369u/HDPRLVxGoFAvLopUzIHL8fkwDpllNRZOTB4QGPZYP6D5DpXSH/vsimC+u5gheya8e8VL7ijtG3mRw5y8Gy0zlc8QsMFdMoNjCiImIh2GtNYoTZ8GJtgt30gWPEYQZ1FgBan7mlW//y0x3+x4xf/1x93HLHjMW8MpTyJxTT8+YQnr3cn19RxGswcTFFEglatMst0npf6IPLkVrfQyq/90dgOYbpF23NIH3OZuOfm/V8PBCxQNGNL1KUWycDjiWZfHytkryU3+idjomtqq/IdZ3DXcNmAWdgbjFDB0Fnzf9iQ==
Received: from nixos-thinkpad.fritz.box (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id 2A7DF18002C6;
	Fri, 27 Mar 2026 09:14:51 +0000 (UTC)
From: Hadi Chokr <hadichokr@icloud.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hadi Chokr <hadichokr@icloud.com>
Subject: [PATCH] staging: sm750fb: fix naming conventions and remove dead code
Date: Fri, 27 Mar 2026 10:14:02 +0100
Message-ID: <20260327091402.55366-1-hadichokr@icloud.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uPlILoRUKXGk0OVacLIzGZH3m9zQFQwW
X-Authority-Info-Out: v=2.4 cv=J/inLQnS c=1 sm=1 tr=0 ts=69c64a91
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=r945xf9LNZYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=LkKSqY--ZLQNpu6Ln6kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA2NyBTYWx0ZWRfX90E+QGgS8B/8
 CU5IEYcuA9dwy0ZXhtsslPX3DyoCUVqfM+gKJLYEsoUK4wqNgF72kjj77fEbwIENwjUuLVQz6pF
 WchBG/u/Yc7BBLtOnxT5EldQ/j4julUYcoEi0XlavxAnjZEWnWUmg1gIjjfbYvo2W46AUpN6ppd
 3GXL10cAPhjnOEF26N9mX78cYHa0Hkih+3xWx3tlvMwWOdga9dCMEnplbdZAbI4qNi4MvoeMfwC
 hd4n6MLNUcj/dzzEIWue/jFYJmaFOk991vNJUq9gqcLb4hcXZhxImA2StvayTarR2weReW3WDe3
 6osihxCghBRWs+19pO+7uwnk4syMbRYk2V3zdvGzdJP/v3LMnxDb+vgMyLfZp8=
X-Proofpoint-ORIG-GUID: uPlILoRUKXGk0OVacLIzGZH3m9zQFQwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603270067

Convert camelCase to snake_case to fix all checkpatch warnings.

Remove unused function sm750_hw_cursor_set_data2() and its declaration.

checkpatch warned that g_fbmode should be 'static const char * const';
this revealed that lynxfb_set_fbinfo() was writing back into g_fbmode
unnecessarily. Refactor to resolve the mode string into a local
const char * instead. Also drop the redundant NULL initializer since
static storage is zero-initialized.

Remove manual write to pdev->dev.power.power_state.event in
lynxfb_resume(); fb_set_suspend() already handles the resume state
correctly.

Signed-off-by: Hadi Chokr <hadichokr@icloud.com>
---
 drivers/staging/sm750fb/sm750.c        | 47 +++++++++++++-------------
 drivers/staging/sm750fb/sm750.h        | 14 ++++----
 drivers/staging/sm750fb/sm750_accel.c  | 22 ++++++------
 drivers/staging/sm750fb/sm750_accel.h  | 44 ++++++++++++------------
 drivers/staging/sm750fb/sm750_cursor.c | 43 -----------------------
 drivers/staging/sm750fb/sm750_cursor.h |  2 --
 drivers/staging/sm750fb/sm750_hw.c     | 20 +++++------
 7 files changed, 73 insertions(+), 119 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9a42a08c8..4eb8b226c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char *g_fbmode[2];
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
@@ -467,8 +467,6 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 		fb_set_suspend(info, 0);
 	}
 
-	pdev->dev.power.power_state.event = PM_EVENT_RESUME;
-
 	console_unlock();
 	return 0;
 }
@@ -619,26 +617,26 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_primary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		break;
 	case sm750_simul_sec:
 		output->paths = sm750_pnc;
 		crtc->channel = sm750_secondary;
 		crtc->o_screen = 0;
-		crtc->v_screen = sm750_dev->pvMem;
+		crtc->v_screen = sm750_dev->pv_mem;
 		break;
 	case sm750_dual_normal:
 		if (par->index == 0) {
 			output->paths = sm750_panel;
 			crtc->channel = sm750_primary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
 			/* not consider of padding stuffs for o_screen,need fix */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	case sm750_dual_swap:
@@ -646,7 +644,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			output->paths = sm750_panel;
 			crtc->channel = sm750_secondary;
 			crtc->o_screen = 0;
-			crtc->v_screen = sm750_dev->pvMem;
+			crtc->v_screen = sm750_dev->pv_mem;
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
@@ -654,7 +652,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 			 * need fix
 			 */
 			crtc->o_screen = sm750_dev->vidmem_size >> 1;
-			crtc->v_screen = sm750_dev->pvMem + crtc->o_screen;
+			crtc->v_screen = sm750_dev->pv_mem + crtc->o_screen;
 		}
 		break;
 	default:
@@ -752,13 +750,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->pv_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
 	crtc->cursor.max_w = 64;
 	crtc->cursor.size = crtc->cursor.max_h * crtc->cursor.max_w * 2 / 8;
-	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
+	crtc->cursor.vstart = sm750_dev->pv_mem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
 	if (!g_hwcursor)
@@ -777,15 +775,16 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		else
 			info->fbops = &lynxfb_ops_with_cursor;
 	}
+	const char *mode = g_fbmode[index];
 
-	if (!g_fbmode[index]) {
-		g_fbmode[index] = g_def_fbmode;
-		if (index)
-			g_fbmode[index] = g_fbmode[0];
+	if (!mode) {
+		mode = g_def_fbmode;
+		if (index && g_fbmode[0])
+			mode = g_fbmode[0];
 	}
 
 	for (i = 0; i < 3; i++) {
-		ret = fb_find_mode(var, info, g_fbmode[index],
+		ret = fb_find_mode(var, info, mode,
 				   pdb[i], cdb[i], NULL, 8);
 
 		if (ret == 1 || ret == 2)
@@ -856,9 +855,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.chip_clk = 0;
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
-	sm750_dev->init_parm.powerMode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
-	sm750_dev->init_parm.resetMemory = 1;
+	sm750_dev->init_parm.power_mode = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
+	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
@@ -877,9 +876,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = sm750_double_tft;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = sm750_dual_tft;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
 			sm750_dev->pnltype = sm750_24TFT;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
@@ -1025,7 +1024,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		sm750_dev->mtrr.vram = arch_phys_wc_add(sm750_dev->vidmem_start,
 							sm750_dev->vidmem_size);
 
-	memset_io(sm750_dev->pvMem, 0, sm750_dev->vidmem_size);
+	memset_io(sm750_dev->pv_mem, 0, sm750_dev->vidmem_size);
 
 	pci_set_drvdata(pdev, sm750_dev);
 
@@ -1056,8 +1055,8 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
-	iounmap(sm750_dev->pvMem);
+	iounmap(sm750_dev->pv_reg);
+	iounmap(sm750_dev->pv_mem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
 }
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 67b9bfa23..19dbb9120 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -14,8 +14,8 @@
 
 enum sm750_pnltype {
 	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	sm750_dual_tft = 2,	/* dual 18 bit tft */
+	sm750_double_tft = 1,	/* 36 bit double pixel tft */
 };
 
 /* vga channel is not concerned  */
@@ -39,13 +39,13 @@ enum sm750_path {
 };
 
 struct init_status {
-	ushort powerMode;
+	ushort power_mode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
-	ushort resetMemory;
+	ushort set_all_eng_off;
+	ushort reset_memory;
 };
 
 struct lynx_accel {
@@ -97,8 +97,8 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
-	unsigned char __iomem *pvMem;
+	void __iomem *pv_reg;
+	unsigned char __iomem *pv_mem;
 	/* locks*/
 	spinlock_t slock;
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0f94d859e..4beabe105 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -85,7 +85,7 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt)
 }
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bpp,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop)
 {
@@ -102,14 +102,14 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
 	write_dpr(accel, DE_PITCH,
-		  ((pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		   (pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
+		   (pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr44 */
 
 	write_dpr(accel, DE_FOREGROUND, color); /* DPR14 */
 
@@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sy: Starting y coordinate of source surface
  * @dest_base: Address of destination: offset in frame buffer
  * @dest_pitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -149,7 +149,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dest_base, unsigned int dest_pitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
@@ -249,9 +249,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dest_pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((dest_pitch / bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
-		  (source_pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
+		  (source_pitch / bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
 	/*
 	 * Screen Window width in Pixels.
@@ -259,9 +259,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dest_pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((dest_pitch / bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
+		  (source_pitch / bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
 		return -1;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 2c79cb730..1a4a28c86 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,19 +190,19 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-		      u32 base, u32 pitch, u32 Bpp,
+		      u32 base, u32 pitch, u32 bpp,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop);
 
 /**
- * sm750_hm_copyarea
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * sm750_hw_copyarea
+ * @s_base: Address of source: offset in frame buffer
+ * @s_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @Bpp: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
@@ -210,34 +210,34 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int s_base, unsigned int s_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
-		      unsigned int Bpp, unsigned int dx, unsigned int dy,
+		      unsigned int d_base, unsigned int d_pitch,
+		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
 /**
  * sm750_hw_imageblit
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * @p_srcbuf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *>-----      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @d_base: Address of destination: offset in frame buffer
+ * @d_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @f_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @b_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *p_srcbuf,
+		       u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 f_color, u32 b_color, u32 rop2);
 
 #endif
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 7ede14490..f0338e6e7 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -130,46 +130,3 @@ void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 		}
 	}
 }
-
-void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
-			       const u8 *pcol, const u8 *pmsk)
-{
-	int i, j, count, pitch, offset;
-	u8 color, mask;
-	u16 data;
-	void __iomem *pbuffer, *pstart;
-
-	/*  in byte*/
-	pitch = cursor->w >> 3;
-
-	/* in byte	*/
-	count = pitch * cursor->h;
-
-	/* in byte */
-	offset = cursor->max_w * 2 / 8;
-
-	data = 0;
-	pstart = cursor->vstart;
-	pbuffer = pstart;
-
-	for (i = 0; i < count; i++) {
-		color = *pcol++;
-		mask = *pmsk++;
-		data = 0;
-
-		for (j = 0; j < 8; j++) {
-			if (mask & (1 << j))
-				data |= ((color & (1 << j)) ? 1 : 2) << (j * 2);
-		}
-		iowrite16(data, pbuffer);
-
-		/* assume pitch is 1,2,4,8,...*/
-		if (!(i & (pitch - 1))) {
-			/* need a return */
-			pstart += offset;
-			pbuffer = pstart;
-		} else {
-			pbuffer += sizeof(u16);
-		}
-	}
-}
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index 88fa02f63..51ba0da02 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -10,6 +10,4 @@ void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *data, const u8 *mask);
-void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
-			       const u8 *data, const u8 *mask);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a2798d428..238f3e97f 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -42,18 +42,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->pv_reg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->pv_reg) {
 		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto err_release_region;
 	}
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pv_reg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->pv_reg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->pv_reg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -66,9 +66,9 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->vidmem_size = ddk750_get_vm_size();
 
 	/* reserve the vidmem space of smi adaptor */
-	sm750_dev->pvMem =
+	sm750_dev->pv_mem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
-	if (!sm750_dev->pvMem) {
+	if (!sm750_dev->pv_mem) {
 		dev_err(&pdev->dev, "Map video memory failed\n");
 		ret = -EFAULT;
 		goto err_unmap_reg;
@@ -77,7 +77,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 
 err_unmap_reg:
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->pv_reg);
 err_release_region:
 	pci_release_region(pdev, 1);
 	return ret;
@@ -130,10 +130,10 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		switch (sm750_dev->pnltype) {
 		case sm750_24TFT:
 			break;
-		case sm750_doubleTFT:
+		case sm750_double_tft:
 			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
 			break;
-		case sm750_dualTFT:
+		case sm750_dual_tft:
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
-- 
2.53.0

