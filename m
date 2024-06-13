Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396B182D2;
	Thu, 13 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244005; cv=none; b=OIinsPfoX41pYY/7rrKewvTEqOFoi1DTjx6hVjH9e2H0LVobGVM6FrWLqDPmtOFgl6zldGsZh+6qI2I2MgV6P2U0AYIB6m9QSvyIKHbpofMt7HtTR+fLZjbB5x4G94a54Il6fepTDi0MN23yn9GGtbFEJluovNDqm1DJEd0ggw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244005; c=relaxed/simple;
	bh=yPI4anQmIzp5Hqu3yjzsH0vAKTfQCcNRUR8rQj1j10U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Gi/tHKDr9WhTS2tKI912DZLfdwx+nySaTRf40s4BO0axPl7PQ7vuJQECII6y/RVhYJwaiqtNqEf1BwjbuV1CCIlJ5lzyCoPyUf4Sn3XJ2svWvWfkMln98+dQfLtWCRuHxiWvdiOsiVG2ezAdhD9FioFxjD3BIXHYVZyYOc3Vj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Njn2okIA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Njn2okIA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKo5ci025773;
	Thu, 13 Jun 2024 01:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nKH5Tok5u20aWE4SpbitkC
	QG6pnQwp2V3arDCsYmjKI=; b=Njn2okIAMGm207QoFYL9fSrv0kGe1pPgYiue4E
	B40HEqBu7JcFNhGxWZrZshkVztFb4R0jhqPz9dRCtMup7d1qmH99HtmoKk2tD6sx
	90ZVPApZN2Ut4ua7TVEk91HRtzzoAqZNRxDyD1XzH9w1alubHrlonN8TfKDSoQxL
	t1xo7TIZDeDI67+af67oMooXOWcciKbXEzZmnRxYstvCyMC1pPmltW4NnQjei8AR
	1KECcL0NDjFkNHeENoaZ3SrevO4xNMpzm5fmwNXWr7OetHTZ3zcEZldZmEgSIFkZ
	gyfTDXsjzy+l0U1cbZrhRiJo13eooiAx3+ZsvzngP9ntwlGA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqcxthmr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 01:59:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D1xvu9015939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 01:59:57 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 18:59:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 18:59:53 -0700
Subject: [PATCH] video: macmodes: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-drivers-video-fbdev-macmodes-v1-1-17514b2a6e71@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJhSamYC/x3NywoCMQyF4VcZsjbQBi/gq4iLXjJOwLaSaBkY5
 t2tLr/F+c8GxipscJ02UO5i0uqAP0yQllAfjJKHgRwd3dkTloxZpbMadsnccI6ZO5aQSstseAn
 +FCmSi55gVF7Ks6z/h9t9OAZjjBpqWn7dp9TPOtb2ZoV9/wJd/bnfkAAAAA==
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
X-Proofpoint-ORIG-GUID: rOO_uOcTAaSg6ChrQB6M6W-nlW7y-5RD
X-Proofpoint-GUID: rOO_uOcTAaSg6ChrQB6M6W-nlW7y-5RD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=987 spamscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130011

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/macmodes.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/video/fbdev/macmodes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/macmodes.c b/drivers/video/fbdev/macmodes.c
index af86c081d2be..d6be3c67d3df 100644
--- a/drivers/video/fbdev/macmodes.c
+++ b/drivers/video/fbdev/macmodes.c
@@ -411,4 +411,5 @@ int mac_find_mode(struct fb_var_screeninfo *var, struct fb_info *info,
 }
 EXPORT_SYMBOL(mac_find_mode);
 
+MODULE_DESCRIPTION("MacOS video mode library");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-drivers-video-fbdev-macmodes-7a15b2b20b12

