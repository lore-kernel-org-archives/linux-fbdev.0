Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E94E66B8
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054738; cv=none; b=t7U/FrD/wHeyIGqyV7uco7rCSzd9c2qeuhifmcdlD5KP/MzhAWBuR9yLPxWY/D8B8vvuKRWCOR/1DuEpc14TXjdMaWAdDjnZdgul0FAoS42CfnAOCUaZdnilyiNyl6v1Srk4PlcBkMrKxNQ7+ZYnLcx0NhGzz8s61LfUoxMToqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054738; c=relaxed/simple;
	bh=bW8kWuHi0rdhUiH2MmvmuegVaB0kaQIgT5fkySeoKIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q//RXIdKMLsVti+wM654dimh0bntCacnj19s99m1FC9wW1qv9UPMd/Dw9Y4PxOCENYSXanyBdlxdyc36Bgc6ZDkNjw8a3MxRmfWi2SlrcsMNZV8v4Y60w+nyx/DCY9vsgLiy5bu/CiRq0vXhIrWINUXae5Hk4u0QvcHyJj0dLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X697Fs0I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OKtuslI0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X697Fs0I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKtuslI0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F8w0iw2885891
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fu5asBWsdvZx56+/lcE1g2WUnCmTjVqkOuMEFTUOFaA=; b=X697Fs0IdN13Qryf
	ZNhc2bA8OX4BO3VAw1w5Te04sfP3+bIHx9kTu5yyBtwKRS2O0EYgGcEWzz1Ieo5w
	HpQaIiUUG/n0hYXrqCJQxgyQXFdmfDVnJmffumNjoSTpbkK3KbPJiaBZUxVcn1Vy
	WdFlHFHWrhq9KYX8W/M7gyZQE+CyKWkZ6R0EOxgvj3APXvlQOaY6Q7nIbGtBeqam
	KFK9F0k3HtS6FoZxvBQ++x2aFaxh2g35y2QZuaTTZ2OLO4ynr6Kvy0khiyI6CfRw
	0TMxcOaUWevEpNrDfbyJSHu4+EPCK2B7XT1ru6bsPcS9/Qs+po6JuBtqWTJISerJ
	yAF1pg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm006y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e46c120dfso164209085a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792054736; x=1792659536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fu5asBWsdvZx56+/lcE1g2WUnCmTjVqkOuMEFTUOFaA=;
        b=OKtuslI04q/WFhXXSREhBU9HeVzwgmcE8WjM4s2Htl+vxMahsYpITe4Kwqr9z6i9r4
         GE3fyne6/6ykHFSynNTOvO+Elj4fwDwvDtdEbceK5ZSkF/5o3gfs7nj6smqkd3cOirkH
         5+xE5whVGNl38Gx954atN/+ZIrbT8HZCP/5Y4uvLNXv8zGerczeAOwmErt2SSrzdr+pL
         yUnAAIWXa95pr6sAeixDwazXovUMGipCGz+FhOsPLRyTAbgBm8qw4v9Wlp0BNDeKgEOw
         dxchXMoGrdFENKyaEChSAykwH5lo6tDBpa7UXYVSsCaXQtesEAV9nwYtqtEWt/WCjzRb
         9LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054736; x=1792659536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fu5asBWsdvZx56+/lcE1g2WUnCmTjVqkOuMEFTUOFaA=;
        b=EsYhZ7bDdKQbwe0rORH5CCTf2w00rfZ3dVTu1aM5NWB279MVPcO6GkXMds1ObVSaL/
         yO67yxyWFrZYMAZAsGw+SKm6eHaIWUuy3twb0w5yGil0rdZTz01i4Dxm8jshPCRd2swo
         3mUqXh0i6q9H1wvfiz9gw/FFjp+wJbhgGTmIqyoAfca77vmyqWoo4kDePMq1s1gKWIsB
         8p7aHPD7Od5OVz0MhMKzU4cmCi+6VMFXyMyTXCb2Ytc4vZzsvQ+0Fl2Nc4hWjEMRRmA5
         mSLaL0XLgtm177qvbwNoe9gToRNLGQIxkKv09RKz/38KHoNCA387RwEY7DTFkbUYinZX
         0bxA==
X-Forwarded-Encrypted: i=1; AKwUvBwfOdtUfvBw2+r+bE+y/FMfbf6PPeRqTy/NXtjIy+J/HfXMHFyJKSBirt23OeJA5KPMoebOn6MrD66MDA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9CxQ+Ivcp/OkrjZjWy3eg6bPE+pXcSSwFKLptHRsdlHUgGFUy
	7QQHvfC4yxaVw/EusYwYzutG6tEtzkuJnryAII6Ht31c1POTiyUkI7uo3Bh7jT+jTvwlVIw2DAl
	Il7lte73/pNdNCecNGvDgBY6I8pHQPPrJRnCT5Qd4kAJIQyTuRNA6VSgladDWqp4lNA==
X-Gm-Gg: AYBFou2MgF39tnu6ju0VUVf81WDsv1PEhFhZj3UJGpB3b04eij43o3xUSwY91zRRQah
	p//4VEHaisinR1Cus0HNnlAachqVTkAPzUmEQzlIP7OfguIvOg7ZBn3X7OiLUgKnni0f6g58hDa
	6bXpl/jcUs5kfi4iKeUgpc4XYdJTtWK60ihk9N5o8k2oX4Q0apzkWtUW47v/5IUmLsuPM0GFQJD
	bSD/J52qu9+bpcPbmRChlvIuwURhXCZ6eTOVMAzvzoMOkku5Sft4so32vhU+4TJZ/UtGUy92BjF
	hQuDi1JnYxyR2wyYJoz/aN1d02kvbPGKaRZ3pWfJtrI0IDlekm7mzXepTMqE7TMC5YB2SSDnLAs
	leVcHN163xt633MzKfiHGgdamBc8XUy6yYI5bIYNUj5ODPQC+tSCBAlMbtqFDCbpnui4VFlejZO
	rs8b4OWd3R0gig
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr2940668885a.55.1792054735528;
        Thu, 15 Oct 2026 01:58:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93c:aa75:71e with SMTP id af79cd13be357-93ebd27cc81mr2940665285a.55.1792054734983;
        Thu, 15 Oct 2026 01:58:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:58:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:39 +0300
Subject: [PATCH 2/9] backlight: qcom-wled: fix string detection brightness
 on WLED5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bW8kWuHi0rdhUiH2MmvmuegVaB0kaQIgT5fkySeoKIY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXD7igeeOEw9oAho9ES6xgeGbyBhJTixyVNF
 dpItUZlKseJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVwwAKCRCLPIo+Aiko
 1ZJ1B/43vXCy6gNpky6dmfGFc57JTgyIeKTZ3FvHMZZ+jRKMpJEx6YXigKvK8BjcF/iqVJ8KKb2
 xCLhzcKp78trBZwwKLDxXmTs/o8j5oaug1+UYmj0h1ikO2QOZVTpblxQlHlZ0tn8b9tgYBV5298
 Gv5UJm3+jcwLI31guZvzpqOkEn9ROAEwzdTKWuO6MdCagN0nkPmNaScX77F5USHl2x7Cf/0Bz7A
 4O+RJ8LJnplu7TKGJ6lz4C94YBrWIGgSuFyx6rHN7983t2CnRfRyJAv0CN8yK61m/1Gigl7DaCB
 Y/9SIXc7kwXBvbWeJh3ImoDIJiL45/yjrgCNhU2PQmGEoNYY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: Q-qajhpWVwLAJVYizjTYTgaCqqI-AeJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX7TL1RRuYwH2i
 EqRqqPXqDpsCzYfN8VWCvoHIXW/bcfkdFh3yxQO9fbdmlfWeA+MIVWC6Ha1sG8ce48AiG7noIvr
 w6PaRur7MhQ/plxvPW3rZficW+dJ1IRPsFshJsGORQ0ZAftbsNxmXPIkT2/xTXNu0nGmJ+rwuPq
 Uf94icwqkDIQSh1e6jH06eIYx0l9r4+ZYmUgTzDwcSguMiP/uV3tBS6qwZQDLgYG6BBH3sjRdKG
 ybyAVd+V0ozN4r8iH0FSaW7zzRcFxH5oUZi2Ny08Dab3u9RgDG6oYOv3DFBMcRXYSIPiuQxVC33
 EYjYeQ1tN66Rct7oxyj/4gCvFF3Z1x0t5FHXfA1RDPbd20p6F3AwKzSiJyp1iIEzBKzY7eXJ/gP
 4qUdPNYuAyAUtl6DxZMEGm4ZQrikADJcEhIy3/beuVP2WXbcwXYsS+AkReNY435aXVxPvPqGlh+
 17v1F8VddTVph98kKKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX6qPj9c1hleUb
 wnofDai6MWG6gm83xsOxw41tI2xEr5srQr+AjuXddGe/ct3Awch1D+1F9NodkrrUGDbS+ww412C
 0RpoUIEtJoslGNh+iCwsKSnHoffOv2E=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad095d0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=DHE891H7Gske2VlohvUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Q-qajhpWVwLAJVYizjTYTgaCqqI-AeJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035

The string detection sets the test brightness through
wled4_set_brightness(). On WLED5 that writes to unrelated registers and
the detection runs with whatever brightness has been programmed before.

Use the per-version callback and latch the new value on WLED5.

Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/video/backlight/qcom-wled.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index f2e0430cccbc..6fbac6a4c29b 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -577,6 +577,17 @@ static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
 
 #define AUTO_DETECT_BRIGHTNESS		200
 
+static int wled_auto_detect_set_brightness(struct wled *wled, u16 brightness)
+{
+	int rc;
+
+	rc = wled->wled_set_brightness(wled, brightness);
+	if (rc < 0 || wled->version < 5)
+		return rc;
+
+	return wled5_mod_sync_toggle(wled);
+}
+
 static void wled_auto_string_detection(struct wled *wled)
 {
 	int rc = 0, i, j, delay_time_us;
@@ -603,7 +614,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Set low brightness across all sinks */
-	rc = wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
+	rc = wled_auto_detect_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness for auto detection rc=%d\n",
 			rc);
@@ -743,7 +754,7 @@ static void wled_auto_string_detection(struct wled *wled)
 	}
 
 	/* Restore brightness */
-	rc = wled4_set_brightness(wled, wled->brightness);
+	rc = wled_auto_detect_set_brightness(wled, wled->brightness);
 	if (rc < 0) {
 		dev_err(wled->dev, "Failed to set brightness after auto detection rc=%d\n",
 			rc);

-- 
2.47.3

