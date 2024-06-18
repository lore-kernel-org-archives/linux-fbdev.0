Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F131D9503;
	Tue, 18 Jun 2024 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679949; cv=none; b=SydBK8K/8aK1gW2fP+0B8QPtfmRzflfEEiy3BBvx3Fq8Z86RhgFrD6AejW53KQ0DxWXo0dJKDtdSh/Ls+KG0teldiL27lNmKJUG7x8GI7j91VunXgBELrf3GWYddKxHXZj/D1ST7xNLTlNtYx9gMYtgduEHIKi1j/GQQqlQfj04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679949; c=relaxed/simple;
	bh=wqaRb/ffQ5ja8hTBgOEZSU6S7qx/PMYJo8vL5whcAVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fMJ2oXwK4WNQbhYD01+nHlLrtylGrE/eOCAOA7kFQaGrKTZhdlPfeCGHIdHVP0aYncbZENcoKIeKOFi+v9nP/xSsxfVHWsXnx03uLV0s4XV4VertKmLCyI9nScTA+zS7OiV1EIPQHbqUndKXrwoSiRomqYygEk8SncvGPMjHi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nQvCLbRA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nQvCLbRA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I2JK0Y002594;
	Tue, 18 Jun 2024 03:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RXbcKcpqHxI08Uyn5ghejP
	JXsd+NYiyRlWEwV68XMNY=; b=nQvCLbRA0fXoMsobVD06narvkjbr9iyevPbpcG
	A9kBdj+14z5SSSslSJ334r0a80+ubAOedYOFF6V9F8OjiH6zwejVyco9X3re0q5I
	Ifr8Zr7tDuPGrWcErAFTuElcuLHrzttuOl2B+Ke4BN/R2bnQpgnc6Ynfd+r2XEYV
	m9DXkAGELiwvL3Tm+xWGw4dF6xwsOQtQRfi0D8tyfm6nDM+d0Y440+Oe3HFmg7qF
	Zd/BZfug3kbH4DjwpKsMIxKiKdqw2xKusn9vXDbfBnSo9/I8k71/VWwJByy54mSK
	8miHVRT9ClvVr7d5VyNp/zmWErQfqaNoVWfElAaC3z9L4VtQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu1b0r2m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 03:05:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I35ajf026477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 03:05:36 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 20:05:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 20:05:34 -0700
Subject: [PATCH] fbdev: c2p_planar: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-drivers-video-fbdev-c2p_planar-v1-1-8262753bb4e8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAH35cGYC/x3NQQ6CMBBA0auQWTtJqYLEqxhipu0gE6GQqTYkh
 LtbXb7N/zskVuEEt2oH5SxJllhQnyrwI8Uno4RisMZeTFtfcQ44t90Lg0pmTZgl8IKDC5zR2/W
 xThRJsanPxpBvms5YKLFVeZDtP7r3xY4So1OKfvzlJ4mfDWdKb1Y4ji/aO+g5lwAAAA==
To: Helge Deller <deller@gmx.de>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BMXs7cZC25eQtLHx2qOpvk9rRR2Q7ech
X-Proofpoint-ORIG-GUID: BMXs7cZC25eQtLHx2qOpvk9rRR2Q7ech
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=997 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180023

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/c2p_planar.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/video/fbdev/c2p_planar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/c2p_planar.c b/drivers/video/fbdev/c2p_planar.c
index ec7ac8526f06..22c8c1b6db60 100644
--- a/drivers/video/fbdev/c2p_planar.c
+++ b/drivers/video/fbdev/c2p_planar.c
@@ -153,4 +153,5 @@ void c2p_planar(void *dst, const void *src, u32 dx, u32 dy, u32 width,
 }
 EXPORT_SYMBOL_GPL(c2p_planar);
 
+MODULE_DESCRIPTION("Fast C2P (Chunky-to-Planar) Conversion");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240617-md-m68k-drivers-video-fbdev-c2p_planar-51300ac55802

