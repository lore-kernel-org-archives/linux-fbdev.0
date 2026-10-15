Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3084F052E
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054752; cv=none; b=W+EZZJmnojbh7WRaXDm8Koip3OaQ5+nHliugEoNSD5PZd27JJzk7Nv+X6+dX3KZ/av9b6yv2IOoLeabao0k+Jd9cJ+eLzpVqAF/V/9+kWYCPBO390crh2cuawbgHrqkChyKeKAoSoNK05k9BCuAZQhTeJDrpzTosifaS2pw7Mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054752; c=relaxed/simple;
	bh=xBbaNwaZ04U9vu5xMLAzqewhXtCtgpwBmq9365lh0RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEnOY0jHqPtEPIknTsSbFwGaOhvkifNcTzsYBBagg+8zA+YbW5fmy860AupVuF8t83tB/TQzNujHWDmM+eREJiE80l7xKUiDSOIeDNpvVZmzSUVXKIY/KNW84JpTwdW0lMB1qsQ4LHbO3L3un/4dvkL8pEt5MBi/8jIQSFqhqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cf6dno0e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AuoizofG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cf6dno0e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AuoizofG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F7rYn71707325
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SN5oCd+hB1kN6I2RUJR2/JZbM+ngr/PeEqa7S6xoQS0=; b=cf6dno0ecdLTK9C5
	A9+Xyr6WvOyg4SDyK5jrG8l6nCbmLIrxkT4PaHQ9Qogaiq4Orr3F3GXJoRU2MUWv
	f0ia+l61o/NzIyDL91yxDby5fVZlV+MneZA0ZUq6+N3IRDEw7nAURV5mcw9ODL62
	iiFdugaMtjEOFXHhS0QDoe5rUUSqoetFPJev9gJ8dhz6KNLPhZ6WiGMDpApngRp5
	ebl+O6j2b64DGNetsYads+vF8RSpc5Hk9tqPiacO+xGJnVNon4tZvYBD291tbg7A
	Lp/R/+VGZuneoQQTf0D+dJGpSkrbEHOXelcipNb8Kl6WYqbi/RdWiF6dhObq3653
	t7p8GQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4han54snd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e46b4b700so224094785a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792054746; x=1792659546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SN5oCd+hB1kN6I2RUJR2/JZbM+ngr/PeEqa7S6xoQS0=;
        b=AuoizofGJbscgJbKp69Kmt/sjMZ96hwc0ffS4JN880ThOUXCVDdCY62tTV0AnhVCvL
         M3LE4eq7uOf3AImSjnQUzV25oPA2UIzFAQNIYKcw7mkJsydgXvoY42fMy0mD3ZgSOgd+
         XVMtyrTpDYcSaU96SpAPe085j/ezPaB9fkgRqfGin+W9V/ILn89KE1yvrFJfYi7Jr1Bf
         srZMVWSROVb35bSM6QtEl6Gmzmz+Ui6kWHNxEIxgR5gXPjQKS+ch9LEx3QxbbMlBfXOu
         2WsJQ8cpD48phEkuixfF8hrxK7dTUeA2Ubt9d5W231sDNHwb2YaiHg01e5vpPkCBU//b
         Hmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054746; x=1792659546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SN5oCd+hB1kN6I2RUJR2/JZbM+ngr/PeEqa7S6xoQS0=;
        b=uZkweIeTMy1gfNlzO0tOYttMYiuKxnReNvt57XXN4/iWgjToXNA+75mObK0NRe2PJn
         EvUJQSrPFbOEwFWQtWEJ4XJmkAaQRKcDWq7yiFyHLcKt+gs8Y1HVAV4a9LTYTx5KYKlX
         3g5Cf9p1te4lnEh0JzSsUh7Gm3+WQKBkrhBxkrG9FhquOVoGTPQD1prqA2J+Dye9hV5j
         qsKLfw801KXnIIJ48ZHndxnFwDkB/17na+enYY6pbJ6KfNi9CcWEdLLZeW5AgJUJEaqw
         zKYk9C8RqH3/ZSuTRteqtoCRXtzgQd+hmtfC5P9C389zib9N4s8SAKBM63x1OoR5zArM
         A3Ug==
X-Forwarded-Encrypted: i=1; AKwUvByUj3y+zjYY+bcliuT//n6Ty/Tj3n6yEoKx8ICOokws4dnQE37S1FvhZoZPByEX7dl746p7nzXV0yRSHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLyKkZKLJWbdlbjup1b4XwS8Jc+rweka1wxark3682lg2NVLnDx
	7wrKIcr7XFSTyhLivHov1Xh9Yk6sLAZZgaFJTnOmKqn4xoQaP/jJX1AlxuZBXlG2g4ahOBRz3YE
	d7rFXvj+Qf6/gtcoQpI7G3ryS4jxkMuOSJ07qKKCWTvYfjd1Qc1Ee1dAGH1pyjUSCoA==
X-Gm-Gg: AYBFou1RK0dXMbDg3vA++Z5Z8UwqkgtuIt3Vt4+coYNiwN4xhHrsgj/vB0picI0v9dJ
	nXvGMcBpzgedYDo1Jl7FN8oeHy/ydr6croT2WTr8cumMO2gMz8UR/GcXKD/MO+0PLA08ukuthqp
	1o/y+5hql3hl/KKXdqCNo1HcBn02nMrQU+lO6rVWiH48xw2kOruR6McGR0qpuVltgZ68AsNFo47
	wtgFOULi6EsFzYG9P+7qb7sXEE0irR5Ry4v6NFtr3eSj9IL1Z6KQkvU2B608v5LO1yuEVacTE91
	qDpALn0M4PNwBxPqFftw8v1QiyTLJQJg8gQhG2AvnfnAjMw1ZC5bJgoAsw4vcO6it4eEgup0rZ6
	MyTZFkjJHcwa0D1Yre/nZ8QJGzY9mEooaf/tPCcAOW1JeKYm+WvdIdLw13RL//FMBZDnO1PAa7E
	hKYEwc2BIIa6u5
X-Received: by 2002:a05:620a:6489:b0:93c:6f06:8f7 with SMTP id af79cd13be357-93ebd20830bmr2693241285a.36.1792054745958;
        Thu, 15 Oct 2026 01:59:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:93c:6f06:8f7 with SMTP id af79cd13be357-93ebd20830bmr2693238285a.36.1792054745505;
        Thu, 15 Oct 2026 01:59:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:59:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:45 +0300
Subject: [PATCH 8/9] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xBbaNwaZ04U9vu5xMLAzqewhXtCtgpwBmq9365lh0RI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXHgIL+ILyWEGstfQf8V4lw5nKNfZbOlQ6Ls
 JoUbd46i3yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVxwAKCRCLPIo+Aiko
 1VJaB/9k5Pu4lNZ5NrTjERYf0kQUmOOugVGCg+f56hXaS9WyML/RdJFoZSw1QgeWJdCZU206QDn
 TEmCrYkOuwLEFluHrqIzBvAZXz/Fs935E0zcQHI/E3uR3ISKlqR+urAmffPXe5Yb2kVytPoGLfz
 WNz/6sJJ8FHkVKmYSiGECHcfOVbvoR0FnJfwB2bSUBpqScPulDIKRQqsy2r7sRaSrMuwEfoZH2o
 LCSMuO3uBfZzwtmMIirwn4v3lLlHY01VYpGnxf65IOu+KBbqpyyb3hxnLwtpZYQEnguJ9eAXq1f
 fgsVo5CWGYYnPYNKZ9s5OLZztUyf9lJY0mi6Otj8qWRp5/QY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RYQFmFtv c=1 sm=1 tr=0 ts=6ad095da cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=LxeP0AzRrgEWglGlbvkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX5IpmNurqFr/H
 /kOwPuoewISq3cBckIiDSYv7u1AylcGl2Wu0tAo3f6JH1VDlzF9zp/DZmEWRxmzV8GcOKZcQov6
 VgKm0VNq2lznLxCnIx44RZwMX/Br6JfObRKSsIiG86T5/uFkZHzT/DbG6xWIN/EAzfTjMHc4RUm
 LADwoJ8u56u3KKXp2mic8ygvyw/Rp+bz1bI/HEDrEC2qnG6E6ssbSdGPguDEEJLINO34G5Qe3Uw
 INV9WvOu+fXxw4D30KYx+nOFI32G6pSvNU4Rr+8ll5ElyEPKVN5iGK4CGs956vqPOofBTdnquZ5
 SL5/V/OO3sfyIUQiitfEaIQmta9lfwEktKXHj9z7qIEOlsz3Nt+PzrcsK/Rc9EBEqovQDC1ZorD
 FChwT7JL/auesOX4SsKm1v1Ah0+sKYknpZedGQIc64aW/zvfrKs3gOSH3RRQ8egac3RvOAAgvTM
 hV7Aq1Ri/OTBQB4bD1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX3+SP6ZKera7F
 I8rUWVX9yOcI+njMt/Lod6VPhgqOlJNEBxdlqK21WN6ciqnRn1ljtJiNJls++mOMAA1IssX2vWB
 l9VhoDUCW8J8qpTVnP7P3iNmBaiZQo8=
X-Proofpoint-GUID: dSKh2gLzOJdYTZY5vOSgae0-_EXUKFVy
X-Proofpoint-ORIG-GUID: dSKh2gLzOJdYTZY5vOSgae0-_EXUKFVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035

The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
the wrong address the mux driver fails to probe, the Type-C controller
and the DisplayPort controller keep waiting for it and the display
subsystem never binds.

Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index cdced5c848d3..8f4ea981bb89 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -434,9 +434,9 @@ &i2c4 {
 
 	status = "okay";
 
-	typec-mux@42 {
+	typec-mux@43 {
 		compatible = "fcs,fsa4480";
-		reg = <0x42>;
+		reg = <0x43>;
 
 		interrupts-extended = <&tlmm 152 IRQ_TYPE_LEVEL_LOW>;
 

-- 
2.47.3

