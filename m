Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8E5733E;
	Mon, 17 Aug 2026 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786936708; cv=none; b=JCvmzlN3TovU5r1zY+79IKTJZessec7ZwSk5ZIlVoCVcGAsWNCwadNKhzt68fama00u3TZTV8jA0hlvvDvYi5KQ524IbGwkD0qzRjoyZB3zYzNv0W5Zp0kvbFDilPlfhbyrd7I/Xk6vEYqy/xhMjnngZJS9Zo0Q7n9R7foKLwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786936708; c=relaxed/simple;
	bh=oy3/RMw1Xq/AgRdJNrtnDS1N3ozCn6zmQvIhwBZ3F08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctLtwkvmgPXuMpqamDLHMTvolyTD0MEtvEvZw9tX9Ujk9qZXqrpsSQVWaEJ8Al3S/BLxqUqyrLcfcuI2vA32m1P4X9cNdYLB0f9B0t83cBHiLms2SOouSPFmYNdJ/R598RDlvkVEV62aMjzHimloFzQqONDJiD4c7hY1ilvMsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4b5bc58a99ea11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:104961e3-349c-4307-a96b-f96aabf0ba04,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:aac34e38859da426d09d3d5b0d3ccbd8,BulkI
	D:nil,BulkQuantity:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4b5bc58a99ea11f19a56ed5b684f684d-20260817
X-User: yuebingkun@kylinos.cn
Received: from tushenkeke2-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yuebingkun@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 964093421; Mon, 17 Aug 2026 11:18:19 +0800
From: yuebingkun <yuebingkun@kylinos.cn>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	yuebingkun <yuebingkun@kylinos.cn>
Subject: [PATCH] fbdev: platinumfb: replace strcpy with strscpy
Date: Mon, 17 Aug 2026 11:18:16 +0800
Message-ID: <20260817031816.188833-1-yuebingkun@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy() is deprecated for use on fixed-size buffers. Replace it with
strscpy() to avoid potential buffer overflow issues.

Found by checkpatch.pl:
WARNING: Prefer strscpy over strcpy

Signed-off-by: yuebingkun <yuebingkun@kylinos.cn>
---
 drivers/video/fbdev/platinumfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index a08d955d9b43..fa27a3a4f05b 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -320,7 +320,7 @@ static void platinum_init_info(struct fb_info *info,
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* Fill fix common fields */
-	strcpy(info->fix.id, "platinum");
+	strscpy(info->fix.id, "platinum", sizeof(info->fix.id));
 	info->fix.mmio_start = pinfo->platinum_regs_phys;
 	info->fix.mmio_len = 0x1000;
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
-- 
2.43.0

