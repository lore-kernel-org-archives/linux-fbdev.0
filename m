Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F94E8DF3
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409177; cv=none; b=KqfALgoglbyLLAeWuiqwRkS5qYA8jPET5sj1QIHAkJ/AlVtcgFsmKC8hd+czjdgZfYOCy6kJ8Wr3mgRPHzQx3aCjnXTvk+W5EKJNMOLBuqtEu4/+juq53qTE2wJtviDDiVleB6NAFV/tQv98S39uzNE5JZIFmNlgoX3Lzwo13CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409177; c=relaxed/simple;
	bh=hZXX7jXb2RW5ococNqZ/3EvKgahehke65kVnEWQpEVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BofLW5yNqjPL+DYpQYUlfi3bdQyZ1hQwTefU2wuIibU33Shc0FjH/5g9N0FpR4IQkjhGd1Y35vK7QbQBXwuPWDPjVxZpkJyJczz36hIfbjY5X0gnI/n994AYXgbWBm03fUpSAe+QSyScC9EoK+T8rAFAwb6bLFmvmMyJUOs2Nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/spyE1B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g78BG8ol; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/spyE1B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g78BG8ol"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OrnI1665586
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ux49o/jZ2Q2HbyoLdTvVFEFeUH/9erwewqJgn0+nyII=; b=n/spyE1BkM/dDNRS
	NY8H3e9GZWT/a38lAPzY0ca12xZUFDWI7HgjNpvO99UkGI3Yc8Z4pi/6EasE8jSo
	MCirDZ1mGsx9tSwXtsaADw7Zw0SBJG6SnztTUifIANPCOiqMUrGtGY06QAjWHc7L
	KL7EEUBaSqvQA621soHLUt5j1vyfPzwayskQAksXU7qRalhgpIZfWAUm+p5lVhgb
	bBWO9Mjyjl9c/f75WXflinVfx8pxF9sfztA/nruxXhl6fuZZvAewQMIwizkM68xz
	kRy1cca41BQFoZlF18ZCFOVpbH+l+77b6bI2XJUVWYJJ7eKNg7Y+fe7vp7Nu1pSa
	SAogtA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0tgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf7856ffso533093885a.3
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409161; x=1793013961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ux49o/jZ2Q2HbyoLdTvVFEFeUH/9erwewqJgn0+nyII=;
        b=g78BG8olPxRHhPx1AbeN/rGzxdsfaCGDZWABeMDliyQRShDrBWyVfnnhm+Y1nWKcrq
         rM1FyRUMQvOnrZRO6W9wo7V0WqANInBS380v0l6XP1QChuYUkhYTG8hlTv9uP5DS19Lc
         cBur8OLeO4al80NDeyHI7r/M1UrW+M1awXXFxf48lQMH4MSGs5mfUTJ6vNJlv9+vVR+A
         jipQG+ouHd0l0DB8xxPu9uP9WwTS673/zPzMjbhSZV6dhJYqOKVtf39O44HjplLNWp+T
         0S+vQLHQLk8TFHKci9VROqsnyIwB0M/Zuj2HqL4Inkp3MUBTkU73z8LhgrQKOEMrVW6R
         2KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409161; x=1793013961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ux49o/jZ2Q2HbyoLdTvVFEFeUH/9erwewqJgn0+nyII=;
        b=dgRtZBRXoagVZkj+0h4PkiPtDrVVDm0Cb4getSKaxODQIayEN10mL92bUF0Z2Jh2Cq
         MeI9ilsNV2wPw+7xNHnYhYoQUQW5PWCscdfzr77wpJHMtM0twut5MzGeHjV3lx+zHfIR
         nVNYh6LJTgpqm6yV0lQMezPIpaPOPZWMsrimsO6EnIDa1smEJsnWH/L4vzuVATmdzrgt
         7uawGyeU0jGhpKcQHygAJHf5eYUBvUMscJ0z6hhSxEVCo1eo4ne8hvKNivsRVcB63xv9
         5KveKom7Mo9cNlZK/0NbCNeQHMumEM2Vu4Q4nuAj/rLvKyymTQ5tkFmIYy8R4okaVNTW
         1slQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7j3n+6HkX3EMEXbpa8dxR2ISHBqTCt9KCdhZ/Yic/jKQxlrYjBZjVrCMurg/Rfy+LSIVHi5cunqHosg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL9JYtQxcraMaS+eAX60qePQNg/BfZEgxug0EtzYesv8Z3KWWJr
	YedYwiA+L/D8V3B51fmjLsT2Z64fXSizeF0NufBp0kZnxp3YRm0JMS3NoZu4DAJcgDpUf70yudY
	IThEx7IltfJ5IRUNv+PYF1ccKnCwenhqk3WsqZgpHdvKqlobQxCsGsr6ZXtRuqzEQLrXmp7QsTg
	==
X-Gm-Gg: AYBFou138+KmOVLM6p4Eb2YAFWIAPpK2UJVPV9iy+Jtm7oZCjjcIbEvghMl1lAYFmFx
	PVd9ZtWGT5wWBpzgm5AxUbM+tJBPIp8j7g1GSGCSPeofCG0F6WUeqgpwEkxXoGg/KkGX5qcmL/8
	ADS53RkB15h+2Ia66Xnd6BuKJY3LPTsCUH9uQUOwD+ud8FpJkDS46K0KZ6C/ULVh6N3gutO1d9W
	/+v8HqzehGzBXYwMO8c5VQgcwkpWlwQc8WCpyMn32/T++4fQ+q90jZipWykyFzP56L0eSJFRKz/
	XvqTzp9ustCvDLS3Nisxoww89tCX7B13p3HuwGzfnyOtlNmYtecnS9lwlv2rjdNzYxQppJ7Nev+
	+fXAJu9AsEKpTWeWhQ+Avp35SLTRzSY1zSN3bOddPEbXPovEoISM54FIVDo1/w0gZeyERX4vWuu
	0HZ6KY2Yr/1Jb0
X-Received: by 2002:a05:620a:45a5:b0:93e:5247:f61e with SMTP id af79cd13be357-93f29c949bamr1190123585a.25.1792409160806;
        Mon, 19 Oct 2026 04:26:00 -0700 (PDT)
X-Received: by 2002:a05:620a:45a5:b0:93e:5247:f61e with SMTP id af79cd13be357-93f29c949bamr1190118385a.25.1792409160178;
        Mon, 19 Oct 2026 04:26:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab37ba8851sm12807621fa.22.2026.10.19.04.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:25:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:25:42 +0300
Subject: [PATCH v2 6/8] arm64: dts: qcom: sm8150: add MDSS reset
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sm8150-display-card-v2-6-86c05068efc5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=887;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hZXX7jXb2RW5ococNqZ/3EvKgahehke65kVnEWQpEVQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1f46nwhQIKuE+nnIJbKsZpWQ74BHTOmmJUSF4
 oXddakZXaGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatX+OgAKCRCLPIo+Aiko
 1eDTB/0ScjJc6nrAYJwlxb7Z4o6Z87s6Yf5G/e6VqlG9wGSwoHZKsaWFTq8kjhNE7Sg5QROx8Zk
 yo//8AcN6chcIry3PekMiptrAnechf08aNFLpoiwDLSWds5cpZ1Ac0PlfTgMy5e6PR6FojkDbQY
 +TuLhxym4W4JiVAlCA/Q1SUNEuPcgYYKK6Pd47dca7Xdv4m76SCLdQXRENCr76zjt8gGEtHRRiV
 UIW+VuDyWoxJIkIvPPdxCMQdQo7sQOyJaNJWrjgm83pIEeqW5b5WLhCoJ7x/gLOoz17emmyFZB7
 rUupLGHhAHpKnnl7FuAWVMUC187kmAE5M0Nzk9EeN/bc0XfR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX77/EfF5dR6zA
 YhN1Iy0wlfjyyPgLmnRAoQ6U0xD9Z1ohfSLWWSpUB/4JdYcJVDhb/YWDlelWlqJyaSMzB7UmRLo
 AIrkWhZCGfN0MaTotSD4N3qQrWowS3U=
X-Proofpoint-ORIG-GUID: plVDDhRtLNSDr2Jsy0y6VLGM7H5k8hqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX5Y9/2aZmi3fB
 MvZ8PPpAunq2Ut9x819Eym7I324i0J3wUJVooNlAAw1ptuOI3+JM+JbWVMsqN5yPkJwUEKPAREY
 BMUfOMNQV7XZMxJdPQO9h4UskGeofOahvpNdr1oneKlyJNULw3mTjTZ8aYLdxNRJ/nHIZX3yZJq
 yieANFgNlgRrrQSqqIlBGthyZb3aU1ipqto4H2m/6G5+tv6A7Aa5vzp5AlVUQm4yUuYtNFrkUpE
 ctbWNixPmCZMzdDtIc5Oqs6DLRIEAUpW60KCAge9jZrN+ET8CAJHt1HVC0yQVnmse442fa+8Z7Z
 ZsSEoa+WP2D1HzBc3zwBBOG4Auc0GXg7ETE3wX+mqozH1hrlPLZgEt4hXRDwbDnmrA34cvfPBGS
 IPPCciXIkzL/gcjXO6PMTZ/D3alBMyRFrnNTYQwUq61BnWzDHBgebjRw9vbZUlAEl5xj5DrTEFg
 pNTWFrN5ZtEP/b3IyYg==
X-Proofpoint-GUID: plVDDhRtLNSDr2Jsy0y6VLGM7H5k8hqE
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad5fe49 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Bz10KyuN3JYNdhx7gBUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190045

The bootloader can leave the display running, as it does on the SM8150
HDK with the display card attached. Describe the MDSS reset so that the
driver can bring the hardware into a known state before using it.

Assisted-by: LLM
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 293fcbacff34..a2d6e6947c4c 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3817,6 +3817,7 @@ mdss: display-subsystem@ae00000 {
 
 			iommus = <&apps_smmu 0x800 0x420>;
 
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 			status = "disabled";
 
 			#address-cells = <2>;

-- 
2.47.3

