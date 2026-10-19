Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB04E80C0
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409173; cv=none; b=g7GxftWQt6RZblKGBHciJQ2AMVPL1x1h2YfTOa1SvtVfMXTGKVGbEaA+UX8k6p6IQnq1bJ32NSsBjdI9NBUMFbyy+utxyp+sFHWKSzd8rRT6CdrOqjNGkRUpRKLZLSoDYxalh9J4XkhbZfLDmqSkr6htPtGW1JHB2IGnA8RHE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409173; c=relaxed/simple;
	bh=/1u112Fp/QaTfq2TFsBWcfozg9TsLnTJMmUIeYDwURA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDhMYjMNtJwiMmFppvg9aGGX4qi+9McHVXzKf3mCLvNjzI8QCsD3tll94ymZQmwbs3q2efRALiR1obdVVvOlE8PmY9rex3nsZORCOaeL6g4qiQQGGieuChSpwZaD7vyiQxxjf3TrIbGSUlLDQBEStp/OxcPFVPQb+4DQn5NOTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CvS3tH42; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PtQJ84rs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvS3tH42";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PtQJ84rs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P9Go2753903
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tii5RYXORarOGXzAnt+Gm5B0QCr3yXhEhRVEbLAopUU=; b=CvS3tH42DqGAO8BI
	Rgd088K/7wWEtXO00Pdw3OQhz+id7l5UcTms0iJUwBKSz2CueFMhT6f5Qp2YqDX+
	wVFk8iKh56t/a+kkjScibD1zNqWAJyVMLRxtVFstOxZpT30a4BAcXsSmQEXNdAI/
	ucPj+TPbkS3Z/mylFblUeowjss/ExtZGLk6VftqOpdiQIE4rUFQ9bDy3ROKDceny
	mMpzzIes4BrkSkZ6CMfPucSjR2TRGokHMjyXzb0nHG0GxNlfj8hN0cDItZyzJR+N
	t9YZS2YnLNU4/W27y7DTyoWRtQ4HteJw3KdINk042JNLocKV6JbZPSrTir7F/ulz
	qQng2Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48gt8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1e62510cso487094685a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409159; x=1793013959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tii5RYXORarOGXzAnt+Gm5B0QCr3yXhEhRVEbLAopUU=;
        b=PtQJ84rsnRduarOn2l6F70FmOqJz7UnIFjRMH1quk1Grhl2r3zurPg+uiM2oWPnCRd
         QzjgcpOWYkdY2LSxuCX7OwFu1j94XMhP8vYGi5PTjf7yG9jjT5lNGQXU/qYbt/GmVmN4
         n08w9XohAZ3xb0F/Qckr9MAD3nZr+HJhgFDRFKphXqVsqy+f757sFu9wa3JnHIh3QYtU
         6BOD/LrHVcarApuHDpEZ+GujEgtS6GggiR3e9c+2SlPPOwT2akI9feLsjT/+kZLhndRu
         RYBomvawa23xcfYjmi1V/qnrdacjt+BMquJqVMZR3o6oaS9QtnDZQmIeOeKm9FsnITO2
         aTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409159; x=1793013959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tii5RYXORarOGXzAnt+Gm5B0QCr3yXhEhRVEbLAopUU=;
        b=q9pgWpoSznzyX2Hi/cZcD9paERkQmZsYpIAd018ucArhZL2yt34MnFle8GsHxWtlKT
         NLt9kUBh7lSAl8pAhi4sOf/QCsXBdsML5D8P3i4VblJ9ITfeiVa3rNPDjzAAFPxbLJqu
         LRBVkL//MVZBnvC3nzLM2jj0eIQeuld6qw7p0QGuMaKqgx2cjVncel1LQ9dLeo3Or7He
         YxHJ16craNQcXTZ3IhijPFfWVcPcB3MmEB5h4pGRWBpr23TkN5s2LkEawlznAlQBd/5L
         l+CLnVmzv34NZqAIYxlnjFROQL8/V0dQro+UsKHRevlQRR+XdY5E7aaBRk2N7jjFdBGW
         86Rg==
X-Forwarded-Encrypted: i=1; AKwUvBwTQBJOadDcIwaUonFghuBuSQrgu3/+GVayzhjg6+5BzdPIT3knSK6hnUp+Jb6INzzirmMv5bU0noe3cg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKgVWFu4idLFUhCYECf98xQyVP1odwleqSNByt5gmov3d9lb7S/
	g51L0iIuqPRo3JMKFCiiX/qmkFA9gtJ3CKQAiQO5zXZXR6Ohr69yjJx/hKEjOajBWAIlXg+TaEu
	yCNj+MIyb59/Hw/lwLK2xsZzfsJ2bSMR0iKadHgMFrIAOue2eL8CkYK61MWzArQlcvg==
X-Gm-Gg: AYBFou2hqBAfj+OHr8WLhELgI4IKjFKFXLaEXr5woZM327/px2+r0zeReZjDwyO1kNO
	GPSA7shY4C2z5uXEJqRQDdIG8yCzfgYOEn+kZ8ASyD7dGwRPH6S7W67FXgP/TmHfMQ1ynN7WQHe
	mLVjXLu9f7qOJqlt7G3GccENf5xZa1LU71YEDzAo8+CyZK+a0qZqirYjOFsxKxCJU6wYzaSAlBp
	aTwdkOXEFdwQAU+v16VSj+d3uVZ1l21Yjj6R2ZYbAmnOQtKBA44TREbITlvPH71kxaYd5G4fJcy
	9hpfa7X1/Ey3ljcSxEb8/dujA0EUIQeW/NvX8+6uJ40OTenqKMB4ww80VPCQPnKP4exlHQ+9NZi
	Hf41p++qf9aJCm4GzOC/g3uP9MRMJn/xVWE2rTsZI28awv/lCDYoehqDOREp43bwJnFgiBZ5UN1
	b5Y30+2xAn538a
X-Received: by 2002:a05:620a:46ab:b0:93f:43a4:a48c with SMTP id af79cd13be357-93f43a4a64bmr140651185a.45.1792409158981;
        Mon, 19 Oct 2026 04:25:58 -0700 (PDT)
X-Received: by 2002:a05:620a:46ab:b0:93f:43a4:a48c with SMTP id af79cd13be357-93f43a4a64bmr140647085a.45.1792409158481;
        Mon, 19 Oct 2026 04:25:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:25:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:41 +0300
Subject: [PATCH v2 5/8] arm64: dts: qcom: pm8150l: add LCDB regulators
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/1u112Fp/QaTfq2TFsBWcfozg9TsLnTJMmUIeYDwURA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f46xEAVvhENHT5/cr5eUC0J1Mz7Mv7VIO563
 Lrnc+EFNdyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OgAKCRCLPIo+Aiko
 1UrkCACS72+7BOx9ZN6pTVSh4/cHz0fgq5dzxAulElxL6MTXCmbF238hFdvgoNdU5jtEncQj2Ss
 LIXQ9uOyDDtaw9N/usGH+no2wTcyPDCOo4uF63tPwaqL6it15DOogVtzq+L+8lYnJP2aSaXT0TK
 gYdvgG//oqkXLvJry2SYpNrQ80RmrtbGk5gLa8kA/wCbVnAwQw86P+D1C+QuK+Gt0s72HPfmdg9
 6m3AZY1EAb18yEAkXmK8vTALtOC5KvM7eIubzahCz26PTHU7dE5v5n/B09JcMbEurqn2f5ylspj
 qrHYCo2aLzqptIZDJl64ddZtb1TR5gQwm/ltogPmQ6msJh4D
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXxzVFTf2R/57f
 Vt75jALic3/Xo3gCz0l6vlHNyIYvRDQTuI4HxAZRfU2bY5jR/KTYu4Z8J8tqODhteP1+VOZRhwY
 BpAjIaVzDEY6enM0xojDV3rNMn33QuOLPC5kF7okgIHGOO0ccKrxxHgbkt1Et5jBqyb1Fe5cPpu
 csn6mdNr4AKwBJr+31LdtLMJxmpe7XDkVUquhosq/WnRNJaDdAplxXO+f3U7SzWXbmsnNDq9p3s
 YQ2e79E2o3fCVa2amjWERvzY4xs/cfovjojgev7IGQP8SCvyKuhhp+UFeTjJhxF+/CK/sWaYbgm
 80I/eC1uIlv+aT/nRPXZRGVxPpBNnC7g5SIjtIbdlByNEqq7vPbYTdV9cxjTrEJej1/xCcdO44P
 6xoFnGDoZYtNg1q73JBmqPv/0dbEKsDHCHk1vIPY//Xs+X7GbMP7vUTdkujdtWVD+Tsv4/keIsn
 1vjOf+Du/TJ55wzi6bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX8J4Z1or8xakK
 zbB2qwC4NYkSo4Zy6661l8s7H0SrW7BXl1DrdlbEmRg121m0U/zbTdH2uS2J/On5iR6tWVyHWSP
 YUceZ9l5tSSyXYTVpHDsIkTZ+kVpezw=
X-Proofpoint-ORIG-GUID: xspO2xtHoXChfs2XuMcCrCiJRmJchC7t
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad5fe47 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=iSqtJsaWCaQ-tE2kz_kA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: xspO2xtHoXChfs2XuMcCrCiJRmJchC7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045

Describe the LCDB block providing the LCD bias rails. Leave empty
regulator nodes, forcing board files to provide correct voltage.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 3911d6d0d2e2..8d2136d165b1 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -141,5 +141,19 @@ pm8150l_wled: leds@d800 {
 
 			status = "disabled";
 		};
+
+		pm8150l_lcdb: regulator@ec00 {
+			compatible = "qcom,pm8150l-lcdb";
+			reg = <0xec00>;
+			interrupts = <0x5 0xec 0x1 IRQ_TYPE_EDGE_RISING>;
+
+			status = "disabled";
+
+			pm8150l_lcdb_ldo: ldo {
+			};
+
+			pm8150l_lcdb_ncp: ncp {
+			};
+		};
 	};
 };

-- 
2.47.3

