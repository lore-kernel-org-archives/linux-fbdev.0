Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD614EC667
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409176; cv=none; b=K05dtfYrDLQ5zUKJT4xJhnJQE843/SaL/t8Qbk8wolDNRS6ZVoCT6+iJxiDiy6G9EOYU8HTt6h++gbnQ2gDryZXSqrCjLT1UKisj2IWAKQy0CR64IrAr+4thBtcMj/vXK65FEJlObPYX0pqosLsMXZQnBHAEtQOU6DtiytnULpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409176; c=relaxed/simple;
	bh=bqeeWAz+d4IHQrcnKjbogs3Jr+vUY0ij/Dq/7cvVfhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/RO29aaVs55BDaVKCBWrx9TvVH8JKn/4RA8/gGhoTfe1HwjY66EHeLsdQ93C5mAht7c48+DhK2umvxJNfSwcSBZBIF2amsMEyLsCVufLl/NO8u21fdOvT3olxGU2OR2aLU9S5EtreE2Z/P/OYDmFlzcEDdk3TXvBF/4FdalY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PwzgyYAQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PETtX8Z+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PwzgyYAQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PETtX8Z+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OrEO1665571
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L/iv0Hjic3D1gnEdMJH+n9iwoS1ng3NDhVKTxbtsGWw=; b=PwzgyYAQeeqsF16C
	34otn7IdrYPX/joLSwulceMORSeSywqTnQhNc95A4TOHQfcRupn9cJ38TJEmIy/H
	BTY153r06ZGw3uImg+XeIhR8DQ/BOo5zFkJlz6xjf1ZeX5YmHTesHZWzRmAk+YvJ
	PJ893shDonUtzdCLaagA/TWf0WAR0zYJg52cSdhDNeJqkMrfoWFfVAOCiT3iW9C5
	4EKi8WZHFB7qrO8HcTfwFx5Ii3/+7KhyR+4uDOOEQxKr/Z20CZrhfpY4ZSisX0oq
	eESjL+n9bahMk5Cv2on0lwBhD853xmHCaTsTU85Kor755uf2E8M9cRIV2Mrw3Rup
	BpC93Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0tha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f32050e72so566253585a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409167; x=1793013967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/iv0Hjic3D1gnEdMJH+n9iwoS1ng3NDhVKTxbtsGWw=;
        b=PETtX8Z+jmoIY6Up2or5blTbnoIQfXQr9GA4VwSoYmAamX3T6MZVrVKVFbFhJgXF6i
         i8GEOVuF2HFTjXf2XrcQcYLijY1sG9C4uQe7gO/+5ldr9HhpM9pg8EH16j38vkBobXhr
         suqU7/MYLUBjY3E9BhA1D3t6xo/UZZxnlTW1Ej2c55JhXCIWN0+5WzSLVNvtYgUubQbD
         EFcCv5wTg643iAtiYxsjT4KcKu9IyD4Ne4EvPt9nFUgOqjXFgtWfIt2tejeeVldvKCOa
         qTuKlpwFaZ9yBXNNOFUxhx8EgVi78/c5mr5piODCRcdvYCVRM/NPges/T7WFzagryBii
         G97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409167; x=1793013967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/iv0Hjic3D1gnEdMJH+n9iwoS1ng3NDhVKTxbtsGWw=;
        b=LgFsCmNJjlY7grtvpIXN7laob3UzoUQG/AawHrhbhdJBzp5McY7h/iPYy2fFvBOsvM
         vQfTNTKVTG9Ezp0k3uoNRmOo+UenpM459fo7JzD1bFIEjj8V0nSkGA/xkOXsMRSMCn28
         yu3sKflE8wzgAP6thBa9+2yHhBA+BbfCA9QxzsM8VUN/koA6Uspzm3qDitfEfLDJ0XzT
         LUsZM4YMeaxib4W47VoTFEmbZYCzOFPi9QRAzXw+qCh6GYvdnr5+zAV/IOHAsCXUpf3a
         FGsvuB7J+izJxRtOX4421knQFovlkpqvshMUDG3jbYIJjHDiwbMFSKhBFMh8i9c48e9J
         FPSQ==
X-Forwarded-Encrypted: i=1; AKwUvByZtYuRsQWBB5H6K2RAlNKPpt0qm1oe7vwjXKWoLKHYaSXFM0KvoyYiK+bbz438PYyyxjQf5s3voTNz2A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKUOE6bLMZjgF2kElcrkd4c1oGy4NUvnH5GDJA9rQfSZw9GW47O
	lC3ebgfMdVhvUz9CSXIG7HZk8dD/I/u5v4gtt0RmZHzevZ1rEzg58aO4kln6J0AhykCUy3sIQGj
	bcXzxXwTBL6bhCcs5ZtrkLLNgPZuj2hJ1y13tm9L28L3FTDCjwduTEJqmZE9fEcbGNA==
X-Gm-Gg: AYBFou2vLcqoRJUh2W2FOzWfI3i/CIt9bw9qyoO2QprTdXsTtSUvFXLQ3v868q8fBBY
	8B8Yfc3695Qti0fL6WiBSGmqA8nq8Cp5usa2DaHUDYkqPblz/Xae2/RwTsWTPDrzmaitm3stUKi
	8eXG7qmNvmT7IwoAKNQyJJ5h+i1HLQthZSpyPS8l7+IZxVqmNAWphdyD94375GjlS6ox455oifk
	itR/i95XWwWiX0lXJdQi2wpGdDd81RsrtTtTP8dUD0Ocn4EjDMBH+vg5+x0j/K6h6UNY/VckIFS
	3lPRMXQvtPA94un2HfXa/tU4pSjLsPCsD15pe1RTYRjz89UuiZvAPBxseeNqASvfHJSVGKeiLY7
	3VWrEUtZdQo064cOkn+ChOvs2y7lU3LE8XaTQnAywjW6e65l274e/d//4qP4fw4vhoAA2O1hgoV
	sogUdb2LZNsyNN
X-Received: by 2002:a05:620a:6f87:20b0:93f:2def:5cd5 with SMTP id af79cd13be357-93f2def5f1dmr706069885a.51.1792409167326;
        Mon, 19 Oct 2026 04:26:07 -0700 (PDT)
X-Received: by 2002:a05:620a:6f87:20b0:93f:2def:5cd5 with SMTP id af79cd13be357-93f2def5f1dmr706067085a.51.1792409166750;
        Mon, 19 Oct 2026 04:26:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:26:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:44 +0300
Subject: [PATCH v2 8/8] arm64: dts: qcom: sm8150-hdk: add display card
 overlay
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bqeeWAz+d4IHQrcnKjbogs3Jr+vUY0ij/Dq/7cvVfhY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f47DvElBnzXYultIe4T5kpg6h6cmQXePLs8C
 oEt3lHh3k2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OwAKCRCLPIo+Aiko
 1ejlCACckV4FUSqkCy6G0axjtLG15uGa0R/QYb0KshxjrPod2Tc4VvA3WNkJBvc16zeUQfc8o+Q
 M5YD4BoJVAQTOhlfS009+/7NHs30Jq2cUKP+FXe+ggo61qUC6iTSg5v050YgWg7uds9UcnY4zed
 MABGKlEjWcHUzAvBlNLAfazG5uCM2U8lp5VcQ+IydWm3tMQU8drkAEeQ3i/PYsYKpzmektp6e3d
 eRRlRxuHB2lCCnqeaEklKp42xdAHq3t1MfWrurLdj2XUuE92RfxrTbNfNfwy4+uoShpj/4tPUxi
 y8fubgeboAwcb8y/CMawbCWA5Pi0B4TNKcU/FwsFcmhqGgZY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXwjHo5Z233j+x
 wfQSF7Q0tZh1AtakEuVlg9EeeY7fH6mzOMNDgJZu7rk9ZfT5FFVEdc6Kp36sS0cV+bZy1dWTVF2
 FxoXz35sK4gYGd2gufH+Z2U5AsoDKPI=
X-Proofpoint-ORIG-GUID: _HJt-biS-SO6vFcKFGUpZ8K_Be5sVmnK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX9evfpSrl8WGX
 F2knmKwKU87oi1Vksz4eRldVmagfOCPHhqIgJ874aJPfvXo1UCIRsU1rXmy4MYn4pDMCGV15qYM
 DfbVmCP51ETUSPafllKxD5iLqOoyHivp4eM76i56WHEomzbfz0ByGhGcjMwSQqBOuX9fzDZNN9S
 3Z2KhxA7UKq3ZMwxxlu+8OH9NwLvch5xRFrTIQnwhJ18OYjMypi3st/5F5g607mO9XPVzobNj1r
 8S4VMyvE/vv0VmZYkgZTTMIkDcMkQQrcNjM5H2TIZeaqgN0BWOXD8Km1FqCdxqQ3PrZRgVsIMFe
 ln+jynGXj/qpt6GvchIv56cEambkjIuEoEiQIP9Wt5nMWNb/6bec4fx2zy3RNsJ+yVkHsxeIce2
 7S8l+OObmACyEDPXJyo/xpQBOza3wThH1je0m08m+7wpbQr9jaNOgMFq71kkQFQvMm9Q26yaeyz
 KcMTvFe2/i5MhXDldFQ==
X-Proofpoint-GUID: _HJt-biS-SO6vFcKFGUpZ8K_Be5sVmnK
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5fe50 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=k5xu95HCNwnmwRhsQXIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045

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
 .../boot/dts/qcom/sm8150-hdk-display-card.dtso     | 113 +++++++++++++++++++++
 2 files changed, 117 insertions(+)

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
index 000000000000..bd57459f9c86
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk-display-card.dtso
@@ -0,0 +1,113 @@
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
+&pm8150l_lcdb_ldo {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5500000>;
+};
+
+&pm8150l_lcdb_ncp {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5500000>;
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

