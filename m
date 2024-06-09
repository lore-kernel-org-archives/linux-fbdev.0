Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554306AD7;
	Sun,  9 Jun 2024 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717903318; cv=none; b=G4N1ivquO5iRMX6Sg2gk2444T3jw0lAZSt4zO2v1l3L41d6G1HlR9DxltCu7j2bvyd3bEtCkg6dnsVPhVhIza0QsP3ZtmvVzd8OtQ9zC+GjEvW/jfjD9CSiUw66hwhPt0WODqEkvqLsguarXT8+6Fyf1oiOIq8Am1ViiYhQ7c7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717903318; c=relaxed/simple;
	bh=EBGRtj7zQzYPIy/+jytfOcQ7ZHPCa8Nvz/jM3VzXZtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=AmWQ+FCSuV+2T6eQ4NRKM98XY1PRIJVDsDT29x2FDWRjV7tfibyDAKg95vISozlACCppdylawsU6+QvFtQ0kKOzBcK1Bu/H3s9O+IklRZgqDbjRpQEJEw2rtiw0Q8cb6rMDiC21k/AytBHuUht38Ods9tM/nTxCIe9dbYRHFtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jjShpw3V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jjShpw3V"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4592tca9017723;
	Sun, 9 Jun 2024 03:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ttBDnNrJ1VtoKayVqkZENq
	mRz4BVnQPpqHRLUfpOiz4=; b=jjShpw3VEbwasdlm4drFhBVRszGlVEShbFd+bR
	UaD1Tqw/0Avp1Mp3iAB7Avmi320EG39jUsjON7FTy2zCeYQNZUKc4Z4ZswK1BE3Q
	kW+vHBJz9z4uwlWVsaLqMc8XuZeiwwLU5b2z6OgbUxIy9IdN27lNvxjOUw7i+M/w
	OGFazQhzy1FaxxC7MNO34XXEGYEMGz5RRd1EECB2AQ2FHMHdpU97L3sFZw02RM/V
	oLJT0CcpFAjW8rMz23cy5JXzmgpfoM8rbVfBI1eNs1DF3xz4QFeSxvU5tLw6Y375
	CENAWc9CSFogMLkdAUKRCUsCjVouzDBH43fjv2twxqtkDQhw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmscxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 03:21:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4593LpTi017650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 03:21:51 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 8 Jun 2024
 20:21:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 8 Jun 2024 20:21:47 -0700
Subject: [PATCH] staging: fbtft: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240608-md-drivers-staging-fbtft-v1-1-e2ab70ec0614@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMofZWYC/x3MTQrCQAxA4auUrA3Esah4FXExP5lpwI6SjKVQe
 ndHl9/ivQ2MVdjgNmygvIjJq3YcDwPEydfCKKkbHLmRznTFOWFSWVgNrfkitWAOLTcMFzdm8hT
 5RNDzt3KW9b++P7qDN8agvsbpN3xK/aw4e2ussO9f47ZdeYkAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xriwx20r_k3tyIc2PdBzYDtUn9HkFHRL
X-Proofpoint-ORIG-GUID: Xriwx20r_k3tyIc2PdBzYDtUn9HkFHRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090025

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/fbtft/fbtft.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/staging/fbtft/fbtft-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index c8d52c63d79f..8e2fd0c0fee2 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1276,4 +1276,5 @@ void fbtft_remove_common(struct device *dev, struct fb_info *info)
 }
 EXPORT_SYMBOL(fbtft_remove_common);
 
+MODULE_DESCRIPTION("Core FB support for small TFT LCD display modules");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240608-md-drivers-staging-fbtft-b724f0a0ce30

