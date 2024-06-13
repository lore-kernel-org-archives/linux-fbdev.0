Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00920823BC;
	Thu, 13 Jun 2024 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246687; cv=none; b=if4wF6IgJgHesz/upWm7aRur68bhGCWPWQbx/f06c4VzbISGpDkIzUIi860hymtNaMunZnT0bCIR4wDowSmMRW+Gw448IAHKMpsZD5LeYA+nGlcuLiT9RMXWkviSb7yhKOdLp/x16xAMJFtrogk7YJp5ipYcjYVH81OZzZPDH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246687; c=relaxed/simple;
	bh=fZoqlUS7zIdO0rV0aaEg7681f/6m46FSXkbiYVFyVvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=YitKBB6lgYZ8Tw7WFBXPhNaWZiHqIExNx4nOy+9bpdbAvjTLMhe9gDQ2mgEGgeVnh0tjXLNw4f04G986Sz/SCzBOOOQSqDCNMAXSD00IoagHaKvWHm1MXAid6I2mLcMA9dP/7av5+UCOxZKKSEJcOHa6wmwZVPN65CViCBT5I0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AHQG0OdT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AHQG0OdT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKn7d8023706;
	Thu, 13 Jun 2024 02:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MLUQVv5YitGo0zW8uQZYib
	B8MNXu4CEZdiNI/YNSwEM=; b=AHQG0OdT3N+niUMgUlKRgxNlOgb6pCnAmkPhTy
	vsc4mN9jw+TEYN14NIEntgXS4pdFZID5OzIEqOkERHCfg6JMT6hvpYfbg0rwmF+s
	m6k26my46JJQT2liANl36aZHNbpTAwVi7yNnK/0pcONnvTnmEbjRcN4Mb/wF2x11
	vfI6nJ6u+oDE39CPpjxeuqQKEchiiTjJCRezyHJs/hT/q7u00qmXMPNG/tvp3Lww
	IaVe6/eW17Ua+gw47JoefTySfiS6EKXZ1GIMBYCQSeKmfimRLero6m0Au7gGadYD
	weshPVf8C848qT5hSb76tikINiNZ2dahL4MsqCQwT0l+Omeg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqcxthq1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 02:44:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D2ieY2010652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 02:44:40 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 19:44:39 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 19:44:37 -0700
Subject: [PATCH] fbdev: vfb: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-drivers-video-fbdev-vfb-v1-1-9bcbc286aac4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABRdamYC/x3MwQrCMAwA0F8ZORto5xjFXxEP7ZK6gOskcWUw9
 u9Wj+/yDjBWYYNbd4ByFZO1NPhLB9Mcy5NRqBl61w9u9D0uhKRSWQ2rEK+YE3HFmhPGgekaXOA
 wemjBWznL/s/vj+YUjTFpLNP8K19Sth2XaB9WOM8vQjqn94sAAAA=
To: Helge Deller <deller@gmx.de>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L1LlZP-qatQCw90_FrksOqPXGtbPMOHz
X-Proofpoint-GUID: L1LlZP-qatQCw90_FrksOqPXGtbPMOHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=923 spamscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130016

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/vfb.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/video/fbdev/vfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index f86149ba3835..158e48385c24 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -546,5 +546,6 @@ static void __exit vfb_exit(void)
 
 module_exit(vfb_exit);
 
+MODULE_DESCRIPTION("Virtual Frame Buffer driver");
 MODULE_LICENSE("GPL");
 #endif				/* MODULE */

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-drivers-video-fbdev-vfb-a4ed3808e861

