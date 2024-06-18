Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA31DFEB;
	Tue, 18 Jun 2024 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680450; cv=none; b=pjC5ey9xoIU8oztO2NWWOtfsJztdbVF9Sd2jukA8IRq2f6u9SfyfSl7zz2cJrUr/kapA5fLzZUywfWNPJc9Vt/JlWC0TBAzoL4A+C0futTQs60qVM7op9W8O2F49hlgl3Fzs73T6fOM7br/15y/3O2bZM22z8uulq7FjXQbmcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680450; c=relaxed/simple;
	bh=ZzTCxu7koRB+Nmw6IKwYOl0SXXNWsr4vN6+VsDuP8qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=DU9AtUCLCvzo4w36bWSlR47EIkFPYITqNhF8ojxEh0yYygtH+lKdzLDqza0T7RS51ApcZTvEsmWYH2Nyr8fMBNtxgHLhv/aHun4s210eAPXVBhZy+CPMJdsCkxc3aoQVGUzVrd99pF/TQ5/GHsyAtWSPIKNhxMjH83TcxZCHFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KjG1+4nY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KjG1+4nY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I2IP0o001468;
	Tue, 18 Jun 2024 03:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hV4bY1WLsZBbZpKik4z+Bk
	QCIpEuzxZQpIxUKWtFThM=; b=KjG1+4nY1qCTmu84q9rMi9tDmbAkMxzzmUtB8l
	eV4CXPjliiq3PADo948CmcNG1YLxtdDZzeT4twAWaeFUu7eVX72LxhzjR/Bw/8bg
	y9PKdB8mVO5CAnZ2RAY6K3laguK1RusYyD2xXPRSUwdh1i+gQjrODDRCvSDRCK6Y
	SpMT0ZJR49WwhRF9hnHF/6QasOzQB3D6cJeoSRLWuMAlrg5uFwM4lR5fp1Tx0+/m
	4dKbQco7cMgmGpE91SosxN3YdAKSseAM8SOezmwUcDetjH8NHgGGXnVYG7XxTPt5
	ooYtBSqxJel1s6PPCZkrGOQ3R7ndyaRYxF1SqID+nRnlKyKA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu1b0r30m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 03:14:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I3E4K2016277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 03:14:04 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 20:14:04 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 20:14:03 -0700
Subject: [PATCH] fbdev: amifb: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-drivers-video-fbdev-amifb-v1-1-85f74746ecd4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHr7cGYC/x3NwQ6CMAyA4VchPdsEFIf6KsbDRjtpdMO0upAQ3
 t3p8bv8/wrGKmxwaVZQLmIy54pu18A4+XxnFKqGfbvvW9cNmAiTOz2QVAqrYRHiGWMgLuiTxIC
 H6I7Ue8c0nKF2XspRlv/jeqsO3hiD+jxOv/JT8mfB5O3NCtv2BT2dsdOSAAAA
To: Helge Deller <deller@gmx.de>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 01GJ4uB8IPy56o-tuKQMdxV49UW0nG3D
X-Proofpoint-ORIG-GUID: 01GJ4uB8IPy56o-tuKQMdxV49UW0nG3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180023

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/amifb.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/video/fbdev/amifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
index 305f396c764c..132638240521 100644
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -3782,5 +3782,6 @@ static struct platform_driver amifb_driver __refdata = {
 
 module_platform_driver_probe(amifb_driver, amifb_probe);
 
+MODULE_DESCRIPTION("Amiga builtin chipset frame buffer driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:amiga-video");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240617-md-m68k-drivers-video-fbdev-amifb-3f65d4a6ed79

