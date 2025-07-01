Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04449620
	for <linux-fbdev@vger.kernel.org>; Tue,  1 Jul 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360890; cv=none; b=FgxT0yFUSdpkyRIimCDXoibBVRSRVK9hzS56m/CFYDogk092ztx/SH3clwW9IWc0JkhV1nwh67PKL0gyqw05r4/dkqFJz4hxGmef+gOiyg2CjJHaoHdYLxKJps0teTfhMLLAq0ljeWOK1wWuW6Uprj121x0lP/qmaRlI83Oqorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360890; c=relaxed/simple;
	bh=P2o52q6EbEVh8ZM8TM+dHm5gV65ky6s4lLFyI2bLC+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUYg6Prb/9TVYdRdb0FqphBF8YpkKdYelI+weVnIRr/D4s5zU01okkt6PW8y8PVm6PvSHdBGek4wb/PhxBRHmtmNm48JVPNEyAyTX/TBgqoqxXgmhiiP3rzLxtobEyp0zpFYhlb/Keil65E5eQm4/7tDcPPEIiH398WMkF6N2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c949aa54565a11f0b29709d653e92f7d-20250701
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f96cf731-ef75-4600-a4ab-4a506829d7fd,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.1.45,REQID:f96cf731-ef75-4600-a4ab-4a506829d7fd,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:6493067,CLOUDID:57dff3ec41b58ee6fd86cdbe338f0e89,BulkI
	D:2507011707182UWYN7BE,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c949aa54565a11f0b29709d653e92f7d-20250701
X-User: zhangyongzhen@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <zhangyongzhen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 299963308; Tue, 01 Jul 2025 17:07:17 +0800
From: Yongzhen Zhang <zhangyongzhen@kylinos.cn>
To: simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>
Subject: [PATCH] fbdev: fix potential buffer overflow in do_register_framebuffer()
Date: Tue,  1 Jul 2025 17:07:04 +0800
Message-Id: <20250701090704.161165-1-zhangyongzhen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation may lead to buffer overflow when:
1.  Unregistration creates NULL gaps in registered_fb[]
2.  All array slots become occupied despite num_registered_fb < FB_MAX
3.  The registration loop exceeds array bounds

Add boundary check to prevent registered_fb[FB_MAX] access.

Signed-off-by: Yongzhen Zhang <zhangyongzhen@kylinos.cn>
---
 drivers/video/fbdev/core/fbmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index dfcf5e4d1d4c..53f1719b1ae1 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -449,6 +449,9 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		if (!registered_fb[i])
 			break;
 
+	if (i >= FB_MAX)
+		return -ENXIO;
+
 	if (!fb_info->modelist.prev || !fb_info->modelist.next)
 		INIT_LIST_HEAD(&fb_info->modelist);
 
-- 
2.25.1

