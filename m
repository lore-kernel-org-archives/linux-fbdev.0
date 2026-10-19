Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849A4E50DC
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409161; cv=none; b=CTszEd1HoZ02toZj8DVnpvSQGudJrP6SJyieZs8HnKHUoFGPn/7sR9LW3Aji3Sm61pmK7mzV0qiHq2coJZypU7mAew/g/EdnFVWBTpVlZbEuITsIa/qih655NcEv2jzOq+2lbdGem8hRcbObvye94eqakkE+NzbHb85dGjEQCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409161; c=relaxed/simple;
	bh=3SFfXzC0bHwD78fBjVebg7PPYXaNP6Xkrxk92qxdGA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnfXMI9PwPwEz3UzO27oiQrEbuYMTaQAnRb+ENigVUGsEs77KIQ6MA4m+Fa/+t1ttnsLWdDwdBi6zeN8Bfo32Zg8y6KaJWB85tW3eJmPaQiD0P4L0RSnCt3Kpejzff63+8t9hNsBVjSc+f3FavgPELIdwzTrs+qtkJbkLJRoVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQuWuBsf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eec23Yu1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQuWuBsf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eec23Yu1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OtIi3256621
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5CG1ZmhSBv17Pssznbk9lW+JHvH1kxpH7x7K0dZwnyo=; b=ZQuWuBsfSgRd0sNe
	dyrPqEQvVipR82/HE8/GBSJ1dqFVvxGJJ3kdtH9mVxOfOZmNa4Dz1Nlqd/6N+6G8
	fIUclXJEIn1BRvvBhBAqUSB7MA52Zsh+qe1CBfcS5P6TKZE1DJVK7qTNXjCO0IKd
	vC5yASYhHbUpe6kkmQzNpgM1D0uYziw7AW28tY8vlT1naB/x95W+xhUq68F0GCne
	4BSu7FMjakh9NDNxSZxcNChJ+n+G1L1p2if4Ed+KBwGnrOAOKTWU/JOsFhHgAEyZ
	iXrUr9Gycv3OfAsFdsKfa9n6HPUSADwfFIMc2OI24dKtoru5VjGpHIsP9QgYFU6u
	uwbvnw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8tju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb6391e89so457868085a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409154; x=1793013954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CG1ZmhSBv17Pssznbk9lW+JHvH1kxpH7x7K0dZwnyo=;
        b=Eec23Yu1MVsMwj9srxXNf0HYiEc6j/oaUSkCny/x1KrvIiqdDCpYinCofFS84CvI7T
         Pg6RpOaoKFxNisapRlk0+hqoqOAMeuxg0+X39oDAKeNtawPFjEHvm9TazU+GILRDI8bH
         m3wuEv7YDiUNtkUf7w0BVkfmY08QZDT6wSTXurQpBQLb2tXd98NZRCx26vCN1/ZdVQ9e
         7JPCv6Zue8U9+zLIM6ahPYMOu23lDijfBZjxv39r11xIJV0KVsWtOcd7noC7b4YFPu33
         1mFN95azNDSuUfSHGJzUF+cHiMDVtN9k7vR13x1AiLiPMOF2Gks7K1Mvai4DaRUVt0j0
         psEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409154; x=1793013954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CG1ZmhSBv17Pssznbk9lW+JHvH1kxpH7x7K0dZwnyo=;
        b=kTD/mZEJFnUfUHhIrN4GjlgIMNsyGqu8zyKpYzzZtTrtVk9pY6pmxzGCAuATUwbuap
         Ryi7mhWYjlw7URwJb/YC4O2QdJA11eQj8z7mvb/UIdsH4JW/EeHewwR1ZNjzQhxghfZi
         PAr93i7V/niexNf7OuiF8dIcZccH4mvc7iSNLWyZSOwM6eKx72b7+PAU35xeO9O5lAyP
         13ZnjJDxeEdNUgblOis7sZjruaZ9X4S7uOudpl1Hk51QHEeuZUPUN2nzyBvtq5ikmtNi
         tGjXG6tsmYBIme7IXPG/7STOYj9RwEzYLdnRyaBv8rR7M1siaRI901DIt1VXPxjw62Fk
         Vh1A==
X-Forwarded-Encrypted: i=1; AKwUvByKtw542K8Z/eE+nRF4+Ktysgp8+CJtfxKC7BueayTQH1fuIPJATS45e3tnXAC1yT1cyII49T9v7LramA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpiX0jHtsbU6CraCpM8ppcJT3gUpOSvpd5NdcWjyaOot0dgiy3
	PLPixGVkJFKqJGaJy/HqvsY6GkFhSYOwDZ5Ip4f5jEmha0oLbEL5Mjp1RY33f3cvT5ChproNjy8
	BeJNKAYiJFqhdiKiXxu7lZjU4W50+u2q/96nkVc1erRS4ZcVMakbQV87oifm2hms41Q==
X-Gm-Gg: AYBFou2GrYXn2Ks24LiPEQoaJ9T2ezEbE5llEFZL0xt5JkMQiSs8R8P7t34iVSMjF1K
	uMszNKzi0CJgnMRqlG35SHmLWpI6s/x8JYheHJr8N+r+VXNaIwVe2/oNd4Qh8W3CWIPzpqu6qYn
	tKBUiLBFFVIluQ+AwEHLV/klil/wxpdwORoVJQEgQxmr09FmyefE8DQPd2p5cNagFzzqjjWDtRW
	uJR1GvGCjooFWuOxxpzk2lxVLbwsSwsggmy7jP7UWf1VISru7Ab52Ov7ZzPA+7kyLvx+LW2DzHt
	g01ojWJQ4HeUpz6PD/lAWY94zoEmPspKjKO1WLC/ta8Kn9tXFTFFligoi0HnwdgrETm9TCaIJPG
	Jh+1o5onvYHFIEROM5y9ARogj6aoupXBbBPLnPirmpgibjajQ272JU+DkDyoMPziCXHzTPAOv0P
	thCuMdrQE5zyzC
X-Received: by 2002:a05:620a:7113:b0:93e:96cb:3083 with SMTP id af79cd13be357-93f29d38660mr1173731285a.33.1792409153848;
        Mon, 19 Oct 2026 04:25:53 -0700 (PDT)
X-Received: by 2002:a05:620a:7113:b0:93e:96cb:3083 with SMTP id af79cd13be357-93f29d38660mr1173726485a.33.1792409153274;
        Mon, 19 Oct 2026 04:25:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:25:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:38 +0300
Subject: [PATCH v2 2/8] regulator: dt-bindings: add Qualcomm LCDB regulator
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-2-86c05068efc5@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3SFfXzC0bHwD78fBjVebg7PPYXaNP6Xkrxk92qxdGA8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f45ExUy8zE6GyGWTzcNpkND1+27Rx4Pfw9BQ
 6UtgAofC8aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OQAKCRCLPIo+Aiko
 1Ts2B/98bk/jBz49LoQOXRdknyPydiybtL39hdFjjUGkcUHaKwplQ7TB1JRybSNObZRTkyXdxJB
 +BY7yezNBzGTD+08+W14ZBvaWsk86BhzCqaB6d4XxP5ecFSPMPMhBylrI3MNfacfRYcv1UOnTlV
 M2lGTsjcb08YUJuAnPh5ufW5YvynS+xVBEFAboQhhSr7CgiJdBhCyInbkmbO7DfPrh/CUv6QT4b
 or2F/y1PNr9t+uOm1JN1a3Gpq1PkkFpjOnL53qsT9+Len7Mr7HVhgXuL4ryBLhsNs195CJKtkAk
 K/+8RsTwGCIjT/CQUApvfXUNC0xQzg9VpQvknt9zraXr0Ofo
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: j9ZrfIGfJjA42t6gfcma9h69KXjT68e4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX5Hp8W86/Wf5B
 ui/3L5kXrT247PTxytJJgkdfW6sWT/Y2takcSHfW4SMWWFHzgv65qBlZusEdtVapt+SQVCKiZcX
 7LyqZ0UlVdRnLVcKnfcwPbYrcYPjcJ5xDAdSrAEMReFJFgenZ2/xCDD8lae+HAwRE5FHIwMKsUn
 cqgU1E6Aze4wJOgrexuFZgVB2cjnDycimlIr3W0PhmX3oYMdnxyTtkHKuF6Zil10/6qvZx0entV
 yBSdykncC7L3EQ+WjIh+3WnCVXcO1FNS0K0klbj5LV0Y+4i+BME7GsJUDTtBSbpkxTloW+7UZWq
 pUwX+7pGH7hT/hNPzieKkrbBlU8AhdbPSrWhdcqjiNaeVtQHRzcYxqq7aT89uQ1+cVBsT3mVRrW
 /lY1UBELDBpGjQxCgPl/CyBRdZ/o88q6Nuv0k5TkFcH/7Aql/3wuo8Nap5O02m3miyknenyOGeK
 bbXoYEeC4wMKXRsw2IQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXwbDIK7008nf6
 h/6D5fxv3fPe+JzKWvWv5eTA3Krd2EP1uwczsvXyTtUg/5gbPGbnVUn7ghwboja7leMxyjKj78K
 HmY79JEr/b/iOfovDSgezO5/xIxGwm0=
X-Proofpoint-GUID: j9ZrfIGfJjA42t6gfcma9h69KXjT68e4
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5fe43 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=SXD4J7xBejkBiF3T0k4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045

Several Qualcomm PMICs have an LCDB block providing the positive and
negative bias rails for LCD panels. It is not supported by Linux, so
boards using it either model the rails as dummy fixed regulators and
depend on the state left by the bootloader.

Describe the LCDB regulator present on the PM8150L. Use it as a fallback
compatible for LCDB blocks on PMI632 and PM6150L. PM660L has a different
version of LCDB block, so it's not being covered.

Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/regulator/qcom,pm8150l-lcdb.yaml      | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml b/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml
new file mode 100644
index 000000000000..d3cba1aa0c2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,pm8150l-lcdb.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,pm8150l-lcdb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LCDB (LCD Bias) regulator
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+description:
+  LCDB is the LCD panel bias supply found on Qualcomm PMICs such as PMI632,
+  PM6150L and PM8150L. It consists of a boost converter feeding an LDO, which
+  provides the positive bias rail, and an inverting charge pump (NCP), which
+  provides the negative one. Both rails are switched together by a single
+  module enable.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,pm8150l-lcdb
+      - items:
+          - enum:
+              - qcom,pm6150l-lcdb
+              - qcom,pmi632-lcdb
+          - const: qcom,pm8150l-lcdb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: short circuit on one of the outputs
+
+  ldo:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: Positive bias rail.
+
+  ncp:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Negative bias rail. The voltage is specified as an absolute value.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@ec00 {
+            compatible = "qcom,pm8150l-lcdb";
+            reg = <0xec00>;
+            interrupts = <0x5 0xec 0x1 IRQ_TYPE_EDGE_RISING>;
+
+            ldo {
+                regulator-min-microvolt = <5500000>;
+                regulator-max-microvolt = <5500000>;
+            };
+
+            ncp {
+                regulator-min-microvolt = <5500000>;
+                regulator-max-microvolt = <5500000>;
+            };
+        };
+    };
+
+...

-- 
2.47.3

