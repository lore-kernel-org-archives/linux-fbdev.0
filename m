Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115378F66;
	Sat, 22 Jun 2024 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719036523; cv=none; b=lyFfZDYYlipiPDWoOZsb21X9vc244l92WCAdQ65UfAxvIeRcYVNbOWO2lbyX17Bw9zAkpyFa5bGLa3pzEtSaFJHf/P2ctugdEjhk34aPeGu0l659QGt2LxjbMbCtD56+cwskrx52Kr1xnd/6+QMdJKAi+sfBqAlCsVpM2QW0DCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719036523; c=relaxed/simple;
	bh=CJtGZD0qyJmOJJcA++gnHZH7pKx1npO2xEmUPNgp2aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Xex2/xccQ6B6BA2XEiG/qSMdrz14ZNFaM7Ier6+4utMneJH/UO3abZedgg1v6pxeAyo7Tco3RCgS0dszXevmUPxLCazaR4viKRfmOYW19P4y318zOZD0hxw3uSeg88uOtEwBk8ZXTtccFhEmZfitAAYXYL4yYDuKGEN1Dkhk5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XT3TB86M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XT3TB86M"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M5SWEf002446;
	Sat, 22 Jun 2024 06:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4DOpCP6v34tkQiAYPWWxO8
	vf2dN+pE80vO+Ofs4Q35Q=; b=XT3TB86M1pM8bHt+bJ6yDhFY958vf8kwPBRYbr
	49VcJmOar05dJKIMnb9HRmrYsJmn4RjJ4vEh6o0ge6bU+CzTV0RC/wBemmedf3/7
	9prIquB+e4j/u0UrBvBzEb6Nvqbld4YpcHfGPClruKU5XvKI5GqEwbRkdPcZdVd9
	G0PgCNMcuq2JJd24Oj67UFtfv4Hi8xtPict7woyQNX/izzM45UPz59SaM/9w09Pb
	cOqBsb7AdyjKvy0wAtDeB26tNoSqGGmU5YgkhtWXtAGYXfUgyeeahjbN1fhZhjB6
	ixhJ/PASEro2bZFRZZTayjFgAnhZxDu2T0sa/yspzDeEBv1A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywp6yg5qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 06:08:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45M68RXF002250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Jun 2024 06:08:27 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 23:08:27 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 21 Jun 2024 23:07:06 -0700
Subject: [PATCH] tty: vt: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240621-md-i386-drivers-video-console-v1-1-e533652b7ebb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAlqdmYC/x3MSwrCMBAA0KuUWTuQxhKtVxEX+Yx2oE1kRkOh9
 O6NLt/mbaAkTAq3bgOhysolN/SnDuLk84uQUzNYYwfjbI9LQj5fHSbhSqJYOVHBWLKWmdCTHW0
 0YwjuAu14Cz15/f/3R3PwShjE5zj91pnzd8XF64cE9v0AH0s1J44AAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller
	<deller@gmx.de>,
        "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>
CC: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KH3-1eclgbvNZDHmDvuL8Gvd3fAAVcSI
X-Proofpoint-ORIG-GUID: KH3-1eclgbvNZDHmDvuL8Gvd3fAAVcSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_03,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406220037

With ARCH=i386, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/console/mdacon.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().

This includes three other files which, although they did not produce a
warning with the i386 allmodconfig configuration, may cause this
warning with other configurations.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/video/console/mdacon.c      | 1 +
 drivers/video/console/newport_con.c | 1 +
 drivers/video/console/sticon.c      | 1 +
 drivers/video/console/vgacon.c      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index c0e1f4554a44..d52cd99cd18b 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -561,5 +561,6 @@ static void __exit mda_console_exit(void)
 module_init(mda_console_init);
 module_exit(mda_console_exit);
 
+MODULE_DESCRIPTION("MDA based console driver");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index a51cfc1d560e..242415366074 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -744,4 +744,5 @@ static struct gio_driver newport_driver = {
 };
 module_driver(newport_driver, gio_register_driver, gio_unregister_driver);
 
+MODULE_DESCRIPTION("SGI Newport console driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 4c7b4959a1aa..f1f3ee8e5e8a 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -391,4 +391,5 @@ static int __init sticonsole_init(void)
 }
 
 module_init(sticonsole_init);
+MODULE_DESCRIPTION("HP STI console driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7597f04b0dc7..37bd18730fe0 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1222,4 +1222,5 @@ void vgacon_register_screen(struct screen_info *si)
 	vga_si = si;
 }
 
+MODULE_DESCRIPTION("VGA based console driver");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240621-md-i386-drivers-video-console-ae292c09bb67

