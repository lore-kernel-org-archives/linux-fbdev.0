Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3094EFFC0
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054753; cv=none; b=U1xRq7PhBfvOVtO1vNc4rrdV8ZoPyH72PVx8fKh5T8xMN3HE1imc7gQbYl9cmmbLCohxHfuRanoH3X3RIKFymZiOhJ85SXGpNMMTeBspDpHSGBouR7vtUayfZ832MsEFTvblGqJj24IROFiBLhhf9HFxHqydAbsFY7IImypBUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054753; c=relaxed/simple;
	bh=0G8oHV7Iaf+F2rNSJejgBlOHtOGWquaiHcHxeXy4LWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcpZB/nJ+a0S0+LqKk+k0thWb+46CAyDGpwja+lq+8scztfri7fM+o8F0DS77o8snWf1W+NeYaeXDDBR5d90kCAxEp4/ETbutfd25SM1rHi/PB9VcS0ZivblHYjzpOpC2VQy0tMZ32NA5nlT4syA76EwAWjzgXOdmNHZcmqE28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NL0VUDjM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E21FcEkx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NL0VUDjM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E21FcEkx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3xmOl2739406
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Bvz/kMR7NqEowR/9FJ0mOCFGWKDpq2MbUNyuR8mPjA=; b=NL0VUDjMmWLHlrnm
	KgWfhAhbuiV1UZSWpNh5WYt8fEyx3TKkYUAcAgTBeRgV4tjyJNLhxisk321x8dfn
	+2Nc5qaRX6/IS3p/1+WDRGasztTebnIGr/mO7wtgK/i94R/9qBrq+0atYiy54a8V
	MiNUPOC4VUHcUUTJUSwEabDPhR/vacKPtn3ODJ/IZWql6UIwyE6SeBFD+4r4nMxU
	LJ7ViUCVxyEElP8HSRlzmJ6iEJEb0G7z/xlnPAzBvuj2wCvjQ4DyKEIr5lLIiV4R
	E7mmsu4Z1T9EFccVOSX1yX9xaRyL9+UGxmmwNDDInI1ZCO84okWfz2V1w404X9Tm
	rFcxtw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds94hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so374451585a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792054748; x=1792659548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Bvz/kMR7NqEowR/9FJ0mOCFGWKDpq2MbUNyuR8mPjA=;
        b=E21FcEkxM5ycdR8Bx0axbf3Ibq0pMaYKaNmI0E7Ii/ttdFKW2DQo4qd6EOyQqtBfjO
         B77hLB3mJdLZfa7u3rDfQUcKTGzoGrhL0IvyyCdmce03pUw1qcKjLWVDne4vx64tmoqq
         ZHTyksaVDD2YXWfd6LFin7EriNYjohGWPXlIV5RmZYcrCl02S6fhkfalJJPKBMze5Abz
         +3rRo9pG5iXRNy3QrfIXkFZW++LYp3Abjc2FE5ho5Cq/FiJCu28hCosn3FV1BzF1rD6U
         GfFOcM4teLCs+2ah3pHBBak7VWD90XmDnCHyEim3pXy3RIm9lTeKvXiKZMpPHR90jk4A
         Dl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054748; x=1792659548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Bvz/kMR7NqEowR/9FJ0mOCFGWKDpq2MbUNyuR8mPjA=;
        b=vmBetSSK2NorowK1RQPZuuEfXOOJwxvsVP4v5Uld1CMUkB5hMW0hwb8E3XR5khZ4dV
         IV8YmaqMEY3YPHSQz0Ae3bNRWYuxEX4QZwabCu/X0Z3alxmVnDFnH06Q1truGlddSpB+
         zOYKXcKsorrutF4fsbEZATOp8rls7bTFA3PIaz4G/XYct4pEQCOfRAHtP+ja2n4zihvS
         ayn31sqPKoKL96zz9ZGRPuzktPFiVXfxszdTm+73wNPvhJkjQt7U7VOAVr8D+r4DQbqW
         iScpLfUiI+MWoGJoGKjcRXBxB2ueYvu+IqlhjYoIF9ESHrzm5nRPx+9gDIlsK3In2cG/
         d7yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwb8Hr9NyBxWW4vSNiDI2doHrHNv/6zzw33+XZDQdzdCq5f3XAevUrUfvbLZACuqHVI9td1qyKBem0KUA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIegkFAtp8YNFMTTIxyFQRXofXgPvrIQhl9bJ73bn/fxhK/Yyo5
	DEOitZxH2yJR8TjyiyogxQmnSdAn9EcIhqc27A/+nsYqv5Ru19dg+qJdyo4HN9Sjv0fO4gmZA/9
	gCiKCu7hjnkdAvgppalYQzVkJzu6oDJ1rr8dWd/N1uvTvMcPTFnBx3o+KKdleuDliVA==
X-Gm-Gg: AYBFou0KN7v4dRuheBPcfSLYX1ovEVTg8DRHYt2TcYzW6uygsnM5qxZzOa4eO0afPWM
	syuZ6JFIhanVGOqi688YNf/EkS9ojVgnBeWoaygzrihff80+RzKBHYGB6wP28/sQwgYqo8KKCnF
	2MqyaWGgzEzx2eZzADZT+HNb/mzQSrOdtuBChgcE5Pw3vB5qmh0yCKj5FTOA+MovEH00tMDBMlA
	4YOGV6PfDHO0cpQJu8TYgDgHRJaUImB5aPyJVS1L08eXMdCVBd0jcB4UMutF174PLHE6HBRgsjT
	FEgJipjfLSH62mezYROMw2OfczLu9ZWvkcHXaZOxGRHMjPuns7ZgdkyxBRJuJ/HRU+55edbC1l9
	pZun/nnk35b9kZz8ygFH8wG5WWLtDVDtyl+3excWnzrm+fn1TqcFY+MQ6kVPphz0GzlK4h5K3n5
	JNlY3VJR3uTcMN
X-Received: by 2002:a05:620a:199a:b0:93e:cf47:eb9e with SMTP id af79cd13be357-93ecf47f98amr2170751685a.11.1792054747632;
        Thu, 15 Oct 2026 01:59:07 -0700 (PDT)
X-Received: by 2002:a05:620a:199a:b0:93e:cf47:eb9e with SMTP id af79cd13be357-93ecf47f98amr2170750385a.11.1792054747204;
        Thu, 15 Oct 2026 01:59:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:59:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:46 +0300
Subject: [PATCH 9/9] arm64: dts: qcom: sm8150-hdk: add display card overlay
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-9-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3677;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0G8oHV7Iaf+F2rNSJejgBlOHtOGWquaiHcHxeXy4LWk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXIdAlz95KI9h/Kzl+CwuERsjroHKyCSch49
 rcQmC4Iy/yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVyAAKCRCLPIo+Aiko
 1X8zB/sGFmKRpkZKPP3Pe4eixaHQrtRFlcQ7U4ki7V87Zh0fXkkspOXM631dB+G6qJXqXTMJQdj
 345ORGYg9pDpXIQS6ynTN95ahClYwkejpnpTQGRcG0E/5tDpcjJGlocwWiRa3gjqiSqBCkCxE8Q
 +y7Kes5WUzTfJXMNi5I2UTmlKpD9p1qTkQJGJ3e15es3r3QljyYk/YxDf/PN7sdhYIajTbBFo+B
 rIUG/8PQBerZK744GEy8/cKOZrn+tOk4GOqfg6fHyOcW4Bo2z6xhbM8wh0Z+emCrocoHyqjfIGt
 hrxz7gocQprafndfcXP7ys1CROUMrfo99VOS59r1xrS4seut
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: dzTZpGurSyKKhPW1NEh7j_oLemvKqGd2
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad095dc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=k5xu95HCNwnmwRhsQXIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX3rfEK8YLvNx5
 igQ2vjwgFVgfUNFe3tkKKTzqx0xRTdBldaYkGWuuFk/diFgQ79LXl6DjLA+w3qQpi5+Z0iF+nYZ
 8LZdUFzx0/ILdFSqRbbovGw3gzGoX1R4RW0WgDbOwa2nkzu4wHoTCEg2J4lGYIPlW/kgqLqOGi5
 uTLGWTz2MlNV9biPWeHikdlpAcxKsBXvp6sz+VEtzSdjhwz+3gV/YrT4SgIkFLt5gMW2kTgjJPb
 A0ogov4nLco9ywoYgb67qv14Cc21HCKrc1MzknDVhkMOqAvMzNaWVT2M1jFX/PEqIfA+fhGncvN
 vN7DwZaxRhyikjCcqrAZieRBbJ4wJ3Nj9zhwBJYXTySt+WqgICtYRx6R9avAfzjCteSo9Js2rQD
 fOJ30LAiXSwJ8F866fmOAOTd17jUOzODHHkSianMS0vzbuxhvSRbuXjXkgmdDCF6mnL3kKVfI2J
 gYJbU21PRaDXiUjStkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX8m+ZOUGteuXi
 c23i+G6aJh/0y24jBZGCnl7cCfD5bGK0wT9Ik+o1fb4Mpqa0XxJNiUW14GkO1Sggqf0R86k0Fua
 9qqKzj91ViSzsAcjy3fCcrbpjBZMei8=
X-Proofpoint-GUID: dzTZpGurSyKKhPW1NEh7j_oLemvKqGd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035

The SM8150 HDK can be fitted with a display card carrying a Truly
NT36850 WQHD dual-DSI panel. It uses the PM8150L WLED for the backlight
and LCDB for the bias rails, and it is mutually exclusive with the
on-board LT9611 HDMI bridge.

Only two of the three WLED strings are connected on the card: the
backlight stays dark and the boost runs into the overvoltage limit if
only the third string is driven.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 .../boot/dts/qcom/sm8150-hdk-display-card.dtso     | 103 +++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 85d06a950b4a..571bda210d63 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -409,6 +409,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm7325-nothing-spacewar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7325-xiaomi-lisa.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7325-xiaomi-taoyao.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
+
+sm8150-hdk-display-card-dtbs	:= sm8150-hdk.dtb sm8150-hdk-display-card.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk-display-card.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso
new file mode 100644
index 000000000000..205cd6d2cd71
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Display Card kit overlay.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/dts-v1/;
+/plugin/;
+
+/* Disable HDMI bridge related nodes (mutually exclusive with the display card) */
+&lt9611_codec {
+	status = "disabled";
+};
+
+&mdss_dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "truly,wqhd60-nt36850";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+		avdd-supply = <&pm8150l_lcdb_ldo>;
+		avee-supply = <&pm8150l_lcdb_ncp>;
+
+		backlight = <&pm8150l_wled>;
+
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync>;
+		pinctrl-names = "default", "sleep";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				panel0_in: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				panel1_in: endpoint {
+					remote-endpoint = <&mdss_dsi1_out>;
+				};
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+};
+
+&mdss_dsi1_out {
+	remote-endpoint = <&panel1_in>;
+};
+
+&pm8150l_lcdb {
+	status = "okay";
+};
+
+&pm8150l_wled {
+	qcom,num-strings = <2>;
+
+	status = "okay";
+};
+
+&tlmm {
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync: mdp-vsync-state {
+		pins = "gpio8";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};

-- 
2.47.3

