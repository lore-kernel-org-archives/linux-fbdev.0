Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000E4E73B4
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409166; cv=none; b=sKD795alG1BFC1iSoglFBvjmTdm8RpsyMUnbH1TspIeJujLUy0fvly6osWP74af6PNiKBcGMhFuwnnDHTBbxdZAztYUECtecOdwJ0pcCue23Sj4V61nAH0iVtWGFwkFb1DCEJ+B9JXn4IA+fwPLbAYNwnQ0MEJu5SbUPH9aWDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409166; c=relaxed/simple;
	bh=CWiZ+B+DX/pd1HPJMvcRWesjFuvAJAW1/O0irKFh9LE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tA7OVOb8H2vTCD6yurIxt7UFDUKXdM2nsjMYdkXHMsJ5XRFu3IN5jewcz4Dz4wgR08axDHzfxVMiqvzSIdkq4YeYjl288tX4vqW54vXdUJTg/TOt6PProC+6m2IlktnGDJdTsTS050q3hZL3xOE8Sqgdo5U8PSDTQoi61tkV+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jiSRSgE9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Feo2jt/Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jiSRSgE9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Feo2jt/Y"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OsrC1348209
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Hh/Ql9nrQN77Ly3gXCUeGT
	tJgIJ8Ua0NJFTzN9nXRkk=; b=jiSRSgE9+fJbgiZ/iPrgRY/hcqaUTEAFjwB19Y
	cSi4YnItc2vLrVCzXEHNGwPaPM2pqLIG6/FBVqAW6wWhbeQSaA0ciVD7kRM7cq5c
	agdHgwybacm5aYDqtNKE3hqIjkg5W4XVXj2doqUsBYb1Ich4sQUjBeamlML9i8Ok
	UBPPms0NPpLUS5stxvy2LgJN3gnCiACkI7sLy7PMHxDB16y7PcMPItl2QmL/Cr4W
	fN5pyprkwy8wcAS/4Bn+WCt+qVAShs22WnK9SwHd7PODmYzILz1/50wO7YZ7LEYD
	l3W9N4dmmmLXgQc5iyT2admP6d0nXoL1m1EPN0dy7K4CtNng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgtbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:25:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f1e62510cso487063885a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409150; x=1793013950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hh/Ql9nrQN77Ly3gXCUeGTtJgIJ8Ua0NJFTzN9nXRkk=;
        b=Feo2jt/YflXKpdYBuHOc0+gOcEAAiFJQTd5tDXHlJyOb+HRHwYagkYM4sW3mMopXc3
         bCTnER4IEXBZYpZ5eguc9N5u9mRwLDUrA6ZXznQTdBVna+zDLslsdxQLaoW9d5dpCBiW
         AJh0CIZIxzhjmCcme5hhzua3FoFf+/0kUY8LiXvvHMpVir7N3bAZd6+P+wJO/RTjFaBA
         zRsnYhIlsCESt8OXfvZwSi8RBwnQ59uU4KtFH1oOqyeGeMYgpbjsefJrnfb2P0QRZVgZ
         KHhQd36z0GnreUJ/wu4AmcewafDE/OPLZINzFJ3ggbixX2z+tnRhoymZZmX5XduR8B9q
         N3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409150; x=1793013950;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hh/Ql9nrQN77Ly3gXCUeGTtJgIJ8Ua0NJFTzN9nXRkk=;
        b=zu8fGyRe1pznLA5ZBIcrxoA8CukH7pSngNo2AIULNPQ0Erx/tvn1T+MtoYMbBMIn6I
         bkzqlafb9snoWDZe973RUl1eDLCaTdYi6THPY3qiYXC0FulsMt9fzG+VziKvFSmyojL1
         ccAlGCknOvKRxOgsUKk5dxmet1zbMZkJ5DJakAUKUAZcUlISM2l1faQPr5eTKA94ll6+
         QNePLlT821X1MH6vIUVuAQZskKUiq96ey70DekYvak+dDBmhmlhFpo6a0wOWUgpkC6r2
         quBsAl6HkbUCIgo+xSbFBh+4bIDzsQbT+BIxMx0o19alQPnY/1N2xIrcO0RUDMyCGB6K
         /XCg==
X-Forwarded-Encrypted: i=1; AKwUvBxUSRL/5z15MP8KCeQKNVhs7uHmtnaJMYkuM2r4o0a/GPfWf8Hbjggv/qcw3k2WiNEEnVez3/ZJnm+CDw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJWcsJmcp9VNwEQmXjjMXAzi5RxsSpYfNEBxtD4Y0px1805JM7O
	ZCAR1YkMGl1NpCgIOZ25EOhpBi56J2lJiO+fs4UGMUBai7Lz6nj+ep6m6fHOOoFCWeRyo72PyWX
	PZxViCJIpdjHKpoRGHCDTnYpt+o3wF/LlvcVDoAnYbBoDa8r6FgjemBBG1Ai9pIGLuw==
X-Gm-Gg: AYBFou03aiWi9q1HNlywr8vU0CoLx6nhBLaPPkxtjgdsuWe+YFazfp57Qa7pjoZk53b
	pPC9eAHeCK6OjeowXRIH3YMUQuR8AuhMf0tzI4igrFqvrl6fjlWXT82Cilb5Dm0sILW1Pov4NeF
	t2BM7ZR4dh4KYC7t/+D9CL2CxARkwaRNCVOvxUv5q0TGS+GGXVf0qwgL7bxesgOfv3gq3sHcTYy
	LZIPqtGk8im0pMegZXTWmym4yjyhWjt2ZNuYiaPCuowghmYTL/G7pzUQzMq2No4sXPUW8WBOmiZ
	iOkW7K6WMAMdVP1U1zZUBVg/Zm0QGAQPvpWaT+Y7B+8axACZJnXqgeacrBNdjR9SX46nuU85+a/
	M5jhUwE4+G5vQtURjurRv5Ye8a0HMi81/hUIlNnOZQf9UnRi2ZadujX2eSvTJjAmi3/ECdvduux
	nVUPBDTJvrssl4
X-Received: by 2002:a05:620a:4491:b0:93e:c12c:9b6f with SMTP id af79cd13be357-93f29df45admr1138173285a.74.1792409150114;
        Mon, 19 Oct 2026 04:25:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4491:b0:93e:c12c:9b6f with SMTP id af79cd13be357-93f29df45admr1138169785a.74.1792409149575;
        Mon, 19 Oct 2026 04:25:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:25:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/8] arm64: qcom: enable display card support on SM8150
 HDK
Date: Mon, 19 Oct 2026 14:25:36 +0300
Message-Id: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADH+1WoC/22QzW7DIBCEX8Xi3E0Bg/9OfY8qBwzrmMY/MWA3U
 eR3L3YstYdeVhppZr/ZfRKPzqInVfIkDhfr7ThEwd8Sols1XBCsiZpwyjNGmQDfF0xSMNbfOvU
 ArZwBFCmirGmhM0Zi8uawsfd96+f5pf1cf6EO26rD4XCaIy68bL+0CI8syjgHb/pCSGjNFUqRZ
 TKlWvAsrxZJ/vY7EiUtYNJjD98dGqiVvnb20gZoTClzQXmeyrRaxBatlUeI1t6GKhnwHt575QM
 6srVtrQ+je+wvWdhe7rhe/nv9woCC1EyUvNDY8PJj9P40zarbCKc4yHld1x9u1ZpNawEAAA==
X-Change-ID: 20261014-sm8150-display-card-e43ee5b08c61
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3221;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CWiZ+B+DX/pd1HPJMvcRWesjFuvAJAW1/O0irKFh9LE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f41nujOmG9xiGIKJ+PgNl51GSg+JoyTA/w+f
 XjJIrGXAPqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+NQAKCRCLPIo+Aiko
 1X0GB/wMLPvcOXTm6FpGqFWZgP7eVl8YyL4SXJ91YuKHs5pg7khYCEdIVqnHABKMcgBz7rJLFlB
 bhDjTi994W4x6GeHbBUKgRn0v/Ar4k557nm9SFA1vqal946Mb9dBh3/yXI9dQkksjs9v7mpqyBP
 OgJos7Hpbi464D/hudXq2k2rCZgivYn0vhmGcS+64IPuapB+C5FiGQeERxOg3kUqDEDfVoVcslt
 foHItInltSlxqTza4GfRuTXRdt727tbQLA2WCeTG8ALZYdMy+3/apHYpfkHvfhJmGb2MTV1tvlo
 9MaD8rESWCZ0YR+EnWg9xY57C5PPzj6c6rux1U5WXYxqu7Gh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 3XtLHvSwoqEcTUQocYn-GECfrWI8jfgt
X-Proofpoint-GUID: 3XtLHvSwoqEcTUQocYn-GECfrWI8jfgt
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad5fe3f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=ObozKJ859q3l4po21PQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX3IzIqHTbcHnG
 E4qMgSsr1gvIvvkFgsmUXXsyCj7VOzc/R9mWRGwD0NajUZ0HnuM+0oxqgUoNHazyRHAJ61v6osr
 E9lO76P1r2V+BeOfx5TAv6OabKuUMixFuhwIRKIHXimrzmUWFDqVXtFAXZqk4g3UwAZLemNr+vW
 DVMuHkwqRT8ZpnT+SxPlTDz5SIas1vSN6zRLi5tr3tebCGi/s+zMUCEYdOjTkGfLD6ELGlX7hXb
 4gV5hoDBP0nM8pNMvR46wGGo88YDX56nE/piUT6PY/WHWedV4hMJ4J+MjjrfsQklsOkSvZALqQW
 TkTkYbJs1s3G6cvUP9j+EO6jRjPAh5tgUiSYHZKeBTBm4xfmWpm3GIUXNPupdNDS69VYf0Ik+rD
 gy0wThZBCVYoAyuMhvUMb/s5lv4KlsKoZGcoKrHjUvutlujVTrXTvkLNDlpXQuoBtAgSuFHxW55
 oOmPH5wLmiye/qIfHbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfXwJQMw/LP3UYF
 f7egbL9pIsm5Cm7/15TuCyEpZEgOMpdVK37ORDdfhDWq4TjkfaxdV7wynX3x+j+HQ+l4yUVysKk
 9OFTAypiKoJxAIQr43Wf3P++Oc10Im8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045

The Qualcomm SM8150 HDK can be equipped with an optional display card
having the same panel as the display card for SDM845 HDK. Reuse the
driver submitted at [1] and enable display card support on this HDK.

Unlike SDM845, this also requires a new LCDB driver, providing voltage
for the panel and several fixes in the WLED driver. The FSA4480 address
fix is independent and can be applied earlier.

[1] https://lore.kernel.org/dri-devel/20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Dropped WLED patch, duplicating one of the applied patches (Konrad)
- Rework the WLED auto-calibration patch, also dropping the reviews.
- Tighten voltages in LCDB example (Konrad) and in the DTSO.
- Renamed the node to regulator@ (Krzysztof)
- In LCDB driver, fixed handling of pull-down on disable, fixed caching
  of the state, added REGULATOR_EVENT_FAIL and fixesd short-circuit
  recovery (Sashiko)
- Link to v1: https://patch.msgid.link/20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      backlight: qcom-wled: fix string detection brightness on WLED5
      regulator: dt-bindings: add Qualcomm LCDB regulator
      dt-bindings: mfd: qcom,spmi-pmic: add LCDB
      regulator: add Qualcomm LCDB driver
      arm64: dts: qcom: pm8150l: add LCDB regulators
      arm64: dts: qcom: sm8150: add MDSS reset
      arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
      arm64: dts: qcom: sm8150-hdk: add display card overlay

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   4 +
 .../bindings/regulator/qcom,pm8150l-lcdb.yaml      |  81 ++++
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 arch/arm64/boot/dts/qcom/pm8150l.dtsi              |  14 +
 .../boot/dts/qcom/sm8150-hdk-display-card.dtso     | 113 +++++
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |   4 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   1 +
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-lcdb-regulator.c            | 494 +++++++++++++++++++++
 drivers/video/backlight/qcom-wled.c                |  56 +--
 11 files changed, 746 insertions(+), 34 deletions(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261014-sm8150-display-card-e43ee5b08c61
prerequisite-change-id: 20260122-sdm845-hdk-9466530c4267:v5
prerequisite-patch-id: cb272273cdb260eb5049ba5cfffe13e7904e7a70
prerequisite-patch-id: de7bcd02cfa3baa997e973220d71791b4e74b4cf
prerequisite-patch-id: efe1cd41bd8c1ddf7c9491a6fca5aec877afce3d
prerequisite-patch-id: 98360ae85418d09598608b3a6337aabd76eff717
prerequisite-patch-id: e46e47c4d158362a382efc455438ef1fd5c95f42
prerequisite-change-id: 20260908-qcom-wled-backlight-fd9574027353:v4
prerequisite-patch-id: ad71f17b07fe258da495c7df319d77c63ab9db7a
prerequisite-patch-id: 0403e028ec3ecac35344dbd6dfa430abb71d45f5
prerequisite-patch-id: 2294f3f59a928fb80b92ff9f1ea57d7eb47365cd
prerequisite-patch-id: 74b7c8ba3cc2e3d9475f4f219a8e8d10fc381d44

Best regards,
--  
With best wishes
Dmitry

