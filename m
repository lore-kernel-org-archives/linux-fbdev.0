Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A34E80B0
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409167; cv=none; b=sHSQvk39wfmzQUizrZIIhq5M9o57Fy/DJ4fAMMCdfWSNqv01qvKdPQ5nyVnocEjxdsJEkfHNs1/PYvevHcP16hbj0xa5XB8XrtWmodSzPA8BK4qv2apSn8imvuBViO1uj33YI5ekJ4XttX6cbrE7AUF9kXr7nJpZ53wmJIlmHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409167; c=relaxed/simple;
	bh=fVg/LqWPANTqKF7KNueIvmrARSubsC7bReSSRU//4iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LS/VmLvuRKNOXSYI6ZKARw/fynqJBhkS+wSXMPkaI3kJhJpz4FY2eTleV6rlWD8hPjb7pxlJ/LTpWGjvQCpVc7VjT9ZXubuxM/eZUb2EZGyNNcjCibyauU/UVxhv7BkVC7iz0f0cvnp9sxbExnt9QveRNW9SZ/jMUGG/eQ+ogjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YyUSZdaT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3IVviqK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YyUSZdaT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3IVviqK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Orfp1167946
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yPMMfZDn11I3cxy+PCPInZld7lO9Yjp1O5vaWsUU9NA=; b=YyUSZdaTdyXrzYqN
	axLrQSn43vtcqM5b4kFFAHvZD/CjYT5CKVfMx7fhJIHWefJihDmknfskp0sczXei
	Rz6BxUT0BYoicFfZxqGJIvQ4cNkBIOEjlWOUQ74nzB43P/YKPfsB2YRhoulPX+kk
	fmaDWouuaaSYZSLswwY8RKXGZC7Al06sLxqmazIZgmEVEDYz3XsVmO35+HfjAQzn
	U4ysZhq7gUvuHRKZidf2awQzE0/MQmJWAPcdix7UfrF/ueRKufxnu5jRD9vC0a8P
	0qPysnrbsM1TR79iJE4blD6OA/1xz78+ltTtIR9+caE5OydbwV801gUuOZpi2XbG
	nhYlUA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8tgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb98809caso313257985a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409157; x=1793013957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPMMfZDn11I3cxy+PCPInZld7lO9Yjp1O5vaWsUU9NA=;
        b=C3IVviqK06ewyjWPyCJ9x3/zlunmC8CP62FTNzH4SeW/XuSllaDf0OYtxUWvSBaLrb
         mDUo5iVcy9EUDEH848zkMSYMlgEBD4jo3p3XnDGw3042DSPoLe6/aSlDl9TnNiW8UFkG
         CdKS5Z7A48WgRsXQyuhiS1d0JsWWnydnG6cpWDWGM8GdW6YQl8x7KAn/0z9fvzYjX1JO
         hlrDZ9nbPuk+5DnS0Qm/N/E/NLgHbfLHgQIqcSo2DxIpuw1T5mwOhQOvO2g9sbdkHmnq
         mhOMcoWCRApALxLCU8gQU1G6K1+4HJfx8pvjjNkF3eMpNyZFeSR/oaBs6F2KhzEE+9zt
         e4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409157; x=1793013957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPMMfZDn11I3cxy+PCPInZld7lO9Yjp1O5vaWsUU9NA=;
        b=ZT7r60BxY4jfqShdZXebv6jGrkePYvjIplzLITLJ0BDbqVDAKgVz8MwG6UMe0G60em
         L0augBF0HRlxjAm4DFdwYbUVtlebCDooWFv4hHMbHU8x8p83T9x50vVixobBxq/4Yy+S
         gWgZTm3PudHbdU6/VLPE4CO/iLnjIMUXkb4lisfdP49MGBxbCqaus2IoGg65wUbbwvM7
         dafBT0qQ+w6ylEphDJ7+dpwqPDuCIzpungjYupxV1kRjrbtbRqOUDGq5GEvhmPV1EaCw
         Dq1wvKuAOzbA18Xyxfk5Gydzv3m8DdmseqeyBQnlmirNi0uE8XBIOhGIE9wll2hfj9iD
         lkYw==
X-Forwarded-Encrypted: i=1; AKwUvBzNuk/EJ0sUeBOrnVDRx9HfTJ9CtW3nNBC1DKdd8MYdQptnFYGuA/0YhudhVD3CAabF7Ng6ybPPF0rJ5A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKu4cyTLyewpsr73bS+EHSSxzWvIOhZEpAqIoovVLvgrOvEX9uV
	9uVrMxGK0zfVBhNVgA1gtQpZ+Ahcn6+0ioNfNlrrL06mbEsYkA4sGTdMlxdmAFepR27ZMPJcIxV
	shcTdgQaAbfnKHXwVwNY0yLFSyKC728dnbmkws96VVC62vXzDnChUFFX24/eHmyp7HA==
X-Gm-Gg: AYBFou2bdKi/JyqSMtLsoK7xQYful6PTKlheRMKAODcAeHmxHsKtPVZGU2zCAFvHCmo
	tzTM0OYI5ZrkTKYcP/beFRY7V/JJOmTAWCoBoE6xsNryXql/WuFBCAqHMM3hYbVJsGxNx2PMnjE
	W1dY0dtlNwivdmmfi9qx/v9v3QasirDZ2Wuc1+DZR18qmOcymILO/dKqEhsFyfWqqxH4H0NhxKw
	A2ggxjXWrhKQJn/dFQEsZlpga5mwG3/QpFuHnT/zLvScIxr7rxvpzTezh8eJU+dCeslkAdSAORY
	RdxZYCFlgIGaNMovI+aRKLg+77gQGti1GxGehRNYxQluOVNq+MK2yY68Y+X8zaTbv9pc/fU8TMy
	3I4Gyj/Dt8Z/yW12E5hTPY42qxfoVLSSNtwQ2PmRM4l6TcMi6xdQfefKP2qI6Q+MnuKkTAbUUVw
	0O0iOiJCBf2l5d
X-Received: by 2002:a05:620a:260a:b0:93c:b6db:8c with SMTP id af79cd13be357-93f299f3829mr1126491085a.0.1792409157330;
        Mon, 19 Oct 2026 04:25:57 -0700 (PDT)
X-Received: by 2002:a05:620a:260a:b0:93c:b6db:8c with SMTP id af79cd13be357-93f299f3829mr1126487085a.0.1792409156662;
        Mon, 19 Oct 2026 04:25:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:25:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:40 +0300
Subject: [PATCH v2 4/8] regulator: add Qualcomm LCDB driver
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-4-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15827;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fVg/LqWPANTqKF7KNueIvmrARSubsC7bReSSRU//4iU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f45f1Qer/aZCvN6wxqcHeBVVNufzEQwO8CcC
 v3WZPId/ECJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OQAKCRCLPIo+Aiko
 1VC6B/9zwhlAwzgFlMPBRLK8Ha7yilOnvWmcYd8tkTU01txjSiZtnBIli8O482+3qUf29RMPzk1
 eDU8N+jLQP5EAL90rCzOVqzfqwOaRP0A0OJdg/p+C8XHHd89SJxs3vChR5E/fdTjmRm/UHJhz/i
 HZN4sCZIBZEjrRawdDqhSQDEmoUbgdUwp4JVRsPjKi0SI7IlqwYcBFTFG2L9NSI4kk9KfOSwDsD
 cWQ5xLnLLMWQscTCi7Tlx+7XFRMjbnKADjY7gvHtfTCQBqVLt6PgtF8UBrbsBUqwkQB+nNX0XDD
 QbkEPK9vOJUU1PfrtaKldhqxoV8H2groLTt83ctf9BZNWuQI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXyO2O17Gkd00j
 +Jaf5kNDwjk1kJ0sUkA4+DJulQO3h0NjPOQZZa+Fdq8zgQbDTaKbMtci/2NJ1HKKFkx2WW/chxc
 hebR706RLTadnkdp6fcfZ2EC24LE548=
X-Proofpoint-ORIG-GUID: dBjcrchUDpDLMFZp6yeUG8XUguCvy0no
X-Proofpoint-GUID: dBjcrchUDpDLMFZp6yeUG8XUguCvy0no
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX/Tw0UUBc2nPQ
 7ZB0W0w7D8nEsFbQlx2tRFubfT+XtVFWvZOaAUuie1JEJI+/zyu36BaNGXklyHmAuxgKH0X7Xvc
 +traRJPhcfe9ZVqhc485ZlWeh5ka68SWVJaSn2i/6BozgZTZ9fTcftqIdJtgLPa/xKJSGA4Yt7q
 KcgG9n6QskNNCTwH22wH9QGP5HEJOTgaQ9fLkQFXaVvihVdAjhUSK2Mda6LsK/qB8Tv3+1c0MFr
 8tF/wqlVLyvyVY4AD46KLkt8ybCWlxNJdQU7YzQ2OgyJvCBe8zmI3K2G9bE/9uRxTIBQUjLzpXI
 WNmFcLJWLsuq7QGQKhvAo9QpsknoW9GsmjLDaZH5RmLYhSxj+vBOXdr0qzmlNozAlkY9gt/p/D9
 u6boywtIpFDXw4lakx3Pn1W+UFPqDKhdqPkZnbhQ/1lTN0zguuuDykOozJ9ubY/e2YkAUxEtLmh
 gkn3Sy8b66H3/SCCIjQ==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad5fe46 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=TQ_JAthNSI0sBqSp_oIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045

LCD panels on boards with PMI632, PM6150L or PM8150L take their bias
rails from the LCDB block. Without a driver they only work as long as
the bootloader has enabled it and nothing turns it off.

Both rails sit behind a single module enable, so the module is kept on
while at least one of them is in use. The boost output is not exposed:
it follows the higher of the two rails plus the headroom. Enabling
starts at a lower voltage and ramps up in steps, and the LDO pull-down
is forced while disabling, both as done by the vendor driver.

On a short circuit the module is restarted, up to ten times within a
second. After that the outputs are kept off and the consumers are
notified.

Touch-to-wake and the current limit and soft start tuning are not
supported. Neither is PM660L, whose boost is programmed differently.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/regulator/Kconfig               |   8 +
 drivers/regulator/Makefile              |   1 +
 drivers/regulator/qcom-lcdb-regulator.c | 494 ++++++++++++++++++++++++++++++++
 3 files changed, 503 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index be6b72daa76f..9fd3f2c7e365 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1915,4 +1915,12 @@ config REGULATOR_QCOM_LABIBB
 	  boost regulator and IBB can be used as a negative boost regulator
 	  for LCD display panel.
 
+config REGULATOR_QCOM_LCDB
+	tristate "Qualcomm LCDB regulator support"
+	depends on SPMI || COMPILE_TEST
+	help
+	  This driver supports the LCDB (LCD bias) block found on Qualcomm
+	  PMICs such as PMI632, PM6150L and PM8150L. It provides the positive
+	  (LDO) and negative (NCP) bias rails for LCD panels.
+
 endif
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 6aabcc54382a..84164d2b6c45 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
 obj-$(CONFIG_REGULATOR_NEX10000UB) += nex10000ub-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_LABIBB) += qcom-labibb-regulator.o
+obj-$(CONFIG_REGULATOR_QCOM_LCDB) += qcom-lcdb-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_PM8008) += qcom-pm8008-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_REFGEN) += qcom-refgen-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
diff --git a/drivers/regulator/qcom-lcdb-regulator.c b/drivers/regulator/qcom-lcdb-regulator.c
new file mode 100644
index 000000000000..bb2d4ee23ad5
--- /dev/null
+++ b/drivers/regulator/qcom-lcdb-regulator.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#define LCDB_INT_RT_STS			0x10
+#define  LCDB_VREG_OK_RT_STS		BIT(0)
+#define  LCDB_SC_ERROR_RT_STS		BIT(1)
+
+#define LCDB_BST_OUTPUT_VOLTAGE		0x41
+#define  LCDB_BST_OUTPUT_VOLTAGE_MASK	GENMASK(5, 0)
+
+#define LCDB_MODULE_RDY			0x45
+#define  LCDB_MODULE_RDY_BIT		BIT(7)
+
+#define LCDB_ENABLE_CTL1		0x46
+#define  LCDB_MODULE_EN			BIT(7)
+
+#define LCDB_LDO_OUTPUT_VOLTAGE		0x71
+#define LCDB_LDO_FORCE_PD_CTL		0x79
+#define  LCDB_LDO_FORCE_PD_EN		BIT(0)
+#define  LCDB_LDO_FORCE_PD_MODE		BIT(7)
+
+#define LCDB_NCP_OUTPUT_VOLTAGE		0x81
+
+#define LCDB_OUTPUT_VOLTAGE_MASK	GENMASK(4, 0)
+
+#define LCDB_MIN_UV			4000000
+#define LCDB_STEP_100MV_UV		100000
+#define LCDB_50MV_MIN_UV		4950000
+#define LCDB_STEP_50MV_UV		50000
+#define LCDB_50MV_MIN_SEL		10
+#define LCDB_N_VOLTAGES			32
+
+#define LCDB_BST_MIN_UV			4700000
+#define LCDB_BST_MAX_UV			6275000
+#define LCDB_BST_STEP_UV		25000
+#define LCDB_BST_HEADROOM_UV		150000
+
+#define LCDB_RAMP_START_UV		4500000
+#define LCDB_RAMP_STEP_UV		500000
+
+#define LCDB_OFF_ON_DELAY_US		20000
+#define LCDB_VREG_OK_TIMEOUT_US		50000
+
+#define LCDB_SC_RESET_CNT_DLY_US	1000000
+#define LCDB_SC_CNT_MAX			10
+
+enum {
+	LCDB_LDO,
+	LCDB_NCP,
+	LCDB_NUM_RAILS,
+};
+
+struct qcom_lcdb {
+	struct device *dev;
+	struct regmap *regmap;
+	u32 base;
+
+	struct mutex lock;
+	struct regulator_dev *rdev[LCDB_NUM_RAILS];
+	int uV[LCDB_NUM_RAILS];
+	unsigned int enabled_mask;
+	ktime_t off_time;
+
+	bool sc_disabled;
+	int sc_count;
+	ktime_t sc_time;
+};
+
+static const u8 qcom_lcdb_vreg[LCDB_NUM_RAILS] = {
+	[LCDB_LDO] = LCDB_LDO_OUTPUT_VOLTAGE,
+	[LCDB_NCP] = LCDB_NCP_OUTPUT_VOLTAGE,
+};
+
+static unsigned int qcom_lcdb_uV_to_sel(int uV)
+{
+	if (uV < LCDB_50MV_MIN_UV)
+		return (uV - LCDB_MIN_UV) / LCDB_STEP_100MV_UV;
+
+	return LCDB_50MV_MIN_SEL + (uV - LCDB_50MV_MIN_UV) / LCDB_STEP_50MV_UV;
+}
+
+static int qcom_lcdb_sel_to_uV(unsigned int sel)
+{
+	if (sel < LCDB_50MV_MIN_SEL)
+		return LCDB_MIN_UV + sel * LCDB_STEP_100MV_UV;
+
+	return LCDB_50MV_MIN_UV + (sel - LCDB_50MV_MIN_SEL) * LCDB_STEP_50MV_UV;
+}
+
+static int qcom_lcdb_write_voltages(struct qcom_lcdb *lcdb, int ldo_uV, int ncp_uV)
+{
+	const int uV[LCDB_NUM_RAILS] = { ldo_uV, ncp_uV };
+	unsigned int bst_sel, cur_sel;
+	int bst_uV, ret, i;
+
+	bst_uV = clamp(max(ldo_uV, ncp_uV) + LCDB_BST_HEADROOM_UV,
+		       LCDB_BST_MIN_UV, LCDB_BST_MAX_UV);
+	bst_sel = DIV_ROUND_UP(bst_uV - LCDB_BST_MIN_UV, LCDB_BST_STEP_UV);
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_BST_OUTPUT_VOLTAGE, &cur_sel);
+	if (ret)
+		return ret;
+	cur_sel &= LCDB_BST_OUTPUT_VOLTAGE_MASK;
+
+	/* The boost has to stay above both outputs while they are changing */
+	if (bst_sel > cur_sel) {
+		ret = regmap_update_bits(lcdb->regmap,
+					 lcdb->base + LCDB_BST_OUTPUT_VOLTAGE,
+					 LCDB_BST_OUTPUT_VOLTAGE_MASK, bst_sel);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < LCDB_NUM_RAILS; i++) {
+		ret = regmap_update_bits(lcdb->regmap,
+					 lcdb->base + qcom_lcdb_vreg[i],
+					 LCDB_OUTPUT_VOLTAGE_MASK,
+					 qcom_lcdb_uV_to_sel(uV[i]));
+		if (ret)
+			return ret;
+	}
+
+	if (bst_sel < cur_sel)
+		ret = regmap_update_bits(lcdb->regmap,
+					 lcdb->base + LCDB_BST_OUTPUT_VOLTAGE,
+					 LCDB_BST_OUTPUT_VOLTAGE_MASK, bst_sel);
+
+	return ret;
+}
+
+static int qcom_lcdb_write_limited(struct qcom_lcdb *lcdb, int limit_uV)
+{
+	return qcom_lcdb_write_voltages(lcdb,
+					min(lcdb->uV[LCDB_LDO], limit_uV),
+					min(lcdb->uV[LCDB_NCP], limit_uV));
+}
+
+static int qcom_lcdb_module_disable(struct qcom_lcdb *lcdb)
+{
+	int ret, pd_ret;
+
+	/* Force the LDO pull-down to discharge the output quickly */
+	ret = regmap_write(lcdb->regmap, lcdb->base + LCDB_LDO_FORCE_PD_CTL,
+			   LCDB_LDO_FORCE_PD_EN | LCDB_LDO_FORCE_PD_MODE);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1, 0);
+	if (!ret) {
+		lcdb->off_time = ktime_get();
+		usleep_range(10000, 11000);
+	}
+
+	pd_ret = regmap_write(lcdb->regmap, lcdb->base + LCDB_LDO_FORCE_PD_CTL, 0);
+
+	return ret ?: pd_ret;
+}
+
+static int qcom_lcdb_module_enable(struct qcom_lcdb *lcdb)
+{
+	int target_uV = max(lcdb->uV[LCDB_LDO], lcdb->uV[LCDB_NCP]);
+	int uV = LCDB_RAMP_START_UV;
+	unsigned int val;
+	s64 off_us;
+	int ret;
+
+	off_us = ktime_us_delta(ktime_get(), lcdb->off_time);
+	if (off_us < LCDB_OFF_ON_DELAY_US)
+		usleep_range(LCDB_OFF_ON_DELAY_US - off_us,
+			     LCDB_OFF_ON_DELAY_US - off_us + 1000);
+
+	/* Start low and ramp the outputs up in steps to limit the inrush current */
+	ret = qcom_lcdb_write_limited(lcdb, uV);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1,
+			   LCDB_MODULE_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(lcdb->regmap,
+				       lcdb->base + LCDB_INT_RT_STS, val,
+				       val & LCDB_VREG_OK_RT_STS,
+				       1000, LCDB_VREG_OK_TIMEOUT_US);
+	if (ret) {
+		dev_err(lcdb->dev, "outputs failed to come up: %d\n", ret);
+		goto err_disable;
+	}
+
+	usleep_range(10000, 11000);
+
+	while (uV < target_uV) {
+		uV += LCDB_RAMP_STEP_UV;
+
+		ret = qcom_lcdb_write_limited(lcdb, uV);
+		if (ret)
+			goto err_disable;
+
+		usleep_range(1000, 1100);
+	}
+
+	return 0;
+
+err_disable:
+	qcom_lcdb_module_disable(lcdb);
+
+	return ret;
+}
+
+static int qcom_lcdb_enable(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+	int ret = 0;
+
+	guard(mutex)(&lcdb->lock);
+
+	if (lcdb->sc_disabled)
+		return -EIO;
+
+	if (!lcdb->enabled_mask)
+		ret = qcom_lcdb_module_enable(lcdb);
+	if (ret)
+		return ret;
+
+	lcdb->enabled_mask |= BIT(rdev_get_id(rdev));
+
+	return 0;
+}
+
+static int qcom_lcdb_disable(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+	unsigned int mask;
+	int ret;
+
+	guard(mutex)(&lcdb->lock);
+
+	mask = lcdb->enabled_mask & ~BIT(rdev_get_id(rdev));
+	if (!mask && !lcdb->sc_disabled) {
+		ret = qcom_lcdb_module_disable(lcdb);
+		if (ret)
+			return ret;
+	}
+
+	lcdb->enabled_mask = mask;
+
+	return 0;
+}
+
+static int qcom_lcdb_is_enabled(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&lcdb->lock);
+
+	return !lcdb->sc_disabled && (lcdb->enabled_mask & BIT(rdev_get_id(rdev)));
+}
+
+static int qcom_lcdb_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+	int uV[LCDB_NUM_RAILS];
+	int ret;
+
+	guard(mutex)(&lcdb->lock);
+
+	memcpy(uV, lcdb->uV, sizeof(uV));
+	uV[id] = qcom_lcdb_sel_to_uV(sel);
+
+	ret = qcom_lcdb_write_voltages(lcdb, uV[LCDB_LDO], uV[LCDB_NCP]);
+	if (ret)
+		return ret;
+
+	lcdb->uV[id] = uV[id];
+
+	return 0;
+}
+
+static int qcom_lcdb_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct qcom_lcdb *lcdb = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&lcdb->lock);
+
+	return qcom_lcdb_uV_to_sel(lcdb->uV[rdev_get_id(rdev)]);
+}
+
+static const struct regulator_ops qcom_lcdb_ops = {
+	.enable			= qcom_lcdb_enable,
+	.disable		= qcom_lcdb_disable,
+	.is_enabled		= qcom_lcdb_is_enabled,
+	.set_voltage_sel	= qcom_lcdb_set_voltage_sel,
+	.get_voltage_sel	= qcom_lcdb_get_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+};
+
+static const struct linear_range qcom_lcdb_ranges[] = {
+	REGULATOR_LINEAR_RANGE(LCDB_MIN_UV, 0, LCDB_50MV_MIN_SEL - 1,
+			       LCDB_STEP_100MV_UV),
+	REGULATOR_LINEAR_RANGE(LCDB_50MV_MIN_UV, LCDB_50MV_MIN_SEL,
+			       LCDB_N_VOLTAGES - 1, LCDB_STEP_50MV_UV),
+};
+
+static const struct regulator_desc qcom_lcdb_descs[LCDB_NUM_RAILS] = {
+	[LCDB_LDO] = {
+		.name			= "lcdb_ldo",
+		.of_match		= "ldo",
+		.id			= LCDB_LDO,
+		.ops			= &qcom_lcdb_ops,
+		.type			= REGULATOR_VOLTAGE,
+		.linear_ranges		= qcom_lcdb_ranges,
+		.n_linear_ranges	= ARRAY_SIZE(qcom_lcdb_ranges),
+		.n_voltages		= LCDB_N_VOLTAGES,
+		.owner			= THIS_MODULE,
+	},
+	[LCDB_NCP] = {
+		.name			= "lcdb_ncp",
+		.of_match		= "ncp",
+		.id			= LCDB_NCP,
+		.ops			= &qcom_lcdb_ops,
+		.type			= REGULATOR_VOLTAGE,
+		.linear_ranges		= qcom_lcdb_ranges,
+		.n_linear_ranges	= ARRAY_SIZE(qcom_lcdb_ranges),
+		.n_voltages		= LCDB_N_VOLTAGES,
+		.owner			= THIS_MODULE,
+	},
+};
+
+static bool qcom_lcdb_handle_sc(struct qcom_lcdb *lcdb)
+{
+	guard(mutex)(&lcdb->lock);
+
+	if (!lcdb->enabled_mask || lcdb->sc_disabled)
+		return false;
+
+	qcom_lcdb_module_disable(lcdb);
+
+	if (ktime_us_delta(ktime_get(), lcdb->sc_time) > LCDB_SC_RESET_CNT_DLY_US) {
+		lcdb->sc_count = 0;
+	} else if (lcdb->sc_count > LCDB_SC_CNT_MAX) {
+		dev_err(lcdb->dev, "persistent short circuit, keeping the outputs off\n");
+		lcdb->sc_disabled = true;
+		return true;
+	}
+
+	lcdb->sc_count++;
+	lcdb->sc_time = ktime_get();
+
+	if (qcom_lcdb_module_enable(lcdb)) {
+		dev_err(lcdb->dev, "failed to recover from a short circuit\n");
+		lcdb->sc_disabled = true;
+		return true;
+	}
+
+	return false;
+}
+
+static irqreturn_t qcom_lcdb_sc_irq(int irq, void *data)
+{
+	struct qcom_lcdb *lcdb = data;
+	unsigned int val;
+	int ret, i;
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_INT_RT_STS, &val);
+	if (ret || !(val & LCDB_SC_ERROR_RT_STS))
+		return IRQ_HANDLED;
+
+	/* Blanking time, a real short circuit is still reported afterwards */
+	usleep_range(2000, 2100);
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_INT_RT_STS, &val);
+	if (ret || !(val & LCDB_SC_ERROR_RT_STS))
+		return IRQ_HANDLED;
+
+	if (qcom_lcdb_handle_sc(lcdb)) {
+		for (i = 0; i < LCDB_NUM_RAILS; i++)
+			regulator_notifier_call_chain(lcdb->rdev[i],
+						      REGULATOR_EVENT_FAIL, NULL);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int qcom_lcdb_hw_init(struct qcom_lcdb *lcdb)
+{
+	unsigned int val;
+	int ret, i;
+
+	for (i = 0; i < LCDB_NUM_RAILS; i++) {
+		ret = regmap_read(lcdb->regmap, lcdb->base + qcom_lcdb_vreg[i], &val);
+		if (ret)
+			return ret;
+
+		lcdb->uV[i] = qcom_lcdb_sel_to_uV(val & LCDB_OUTPUT_VOLTAGE_MASK);
+	}
+
+	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1, &val);
+	if (ret)
+		return ret;
+
+	if (val & LCDB_MODULE_EN) {
+		lcdb->enabled_mask = GENMASK(LCDB_NUM_RAILS - 1, 0);
+		return 0;
+	}
+
+	return regmap_set_bits(lcdb->regmap, lcdb->base + LCDB_MODULE_RDY,
+			       LCDB_MODULE_RDY_BIT);
+}
+
+static int qcom_lcdb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regulator_config cfg = {};
+	struct qcom_lcdb *lcdb;
+	int irq, ret, i;
+
+	lcdb = devm_kzalloc(dev, sizeof(*lcdb), GFP_KERNEL);
+	if (!lcdb)
+		return -ENOMEM;
+
+	lcdb->dev = dev;
+
+	lcdb->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!lcdb->regmap)
+		return dev_err_probe(dev, -ENODEV, "failed to get the parent regmap\n");
+
+	ret = device_property_read_u32(dev, "reg", &lcdb->base);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get the base address\n");
+
+	ret = devm_mutex_init(dev, &lcdb->lock);
+	if (ret)
+		return ret;
+
+	ret = qcom_lcdb_hw_init(lcdb);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read the initial state\n");
+
+	cfg.dev = dev;
+	cfg.regmap = lcdb->regmap;
+	cfg.driver_data = lcdb;
+
+	for (i = 0; i < LCDB_NUM_RAILS; i++) {
+		lcdb->rdev[i] = devm_regulator_register(dev, &qcom_lcdb_descs[i], &cfg);
+		if (IS_ERR(lcdb->rdev[i]))
+			return dev_err_probe(dev, PTR_ERR(lcdb->rdev[i]),
+					     "failed to register %s\n",
+					     qcom_lcdb_descs[i].name);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return devm_request_threaded_irq(dev, irq, NULL, qcom_lcdb_sc_irq,
+					 IRQF_ONESHOT, "lcdb-sc", lcdb);
+}
+
+static const struct of_device_id qcom_lcdb_match[] = {
+	{ .compatible = "qcom,pm8150l-lcdb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_lcdb_match);
+
+static struct platform_driver qcom_lcdb_driver = {
+	.driver = {
+		.name = "qcom-lcdb-regulator",
+		.of_match_table = qcom_lcdb_match,
+	},
+	.probe = qcom_lcdb_probe,
+};
+module_platform_driver(qcom_lcdb_driver);
+
+MODULE_DESCRIPTION("Qualcomm LCDB (LCD bias) regulator driver");
+MODULE_LICENSE("GPL");

-- 
2.47.3

