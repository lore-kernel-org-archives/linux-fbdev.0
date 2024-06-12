Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821B18622;
	Wed, 12 Jun 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206350; cv=none; b=nPJNj3yhUZzLYBwlR3xsAlZY6YQPCWTb3d59i9qoDFBJ/eVLSsezPhRGFj+XNmGedRuUi3VA6w3JmJdXrR0LZ1qwrda7Aq9z7f/1Wl5BN+zPp2OprW/fqo9LsuirNX+meV7w5Dgo553WPWtTrzWRkb3LzSRyObXYfvhm8G07fXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206350; c=relaxed/simple;
	bh=F+6SWx5dI1I9dsDuGM8Nmb5hE25KXgto7Lw0GkbxFPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=muGPA5MrNSYcY60hsINnloQDoVpzIan+PnjWUP2GifgIqT+2DcNGTS12Ws7GqtrrmPDoqIpycnpjG+Ex4GgchwWhXkY968/Z3IxHaRUpIkcyjaq09XXqMhm1Uii8TT3Ya+dkCev9gC7hfVSe4E+Br+Mm6VSKPLfS6/O+ku7aYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hm+p7i99; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hm+p7i99"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CAbPEr002327;
	Wed, 12 Jun 2024 15:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FCegkFHVBMrsBjwQBG8Wpk
	ylVo51bMD1m3qO3Axj88k=; b=Hm+p7i99wxO7c6b0+BZglF0iBwgQVzbvgrz0R7
	6E9+Ti1N9Qku9A1q970Kk1Y5NMd35U//Ruc826G3LIVAIkiqySxVhaA0Tgn1veW6
	Mb6L+uOod5YWbuKsXP3oytifrYFSQyYIU2e9fuZ8LBE7RalUmaR88x3P0Uzm7SbM
	eA3Qgwk3Ywmrfq5srWCPRHMQhUhvsuLP4g2Z5PAfEtuxV5hQdHbCo71YFQbfyYPL
	m2RRLYXEuElqPRxkS/bZnVlRdClsnlbccakXjULmLcWka0i6HKnW5Re/NZfxc9pU
	Df2dCGassUfW2k6y9FYM+sSL+N5kmDisr2v3L/uTwgRHlWog==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yq4s8hrgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:32:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CFWNwx018537
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:32:23 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 08:32:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 08:32:22 -0700
Subject: [PATCH] fbdev: matroxfb: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-drivers-video-fbdev-matrox-v1-1-999fb28b9793@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIW/aWYC/x3MSwrDMAwA0asErStIjOnvKqUL2VYaQeMUKTGGk
 LvX7fItZnYwVmGDe7eDchGTJTcMpw7iRPnFKKkZXO98fx4czgmTSmE1LJJ4wTEkLjjTqktF7zl
 6dyW6XQja46M8Sv3/H8/mQMYYlHKcfte35K221lZWOI4vkPv81Y4AAAA=
To: Helge Deller <deller@gmx.de>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 06GydcilGYjpQx-TVQJgngG2Wmsx9Ngx
X-Proofpoint-ORIG-GUID: 06GydcilGYjpQx-TVQJgngG2Wmsx9Ngx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=969 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120111

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/matrox/matroxfb_accel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/matrox/matroxfb_DAC1064.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/matrox/matroxfb_Ti3026.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Corrections to these descriptions are welcomed. While doing these
cleanups treewide, in most cases I've taken these descriptions
directly from code comments, Kconfig descriptions, or git logs.
However in this directory many of the files have duplicate
descriptions and the Kconfigs have none, so I winged it based upon
eyeballing the code and looking at the existing MODULE_DESCRIPTION()s
---
 drivers/video/fbdev/matrox/matroxfb_DAC1064.c | 1 +
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c  | 1 +
 drivers/video/fbdev/matrox/matroxfb_accel.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
index 765e805d14e3..398b7035f5a9 100644
--- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
+++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
@@ -1111,4 +1111,5 @@ EXPORT_SYMBOL(matrox_G100);
 EXPORT_SYMBOL(DAC1064_global_init);
 EXPORT_SYMBOL(DAC1064_global_restore);
 #endif
+MODULE_DESCRIPTION("Matrox Mystique/G100 output driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
index 5617c014da87..f53b8066e8a5 100644
--- a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
+++ b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
@@ -746,4 +746,5 @@ struct matrox_switch matrox_millennium = {
 };
 EXPORT_SYMBOL(matrox_millennium);
 #endif
+MODULE_DESCRIPTION("Matrox Millennium output driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/matrox/matroxfb_accel.c b/drivers/video/fbdev/matrox/matroxfb_accel.c
index ce51227798a1..52e15dc6f45b 100644
--- a/drivers/video/fbdev/matrox/matroxfb_accel.c
+++ b/drivers/video/fbdev/matrox/matroxfb_accel.c
@@ -517,4 +517,5 @@ static void matroxfb_imageblit(struct fb_info* info, const struct fb_image* imag
 	}
 }
 
+MODULE_DESCRIPTION("Accelerated fbops for Matrox Millennium/Mystique/G100/G200/G400/G450/G550");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-drivers-video-fbdev-matrox-44ec428aa97a

