Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC39311979;
	Sat, 25 Apr 2026 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777100400; cv=none; b=oDFUVyl2MwQynZBPn5cQN0/6CQO178WxXaLnSXUi8+pzdpb1HLAo62YJ9mnni2R5fw8csV7KGQPREkwUzAqQ/yTzqc/PjP1P9q9X1g5pWQ5V/A65gakMRxZEaF8uf+CLULbg3fopsJ7Ars5stQarYwU/HTBksafszMiutpTq0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777100400; c=relaxed/simple;
	bh=mVKLtqOjp35Md2DlbbZ8NQGT91WzJPCsCYTu4dLv+gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5f6ncP6x8sCJwFAO1GxOj+YDsJzNGqQOi+vxO6aXGTbZ7TAYpYct5EB53D0dobmQpxK1BgmMjiSynCHKOjjQ8c8csyz6O+0xf3Q8TUMuAFB80nU3/SccEZocrxWYQPjPAeSvqgz+noLV+7bliuSbY0fGPIEou86VtjsW5rqfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5976835a407411f1aa26b74ffac11d73-20260425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b382d7f5-7ed2-4757-b49b-748a729d1c86,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:feb819b6dc55270ad3a2f05111c21055,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|898,TC:nil,Content:0|15|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5976835a407411f1aa26b74ffac11d73-20260425
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1340601746; Sat, 25 Apr 2026 14:59:48 +0800
From: Ai Chao <aichao@kylinos.cn>
To: deller@gmx.de,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk,
	dilinger@queued.net,
	adaplas@gmail.com,
	James.Bottomley@HansenPartnership.com,
	FlorianSchandinat@gmx.de,
	alchark@gmail.com,
	krzk@kernel.org,
	kees@kernel.org,
	rene@exactco.de,
	tzimmermann@suse.de,
	rongqianfeng@vivo.com,
	thorsten.blum@linux.dev,
	chelsyratnawat2001@gmail.com,
	soci@c64.rulez.org,
	gregkh@linuxfoundation.org,
	daniel@thingy.jp,
	linmq006@gmail.com,
	fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-geode@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of strcpy()
Date: Sat, 25 Apr 2026 14:58:54 +0800
Message-Id: <20260425065926.1091168-4-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425065926.1091168-1-aichao@kylinos.cn>
References: <20260425065926.1091168-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a safer function strscpy() instead of strcpy() for copying to arrays.

Only idiomatic code replacement, and no functional changes.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/video/fbdev/sis/sis_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 84567d67f71d..e87fa261f76c 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -205,7 +205,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 	}
 
 	if(strlen(name) <= 19) {
-		strcpy(strbuf1, name);
+		strscpy(strbuf1, name);
 		for(i = 0; i < strlen(strbuf1); i++) {
 			if(strbuf1[i] < '0' || strbuf1[i] > '9') strbuf1[i] = ' ';
 		}
@@ -5947,33 +5947,33 @@ static int sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_FB_SIS_300
 		case PCI_DEVICE_ID_SI_730:
 			ivideo->chip = SIS_730;
-			strcpy(ivideo->myid, "SiS 730");
+			strscpy(ivideo->myid, "SiS 730");
 			break;
 #endif
 #ifdef CONFIG_FB_SIS_315
 		case PCI_DEVICE_ID_SI_651:
 			/* ivideo->chip is ok */
-			strcpy(ivideo->myid, "SiS 651");
+			strscpy(ivideo->myid, "SiS 651");
 			break;
 		case PCI_DEVICE_ID_SI_740:
 			ivideo->chip = SIS_740;
-			strcpy(ivideo->myid, "SiS 740");
+			strscpy(ivideo->myid, "SiS 740");
 			break;
 		case PCI_DEVICE_ID_SI_661:
 			ivideo->chip = SIS_661;
-			strcpy(ivideo->myid, "SiS 661");
+			strscpy(ivideo->myid, "SiS 661");
 			break;
 		case PCI_DEVICE_ID_SI_741:
 			ivideo->chip = SIS_741;
-			strcpy(ivideo->myid, "SiS 741");
+			strscpy(ivideo->myid, "SiS 741");
 			break;
 		case PCI_DEVICE_ID_SI_760:
 			ivideo->chip = SIS_760;
-			strcpy(ivideo->myid, "SiS 760");
+			strscpy(ivideo->myid, "SiS 760");
 			break;
 		case PCI_DEVICE_ID_SI_761:
 			ivideo->chip = SIS_761;
-			strcpy(ivideo->myid, "SiS 761");
+			strscpy(ivideo->myid, "SiS 761");
 			break;
 #endif
 		default:
-- 
2.34.1

