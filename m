Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD64E73BD
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409162; cv=none; b=gwPnJcXhvNy+1EsTx11l9HjwkbHInXkh0QQ3TcUJ92G/5lzqzQDTXdl6EMxCgmXw2Qy27qo55HUsdlSJ6dIT5nDsLLmDv2guGebgqs14d/1eGNGyTZbzkIrRrIJhxrqfYarkzBUeeZLVZfvgULNLQXyv1gIM5Q9rGjci0l9/THo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409162; c=relaxed/simple;
	bh=5j1+5gWDZPo/v74nUWVlDehbVbzgsxlj7niMYz5yZPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kz8AoncN9wLQTjSMooysKOrx06+zrsBi0jQyvorYVuYHcElR03fVDCGhheLi6Xewv8MEmj6mj/ZmwVnCWtGmEsJiScO2/BtodtRTeN4Yx2yk0FdsGNh/zSPSmRQWHG0aShLow+yXY8j4hbOApdKz4HIyoR7kbF8mOamkr1zHZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=feU0h8Ze; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EGf4LkOv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="feU0h8Ze";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EGf4LkOv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8PEAM2193438
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpTZBuo4GWUkvLx9haahL/OS0k1KfhQyJgJvKZBWP9U=; b=feU0h8ZeXYHiiH9X
	eoKb3NhJ76nB1ofJYJQssWZIzNApbA3KKqsXVseIty9J0jFcSv9g57EgVjfIJ80V
	FXF1Hd7oBkvES3EuJ97hzcScQqjy/4+Ujm0vN/RTFWqiAXXNKR+sH5svsvsdYuj/
	V0aEoLQNvg7offPJn2HUFrfukei0vorwjdLg6kpHozhUmvN3y3gxbwz0HoGqTTBV
	JxnVsLZ+XOkaUd9dvnSQ0vEPaWCKPC4tO6XzOoojuGgBmpdPpBt8pHpPFzWh9Rzl
	WqZpNTwPjIp0Glf6uX/xdypLAwGlPgb86GMDl+JtvOF8tLZDnro00oY3qJvpu8hi
	l2Utgg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1af8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb71b1443so434289785a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409156; x=1793013956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpTZBuo4GWUkvLx9haahL/OS0k1KfhQyJgJvKZBWP9U=;
        b=EGf4LkOvWyt3S3VggbjMIZxrVNumJmofjXsJriLE8XAaVviBFNm+SoDkpzV3K7zEJj
         mc/b7nPWGSkXVqDBeTK6hN1oPqoLBfqoNK9ZIarvbq19yY2gKe+dLZThlRlavHiDTTiZ
         UkOXXwcbDwGRaMuhuReTZFLnVTgjrGnGb+OKYkR/XC5/FRPlN7G6dyNLhsI2pNjz5qqe
         KWrpCP1gWblPAZq9z9Fzs2jETmxvZB8JC7ytSg9JEt369CmSDl6iLSRM+8/5vvna1Y93
         nf4IsCytJZG10KlLWSU69gS6iAYFVpe1dxVKXQxAS+RuYFtfFG4MwVvBxeVUTy6EL1To
         v4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409156; x=1793013956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpTZBuo4GWUkvLx9haahL/OS0k1KfhQyJgJvKZBWP9U=;
        b=DD5S55IPBjfOru07bj9uAbT3JXrB8lhsoObsGr8l8tubIuZab1v7do+i2lqzdXw5Yw
         n/daIkDMET9t/O4T6jcJV6Jkm8b4LnVwyuUgWNkMnJYkzSsk6CTBcEBVL+GKvU15BDY0
         Vi9G0djt+eHECwL252cQXoxYnRT3mUT79D4KjCp/Q5XiEWIFW1QlUsQ4GD2yEQi8PwGa
         1I9vZ8q4d7yT3rpZTvEC2Ud6BFWQ9goYzagP+fSKWx0VX2RN3pESeJxkx1AilMK+XC+C
         5ixXB4C+YgBO9KUAduGSUspZcGYoRLjk4iBQ6rkabVEy9W8NsOcZf/AtGBITtjyBCMwR
         Wo/w==
X-Forwarded-Encrypted: i=1; AKwUvBwvKMko7xDQjIhv5O7BVEnd4CWRAxRsFacd0ANAvfyn1eBKC2jEgB0tBnEhdaLz/TJ9cg1LeitfvSa+sg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI7Xx5sBqheSTADIWWkRa3EB2VuJxe7Z1rHasDSfI72EYEAaGlF
	Pr1ZfSsiJ6G96Sxdjw0l8yIT+ufRQrekkwjOEW1UOIfRtxJDLWyCoS4Eo4oCyAWtNdstyyFn5An
	K1zc9wjG/tzdTX3MphwQGDvQBbXa5MnfFUb5zHjrpLucIVmrK7HWbQv4k5wDL9whZzw==
X-Gm-Gg: AYBFou0PzBUPE1vsGIC3FImUQWQeNR0MCzYohqC0xpNP21r/6khMQ8cxV+8Fv3UcWTu
	4TaT7b9/U0mmHAOuCD3lAmLjBkKkD21Z4AvAAE7y/cgANyGMI+aOMVvxto18zfAVcu9AenlX929
	JHIh1srUDtPBuE6n365WJ2vibVT330iHd1afr4HdwSC5VNbBjce7cTFlwS+MLTdyQc6dTkU4SD6
	WxWtHK9TWK9W0hUG+/36Uc7JlnOpgCo/oP/JYeZLaEnJj6EXTQi4k34OUIF2L2DLpEcERo1zoIm
	wGOtWwgX/CIflRLcLGBrVWTyD8PEuoFm+HlGZVkNhGs3wU22/4Ad/SZ9uTEhum806KqrnEqZQqz
	JQwetCE6GFBYMx5z+Y0uhSyAt9exK0C/EKaLiWSLKyanvj/gdtHwA+yZGIk2o/z7wPAvQcm9Dy0
	E7O866E5hJJAQU
X-Received: by 2002:a05:620a:3181:b0:93e:bcbf:88 with SMTP id af79cd13be357-93f29b65959mr1138658385a.4.1792409155506;
        Mon, 19 Oct 2026 04:25:55 -0700 (PDT)
X-Received: by 2002:a05:620a:3181:b0:93e:bcbf:88 with SMTP id af79cd13be357-93f29b65959mr1138653785a.4.1792409154919;
        Mon, 19 Oct 2026 04:25:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:25:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:39 +0300
Subject: [PATCH v2 3/8] dt-bindings: mfd: qcom,spmi-pmic: add LCDB
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-3-86c05068efc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=889;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5j1+5gWDZPo/v74nUWVlDehbVbzgsxlj7niMYz5yZPc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f45YrRHdCDK8bawXDs3JDG84GqSMd55FbwB1
 iURRmnFbeKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OQAKCRCLPIo+Aiko
 1fmSCACAe6SmTmaJZaTQrBt+Dfdyi5ffb1oQGY06s4FGLcr2y3TVD+8a1QPhWLOWpgLyWsvQ1dJ
 jahbLyMnTOxozSmpGz+gew9jTiT4esexYWMS0nC89rt9jGjG1x7x7OCYq7GMERuAU/vAuDCu9Pc
 TuLeJ+iiw1RtveSf+2Ed9fIaDS2lR9Dj7TcZedIQlLMf5mbHvhx3EIQkCLghCmCr5c2wxsjSCLr
 Nsno2PH+h51Q1ID9bhpYT0Bd6I3/XgILhRdD8VV6rNZ6sTFGfpNN3ETS3x1T1ih/1rAW9SNstDF
 UGBPaqAFev1GoAyStjNrsmNmIbfvJHAl5gRMokBuFfe6H8fK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXxm7MpDZT/AHt
 opnODnmpGnwoaMPCUx95u+1uCm4HZopTkez2F+TcrKxlSb3nlXr4Vppj/xntaKIhaU0bglSNLqN
 UDBkWyLgvgtydfNNpNffIuEVr3RATTA=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5fe44 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Pve-c2K1UEanVU4iL48A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXzgRf/TGU6teQ
 pRNFv+zvIjkj6R1o9sxmHwpceM8lF0qMuwesEFatEmZYo0OftNrryKSBFX4L05JyI0vnlshwScp
 PHwcJudWY0xBPauXKuU0sowj6Modh7X6r8o/k5Fm6v7dtbo6CfVNUy4MEMLROmHDvJWcf8gGB59
 V8rs33pMSi5OMul9AhFSLI9Sk0auyuapExaKBjOQ7dgho3dyCbvb28S/VFMKZhUpWW1g27qgRDL
 WrLfkMK4zLHi513y9DnTludCsRRnqD6WZQKqCHqGxZlEG9uNoVY9/T+CbkGl3D66TmdyvKttGD0
 wecZFYOpXquEhLoL1BgQ/jnx8Db9X2oaBfrgOumSQ7YK1xmlvTe8qeZrDlHhJxTaAqg6txxLqd+
 O3zt5MqQ8A8pKTDjBi9zaxlKv7FM7iC8BPpwhRPFFQekTE9mOT579pP8FFktM73ZvESa4MiKP5l
 SFHczxJfxoBnLYkDNbg==
X-Proofpoint-ORIG-GUID: tUtGWVEhp_BgN0b0DbMeIJRLFI2RbnID
X-Proofpoint-GUID: tUtGWVEhp_BgN0b0DbMeIJRLFI2RbnID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045

Allow the LCDB regulator block as a child of the SPMI PMIC node.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index f6534e9e9912..3ca32d741e68 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -191,6 +191,10 @@ patternProperties:
     type: object
     $ref: /schemas/power/reset/qcom,pon.yaml#
 
+  "^regulator@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/regulator/qcom,pm8150l-lcdb.yaml#
+
   "^rtc@[0-9a-f]+$":
     type: object
     $ref: /schemas/rtc/qcom-pm8xxx-rtc.yaml#

-- 
2.47.3

