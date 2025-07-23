Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176642192F4;
	Wed, 23 Jul 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298778; cv=none; b=s+tWBfc48KAEbaJz1dCzq4ynu9NdU3rmbL/AxnuCakCJJEwhFHOWfQoFbZDwEWC3YoAzmmIVmdnhzGg4d0EDuSFQXFtsyx8ISK+T2aMmy99+NO98ooPPUm0jDica6CknQkXDqol0hSHMwvv3eQIo3XKZR5elriMXy0j7mCZoA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298778; c=relaxed/simple;
	bh=McKtVO0Hih5A9AVjNMHsFSbGO7m6LL6HMnmcX3RYaM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTQLPaQogmTTXge+XPIr4XlPywhriD9eL8+Q4+pqAcGytk8LRT+SiHqxUAGzeARgOfPR0LIxozRKJtViewEYp2Dmc4rUFimL+7MBmWhaQkGLCGX9+POjg30I2dbZyojyeRCiS7l7gMWZeZPgkfdzkbPUeRBk1eYxIZFZcm61juQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hNOs0sMM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hNOs0sMM"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHttM6009436;
	Wed, 23 Jul 2025 19:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=o7Xj0Emi+6jkt4QCvj9ula6o/6JAU
	0YBmQDnMaeeNpc=; b=hNOs0sMMrTU+Awv7bbiaSbGPAmgAN2DpIX786dgjW+YJd
	z/l2Hpntuv7opZs9l/ZMtlKhX55QaUTHTjgrAp/383Nd93R8HCYJA1JiW0Ea8UAI
	c2wdQSILKPmXH2qP1htRGY7HnJxgLCrVEUwYqoILyegdy+uvMo1FRw6+kCsOn3h+
	K9inF5d/0YJNd0dWtJGebg8IbiQwPd8ubQadBB5TKjYRrs/8KshGBg1pr2hfC400
	BODMvYENvNtzmZliHgERgzfXD9kcLIKj77RH+aP9PfCjyjYq+ZRlYSdLEKE1VQpG
	Tn4jdCGU2eY0c9kiiyEXZF12R+6x1R37svAEGSiLQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2g7y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 19:26:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NI0sDe038352;
	Wed, 23 Jul 2025 19:26:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tb12yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 19:26:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56NJQ5rH022657;
	Wed, 23 Jul 2025 19:26:05 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4801tb12y4-1;
	Wed, 23 Jul 2025 19:26:05 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [bug report] staging: sm750fb: Fix polarity assignment for vertical and horizontal mode
Date: Wed, 23 Jul 2025 12:24:31 -0700
Message-ID: <20250723192528.77109-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230164
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=6881374e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=dYcGuau3DC2CDLyDpIsA:9 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: fKMKiYlUq6jK_HTh1oR3XqYkoeo99nBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2NCBTYWx0ZWRfX+Wpp0PUoVB+Q
 82wgPOPJqKBirSki6OxbmI8lbs2GPkjes3x3gNtmFpnb1R0IYdPRyreAkd4Ixrp3Pz+BDiB9SP+
 /MJxMtSFIaEpdRZw6C3u6I26csTYvvo7102uGrZ2szga/STfBvzslldauM6Pp18bQwPWl9+I9qz
 ocR2+FOa5mldwQm4lleEn0VtzJkNc5lu8q+K+7KIvDtqYp7IV1F6EDiWtgb6S1uBUUgG3f370w3
 4pc6TwVvWhMYt/Mme4kJPBfNowtlhKbUXHuViFx97iqtvkHl3x0aT5YTIXo2w9yn60hNEAYqtnE
 zq78H8xuPAWvGgHsMBr8iZ3KfEJ5lCb07ENItTqu6cc9wpe0l3OOoNe26Q4XwBF0b1/vY6j2nr+
 x0yLFmZICH1kvc3gTvViLujLoas4EYa+LSf3Ov0UAXnWq2KzHRhGKTq93JBDuVK+S0q9LwQz
X-Proofpoint-ORIG-GUID: fKMKiYlUq6jK_HTh1oR3XqYkoeo99nBW

In drivers/staging/sm750fb/sm750_hw.c,
the vertical and horizontal sync polarity assignments were incorrectly
ordered. 
The assignment for modparm.vertical_sync_polarity was mistakenly using
the FB_SYNC_HOR_HIGH_ACT bit instead of FB_SYNC_VERT_HIGH_ACT, 
and the horizontal polarity line was commented out or missing.

This patch corrects the logic by properly assigning:

vertical_sync_polarity -> from FB_SYNC_VERT_HIGH_ACT
horizontal_sync_polarity -> from FB_SYNC_HOR_HIGH_ACT

Please let me know your feedback.
Thanks,
Alok
---
Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7119b67efe11b..5a32756f98c31 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -280,9 +280,9 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 	/* set timing */
 	modparm.pixel_clock = ps_to_hz(var->pixclock);
 	modparm.vertical_sync_polarity =
-		(var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS : NEG;
-	modparm.horizontal_sync_polarity =
 		(var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS : NEG;
+	modparm.horizontal_sync_polarity =
+		(var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS : NEG;
 	modparm.clock_phase_polarity =
 		(var->sync & FB_SYNC_COMP_HIGH_ACT) ? POS : NEG;
 	modparm.horizontal_display_end = var->xres;
-- 
2.46.0

