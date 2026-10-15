Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CDE4AA006
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054737; cv=none; b=gKufY+z0Vv0z6/FDgYocYWeWdtypF2YMuHN19mu5zFYOOWhN0EtXYTDf9ALu2O9TPKPYKY/Ts7D6GYeSDzn6c8B+GfyfTtZv9YBP8qgT51r43pJzQ7EVmMQ6iDl5t8oXTZlzQ+1O3c8qqGN/klGChga+++hTvFOfC9aRSW9m1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054737; c=relaxed/simple;
	bh=2HxbKMgISR36NuY4C8FsImVcbMBzlwdgTiNeWWNsGmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUZD+8y+xpUsdPS2eDXf4ti7QyY2Ig03jVUlDT0p86535q4LYz+3HaZqZ9kK+SuhSZXkcJ0ptiYXIgBKxlnJ2Efka9yW8JoDI26dq4M6lw4EFS46Y56bwL250PmrXTAsXt17kPnX20daOYYo2ez9ZblNvTPUcrDdZ9CpvXf6u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OM+bP6EV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HRsJxok1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OM+bP6EV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HRsJxok1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3wZVN1889493
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U4zSLbAg/vbwlB+khcp4ptsONlZA9U1x5Jat1WlHBG8=; b=OM+bP6EVReFUco1F
	Kmu/RqgCuizgP5HA+X+h6sVifPNpBZ5iGlyFseUUg1gI8peNqCUoD+46aiNGLtyb
	lnrBUIrg1yCMq7XQYbxTYDCZWtTJ1iylSUUCU7kWWG+LG6DcfFDQuWk2i1MDO1bO
	o2AACIqsElbWSUgnX3+VbSzf3VBIOkGSrYH+OugJmahh5Qz2R7UhKXl2reqP07Ia
	b0QtV1g3K3c5Ofug5gAM5IW58eSaQ0K+Z1ravA8wYP8VdfmFq3Nz8FpQj2LeGpSm
	opCCLfz165btewNVWm846Yu7PS4mGUmVkiWuogvp2Izbf6xldvmV3x0wUugzYkSj
	aJ+jmA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda14x9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc0b31ecaso274218285a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792054733; x=1792659533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4zSLbAg/vbwlB+khcp4ptsONlZA9U1x5Jat1WlHBG8=;
        b=HRsJxok1k7HNNUhPMCgqiB6tKq1Gcb+XOmHly/HQJIeEqzExJEwy3zHBd9k6/HbBxv
         IvicxOdtdn6CORd4T0OKMcGKW5ZnjBrJ6OAMp7my4ZTbFHlwADlBzfOIy9zlsk+VSbUv
         fxavFTDE1Cytvwc/qWFy/E2RQagcZHppGDeJYCXccdrulwitemPOixgtor9qrlRI5Eus
         iE+BFVCRoMInr/Y/WQjJBNTtjYP+UXnD2r5RsYwOJIDVDC20IAWLZdEfVm/g117+FpJH
         oWVGTAt8a0EhG0AOjNKOP/PfRYzHKavkkI4hjdjlQVhegMEorbqCygt7Mh17OBdK1FrU
         E3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054733; x=1792659533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4zSLbAg/vbwlB+khcp4ptsONlZA9U1x5Jat1WlHBG8=;
        b=bYdTeZA5XyHLKPxjy4ZyQXWysl7HrOjsFSv0h84egASij2Mv3aSYbUgyysUy7y8HzC
         r1PwQqFVJgNKK4lNbqV1n7z3caJu7JcIofLOT9xVENOxz0jC+LGk7XBJTWiOmaBq7yS/
         p31Kdort9QpEd2bC1LgxiWTV+95aJ1hZadIOL1Mec8npgS2KLfRvbW1iGoe5Ccpma/tI
         RaLI/9crZBbB3nFDBT2h1wXOK0KJPQxSVgq33esfQPs3MQlesiXKpW91IKPP8mOcZvkl
         HX/7Zrs+bOTvNbj9qU7IT8/UJDfYyxWqXP2+OkUZD/3/GU33/uIykE4x6FgUNdfpBMND
         3N/w==
X-Forwarded-Encrypted: i=1; AKwUvByL8nS6q71qnryfunxuYWjMh1obsBONciZ3XvOsooadl0UwAbu7cXCfS1qR86k19rCRnE/YkiVXNLfwsA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9lgRo5KAZoAFOgnwbl9hhZ0G+Ykm3OyLkreplkPKW0dmf8dza
	mZlz1r2zkwy0flAF4E9Q2peoGfBzYSTo54mkPuuAaG/AIAWfNP1Rf6dnRm0SIMITIHGM+/k1Fzh
	bHYp7f9ZdgzsIdAKTEzXHsFk8rCFTMGPVduMrI1C2BYFKjONG8eAwlTayPD9cxKsMzg==
X-Gm-Gg: AYBFou0GhKmzLmS1Y5N6t+VbSp5NrTc+nBIy12wf+HRRcJtkvmusWtRXPJcs9NDPAyU
	f3vOsFkI2jobd0jbGcN7uJW+bB6AcGd12SpsYrw8T3pIFTqUDzoutgB80H128hXE8kucd9jdKOP
	1nSxqQZHah8zii5MjbKQHVfaZpqM8I3THAqLa6pD9Yb3NLRrU8XRF4mmxdwlpEffPmt6qvwWXOz
	0rjuiG6jg9SRR/FzFTKaSnAFMwGfqzZtm0sAviQ989k+V7rIWa8t7DfVP+tsyCzjHwW8tFS//fz
	55mVnqNoLZwTKXl3JcA9hL2r1kRRDPv6nXeuRZPeSB6HJ+in7t9cPxDlaL1XxaAxoi5YI2UnT4f
	1c1LR/3SfJv9n0JhETYUWBO3Z503IaGt4m+QVJ7BbiOAhqtDXDOa0aOz0CTt41VEp9N+XDGbqI5
	kUJKXg8MBcTsoQ
X-Received: by 2002:a05:620a:29c4:b0:93e:fa30:f1dd with SMTP id af79cd13be357-93efa30f6a0mr1113601585a.70.1792054733436;
        Thu, 15 Oct 2026 01:58:53 -0700 (PDT)
X-Received: by 2002:a05:620a:29c4:b0:93e:fa30:f1dd with SMTP id af79cd13be357-93efa30f6a0mr1113598785a.70.1792054732995;
        Thu, 15 Oct 2026 01:58:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:58:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:38 +0300
Subject: [PATCH 1/9] backlight: qcom-wled: fix unbalanced OVP interrupt
 enable
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2HxbKMgISR36NuY4C8FsImVcbMBzlwdgTiNeWWNsGmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXD/8HOB5jgW25p8UZfYUn2vV689TVBeZYT0
 2pF2AhOLU6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVwwAKCRCLPIo+Aiko
 1QLXB/9omQO3ECKe1kevnZE9IomUsynXXe/Ko4ChnIc74C/EK4IpBaNiWg0LR1I9CwDMqQii9A2
 d5OL6Iu+9yZ8C8dlZiRmIo9ddGFbbRrysmLmCuiVBaa3h6CudVIwJD7lp9YaBF0nvAL3S1KrHBb
 ngZ/mMBJzFdjlnmjOmDIWxK3OFKPUZiGPpJSUDBmkDpL+O/00+7S9znMttdIpuS867FN0PENPQx
 PHZ9hKxuDjnpRU5jkO08PLq9dbHnA4kfYwjDy5h7hIAb0huK+rqWXPaoRTCkI8H3cxcXkTl2WSG
 wuf6arG2YJeEc8OcrWagwZHqRd2G48OahbualL6t3bavfhdr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfXz82lD6prWljK
 5wbBaddjpCe+JVISfn97+qdgkKU40sT97d+XZ+zp4YaG0WJsMrDaMdMrDqikLYbyfH8noNWxazO
 d1IjqSRuliGUm2gJR1llMuLFlNGOA5U=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad095ce cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ov7LMV1X4ZCViyyWaGMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: OH8LeePFTQXOVKJgBx6kwzivSk7LFTlE
X-Proofpoint-ORIG-GUID: OH8LeePFTQXOVKJgBx6kwzivSk7LFTlE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX4Au0muHOt1pX
 wA3dSwThHChvWifrF9+iYdDoi3JuOamN0eVeqQv/o61vBonr5NwslH3oxf4zwqaRy4JE/m4t2tF
 JlJlqKr14UeTdbqF2dPv/Sa6Ez3JcA+JjgSo9JuWkFnYt+KvmvlvO2M90b4509iii1cFD/E0tZ8
 YgBFTE7xjqEroe/aREbAThlrIkF7MPe2kl5hw+oi+ciS5tWQMZdHcS0xgquVfN0KGQIAq2PZmYW
 OdzvZSiSzX6iT8GtXtnJvlKSASwmARYE7Qf1v0Rflrwxfinx77j+cxWFA/HKj0/alEjrhCKmXRC
 GL6Hm+FeXGL3NHN4DKUMpBv/SmcWSu+aHRocIU/v6BXcYQc8hCMEeZ9B56HGicdPIJjnveFv1KM
 WCRPBB8R7G6FQxvsjXhk5a8AaN+j0EnQ5ZUYE1yeXa4tUmnmf/L/RRvCW6I9JUaa7az5TUvn44E
 CoEM0DPd2sGRIgQeZYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035

If the bootloader leaves the WLED module enabled, the OVP interrupt is
left enabled at probe time. The first brightness update then schedules
wled_ovp_work(), which enables the interrupt for a second time and
triggers the "Unbalanced enable for IRQ" warning.

Track whether the driver has disabled the interrupt and only enable it
back in that case.

Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/video/backlight/qcom-wled.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 650dd95f06ef..f2e0430cccbc 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -199,6 +199,7 @@ struct wled {
 	bool cabc_disabled;
 	int short_irq;
 	int ovp_irq;
+	bool ovp_irq_disabled;
 
 	struct wled_config cfg;
 	struct delayed_work ovp_work;
@@ -294,7 +295,11 @@ static void wled_ovp_work(struct work_struct *work)
 {
 	struct wled *wled = container_of(work,
 					 struct wled, ovp_work.work);
-	enable_irq(wled->ovp_irq);
+
+	if (wled->ovp_irq_disabled) {
+		enable_irq(wled->ovp_irq);
+		wled->ovp_irq_disabled = false;
+	}
 }
 
 static int wled_module_enable(struct wled *wled, int val)
@@ -321,8 +326,11 @@ static int wled_module_enable(struct wled *wled, int val)
 			 */
 			schedule_delayed_work(&wled->ovp_work, HZ / 100);
 		} else {
-			if (!cancel_delayed_work_sync(&wled->ovp_work))
+			cancel_delayed_work_sync(&wled->ovp_work);
+			if (!wled->ovp_irq_disabled) {
 				disable_irq(wled->ovp_irq);
+				wled->ovp_irq_disabled = true;
+			}
 		}
 	}
 
@@ -1649,8 +1657,10 @@ static int wled_configure_ovp_irq(struct wled *wled,
 		return rc;
 
 	/* Keep OVP irq disabled until module is enabled */
-	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
+	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK)) {
 		disable_irq(wled->ovp_irq);
+		wled->ovp_irq_disabled = true;
+	}
 
 	return 0;
 }

-- 
2.47.3

