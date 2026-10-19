Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4C4E4C2B
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409158; cv=none; b=ti0Xn2ypLnDfiCT0Tlb1yXGq4I4oASRGGkgpemmfEws8uu/gKjlRaL1SVSlm4XUPc5+fbF1eB5t5wOyXaxDw4kVNt7KnWlPvzmIUwljKNZGCDPA1rONmNsBLt+VzhqMmsKoUxMJjxb2AIgcU5UgRDKVbVXQCrSCcBi45PgBVBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409158; c=relaxed/simple;
	bh=3nXXqhpzf8K/+hXUe7l+H8MG2OcKbb9smch8ETujRsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfmTX88Icc5Tjjy38ocZo4wcteEz9bLBVEOPwVNn3KlSnqyWuadaZ5yq/zQQfxY/7GbxuTAnbEfjeWr3Of6fsMGe0L68j2H5HbEIHmfh6LEGQ/E7DFAH7wSzoR8DQPOQl6hYv6UEHS/6gEyMxrLC3zGmN0f363IGm9Wyn9LXlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UIFem/zo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YRIed5od; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIFem/zo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YRIed5od"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OwMO3256648
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6xC4OVordP6iIQiBzMB05d4qBQ+iHW7wsc04Plsjz2A=; b=UIFem/zoWNDHQCPl
	3DA7+TickshegyHDg59S4MZEFkAYyvMUDurzAA42UiqpF3CVDAcFIE2xvTZViT9M
	zjOSA0QE6Cfi/QqZmnkZKU7rn4dtlWxqBFw+lQzFTNxQViCoiaMVGkpmrzqCMPVy
	lScB0WeQLD+wGCNTIo5dx8X3RwleXaDu2NzM9W+uZX4+FAn6QZuNQIyvax2/AZTM
	2N9x9AVPj5IJO2Foclidry4TBDmRBNTNhd2FDQ9JZXvBb9FGH4Q7u/O62nTDEn8x
	q2V6yEKVRyO8jm48HDr+5wfL4IXnC2U2cBvPwfTRxmSyUfxKLYT0peLXpPO7a3uu
	rDgLkA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8tjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dd3c3badbso479232985a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409152; x=1793013952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xC4OVordP6iIQiBzMB05d4qBQ+iHW7wsc04Plsjz2A=;
        b=YRIed5od4JriAkw6+dvb9Giz3FHCF8o6vmqbbrxeCw8OXC+UuTCo2NRK3dxP2442Cd
         1nGbJbNeLOHUJ++Dw+U9V4tGYWR+j7rwh7SgXsNEWuA6D2+Tnw0gweafM51aHHT8X1kZ
         iX93deZBElWXmC+Ma7N7MdcnA/Ab7dKJ+/33dK9IFNApIJE01FiRzCLU93MWTLvv83D5
         J/+wVUrAzSbAScJfARXEEYU67BZA3krQdRGpaFEGQp8zpgvGT4jgw0/jLvPbm9qm6osT
         ujjkuCANQ0wIKw5tMZAY8DkYj1+/J36qm4WGpEJwvKp6NqPETiI6UmcnVRA4lrqiwFvZ
         ZV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409152; x=1793013952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xC4OVordP6iIQiBzMB05d4qBQ+iHW7wsc04Plsjz2A=;
        b=SAgZWDE1l6xVeNZ6F75VWL+lGluaUjWlEL3dS88SF8gbTF8b7TYopIqBcrzFLcdE3s
         ords/CFU/GwbrNCL4JylGf7kFNDOIT7CEtbqTVasBOUbj0rwDfyXSI5HDzgcN0BstftD
         1q8fuXx9oaihjLvqP8kBeRuEVHyHLHOS8UEhddItBG/OqlODpx0dXG9Hje93c1oTm8ff
         mw1GPujHj9/QpMFCq8qklxMv4r4+cufh2Hz4WqWG97v2S32zC+OgOE+Xk+ezYn+E1cDg
         UPNG1ak+foQDFG7KfYbz4PtQQ9njaKwWkGJclX6OvHWQpArCfUjtWtfGCjtAGWaGArti
         oWXg==
X-Forwarded-Encrypted: i=1; AKwUvBwlvGODmZpO/jDOhsXrYzhkpCoK1LpvJkUiylOlkKlHGhx5Rwfn5daU0Rr1TtgbfojmmKKGBgspLhj2sA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYRNFlgOPReHlQLujKMqXsiWhGLdXevrv3OMtOWjowVVxeIkxp
	1H3Jct2f+NdUCbBrTOV6LxijDE0PudDiJHa8VPKj7y/FqGOWcANXMPGaw4zcSO133GprmioZybA
	6/DF+/gbeNDMOtQNIBRVpHeVOqgCEopaWMK9yr9IWPByluwF0MgiOI5upfUNWoP9l8w==
X-Gm-Gg: AYBFou2c0ccoC2vJy9AIklcmEnoZaEbAzZjQDarHIOOHT2AGCcHmxRXdD7Ly5AlHV8m
	d92IXg6cqnbwi00PUeoK3N4AtUSAP/obAta2WUUcenS16E+T9IxZD9FpBM3P4iPOZ1D8+O+E28T
	Sb4AySUcZ5N+E2tR9Z/cJs/k3qZOV9ORQG4QXWN6Ebxprjga5c/Tr9p/TF12OICHkCv6vCHoD/p
	AeJPgsHvCRmKG0q9ktOwrF4hjbXJ1yWHIY9wXEi8vqvfTTMFdOAtShFXgLp2wSwPsdwS3KfE9D+
	W6mCbLgtbFrTtDzM6v9U7MifNI/534TVrxBW5XyIyXJ7vRFdLiyPlnHh5zLVBxZ5amITEJxjRHJ
	5H6PcqSfOFOp4LC5Syo8/4i2ErJxcSJ3kkDA7SngXj850cXCxJFLel5R6i/WkCPaCyCyU7tfXvj
	VaQPWN+WF6rC2v
X-Received: by 2002:a05:620a:4589:b0:939:1222:b9f1 with SMTP id af79cd13be357-93f29a04e12mr1226297885a.0.1792409151696;
        Mon, 19 Oct 2026 04:25:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4589:b0:939:1222:b9f1 with SMTP id af79cd13be357-93f29a04e12mr1226295185a.0.1792409151143;
        Mon, 19 Oct 2026 04:25:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:25:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:37 +0300
Subject: [PATCH v2 1/8] backlight: qcom-wled: fix string detection
 brightness on WLED5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-1-86c05068efc5@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3nXXqhpzf8K/+hXUe7l+H8MG2OcKbb9smch8ETujRsw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f44JBbEvJI7ao/F7pVDoA9QA3FdEnuTWMXG1
 9mEYCtrJkSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OAAKCRCLPIo+Aiko
 1eB6B/9XXxaG1spzShZks/wIC8Z0XwqpE6aoNNn8zhK4sg7GP5JCjXeYh/h1U+9QR/GK6j7xTto
 QFOmZ/kLOfZXMqlVlposw0b8AuIu6Z1WOyWcfLDbnl2vxLekiVTxa3V9TRPKm7IbUGzY7j4ansr
 Ru2MOcMUt+lPMfvMHUCOOusAb8sbx7zFrec5PgQf3+TWLmM9jMj/TWFLKhLt6ZMwDcc9jfC2VF+
 VdJ31VYpQxu0SDoP1qGKN26HhsTuujZYrCgkHwkj3oV7N9+g9BzgNuQzkBdMXoQ1Hkpy/PZp9zc
 EjQKQZk2dTjqHc319u+F5r2KaBsXFiNcuAv5fPvLH5GkHDas
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 37lCWV6cG8d-PhofsZUTbAt65X7L6oVr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXzhO6j/Ek2KJ/
 geSXsUCFLWgfGquNxFwH9eDEJfEndg8mShonxS641K4Yn9z3ra4PSaRb/WIRyGiogqgLaZFM6MO
 lQ8T49NIZ2du6AMV3lV8mbBTdcnaV3HEC9h+FsoX3icIKtMvOgohb4bGVXv+zsfIyVQP9sxc0x9
 O0sYW2N3oasOC/K6nqMakeF+9seVkAloFP9THn2pi+a72wOw7YOU8QYb2VgKx8wDoxArZE3JGIV
 QV9DHeGqDnAE73OeS/v9TT+rsqDtEcQfiJYXR7wrwRU1FSV6i/FygvCC0GFRq8IHYUuMoI0VeNO
 rdk38bj8rDIXfHn1OrqCY7+/FaTHeom+RoveQOyEa3M068vy+Kp/pxsoowLEq/BkXMQT9t51LUa
 AbTE9YryI8AUFQ34eSUaqWT3a8OfjoPrl/S642YH4bHBBbFoTnmU6VykFYSPDxTcOMDk8+7/Uhf
 VuIUGpqa0CG5wiL2zpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX5H14icpO5Hh0
 Cqzuby2KzVHCowBXWrR4LkBnP5bGtmBf/kNp+JCrmsxif+39lzs/1ohKgi/UTPeBUx6gQeJciSy
 IFnUNZHE2shCpYw0pp03IXfl+fu/Jeg=
X-Proofpoint-GUID: 37lCWV6cG8d-PhofsZUTbAt65X7L6oVr
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5fe40 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GhjHCLKht-b4gqHrCnQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045

The string detection sets the test brightness through
wled4_set_brightness(). On WLED5 that writes to unrelated registers and
the detection runs with whatever brightness has been programmed before.

Use the per-version callback. A WLED5 brightness write also only takes
effect once the module sync bit is toggled, which so far was done by
wled_update_status() alone. Toggle it in wled5_set_brightness() instead,
so that every caller of the callback gets the new value.

Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
Assisted-by: LLM
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/video/backlight/qcom-wled.c | 56 ++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index ca350f320e17..c5243a6d547e 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -269,6 +269,24 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
 	return 0;
 }
 
+static int wled5_mod_sync_toggle(struct wled *wled)
+{
+	int rc;
+	u8 val;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
+				WLED5_SINK_REG_SYNC_MASK, 0);
+	if (rc < 0)
+		return rc;
+
+	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
+					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
+	return regmap_update_bits(wled->regmap,
+				  wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
+				  WLED5_SINK_REG_SYNC_MASK, val);
+}
+
 static int wled5_set_brightness(struct wled *wled, u16 brightness)
 {
 	int rc, offset;
@@ -287,7 +305,10 @@ static int wled5_set_brightness(struct wled *wled, u16 brightness)
 
 	rc = regmap_bulk_write(wled->regmap, wled->sink_addr + offset,
 			       &v, sizeof(v));
-	return rc;
+	if (rc < 0)
+		return rc;
+
+	return wled5_mod_sync_toggle(wled);
 }
 
 static int wled_read_brightness(struct wled *wled)
@@ -391,24 +412,6 @@ static int wled3_sync_toggle(struct wled *wled)
 	return rc;
 }
 
-static int wled5_mod_sync_toggle(struct wled *wled)
-{
-	int rc;
-	u8 val;
-
-	rc = regmap_update_bits(wled->regmap,
-				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				WLED5_SINK_REG_SYNC_MASK, 0);
-	if (rc < 0)
-		return rc;
-
-	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
-					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
-	return regmap_update_bits(wled->regmap,
-				  wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				  WLED5_SINK_REG_SYNC_MASK, val);
-}
-
 static int wled_ovp_fault_status(struct wled *wled, bool *fault_set)
 {
 	int rc;
@@ -494,17 +497,6 @@ static int wled_update_status(struct backlight_device *bl)
 				dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
 				goto unlock_mutex;
 			}
-		} else {
-			/*
-			 * For WLED5 toggling the MOD_SYNC_BIT updates the
-			 * brightness
-			 */
-			rc = wled5_mod_sync_toggle(wled);
-			if (rc < 0) {
-				dev_err(wled->dev, "wled mod sync failed rc:%d\n",
-					rc);
-				goto unlock_mutex;
-			}
 		}
 	}
 
@@ -651,7 +643,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Set low brightness across all sinks */
-	rc = wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
+	rc = wled->wled_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness for auto detection rc=%d\n",
 			rc);
@@ -791,7 +783,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Restore brightness */
-	rc = wled4_set_brightness(wled, wled->brightness);
+	rc = wled->wled_set_brightness(wled, wled->brightness);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness after auto detection rc=%d\n",
 			rc);

-- 
2.47.3

