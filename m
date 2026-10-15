Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011894E8DFA
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054750; cv=none; b=gvWcvVMDhwcrsStfHa/ppRdqV4eNo489lPC4Bi3crIDU5DGU7dZfpeo9xZnPmwqKLwyecbddvQ3xQcj3hd0Iqt1xQImPm7J7fK65/o919RQMYQrP7HhEQ7YkVLbmDCG5F/xE+KdQgDaFAPXCAoNXFs64zeYQ7oKDDC8UsfxLgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054750; c=relaxed/simple;
	bh=lcd/P+nruFRhQ358i4WAml/LB0EcL8s1zTEbmnwyMQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVfAlwNPP35QfGVuCbJNQh7WJ26sp++c6y1yl7rmSAGEgI0dtWOIXZ8AqZHBiLz4vdyJKWcPO5w9zOZvyNO3CUvzpLnCNGl9Tcq/GzGTBsxLSNanDahKH0kkPH7V/PjYFEC83Ca9G0UrLJEQkyDe9Wvqe7AmSJykA2FjJ+4KORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IRE9cK4W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y64R4hl/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IRE9cK4W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y64R4hl/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F8OlTt841678
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nKB3HAwwUoMAANvcjYoiAe4y9aLaTkX2vWSxD+aknP0=; b=IRE9cK4Wt02FYXYN
	TcfC9ibQz4nJfFl5hJbiHxaQR58kdsHtAOmW24zga/73b1y0Qlp42u1KK/AFCrqL
	y4Cblkxh3xj8Wth3I3mZHtrMqwqRQCptPJCtO2YfGtQsgYMWCYFH2nt+vEACAKUH
	8+ua3b10WvCgafGwnJYUvwcQhYuJXMODtMhk7wKOnfGQeoSJBf4tv53LaFHIdpdw
	LIJmLsoMuPwzWV5NrZTaKKM7F/xUsflJua3vYhlCGfAmztU303X3KgDrselI2Hmb
	Ys3cDSmN/oB2AWTloUeNMUR4+HmdQrf2fUWmI1nZGgHtvkBZAJ0zMV3orBIalvIM
	0pFMAA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wu4qw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:04 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b7e90fef1so76928726d6.0
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792054744; x=1792659544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKB3HAwwUoMAANvcjYoiAe4y9aLaTkX2vWSxD+aknP0=;
        b=Y64R4hl/hH2Ew5EurFAUOF1LgxerXU8L1Ckf3xNQVzGaIF5JpGzVTEzVokfRAM8uGO
         527q/PWTL2LgapEScxtFbtoW3Tju1ve0pyTP7sNVK20hTo+Mz/M+H/jcAU0MRyeMdLeb
         AH+opthzbYd9zIccN4CXPRWkZkpKOeuK7TNOv2wgmpm0C4gPa2pQbPPV/DouU+FfyFWC
         aizOh5c//9NGHSR4TtB4eVxNbHT+QgnHhZVrJeRpw8U0DQ+UHvz+53snm8hAWsSwcbFz
         VKaTK3wLspgR8nFl9uTlrtKqxXIFZXUx0z1wNef7hRX15o0HIB8Y9MAquh9AjToRn1z7
         8V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054744; x=1792659544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKB3HAwwUoMAANvcjYoiAe4y9aLaTkX2vWSxD+aknP0=;
        b=bk72vK7FrFogBSm81wh4z4dzcIKE2u9HDTs3dnUfWBrUBxBx0aSQXVQoZQ9yYM4zfK
         KYtFKLthVzdGi64xVXWe4hWxg0lIe99GiwlI0sglOqP+po/O+s8J8t4rZ7R0bDGvoqR9
         wSjeuSIhJP57TJ1bvgu+XuInnRWYzIF2CbbVaQ2aJvPwnIjz94ccEYqWgnaRavlrVHt2
         YywwMCZD75vWm3U0cExBh6BjJxLDODqQVtQ8lMYWQ/d2d9zcRasgn6CZibzuraQzSgij
         5E6FGJjPsTMOwDbj1hs3LiyA8QJJbiP76/dwTkx7dC218gGnJda3oZ4w+iQxhJWyMsE+
         E7cg==
X-Forwarded-Encrypted: i=1; AKwUvBxMn4p35LYHAunwN9l/PEV8qntf7QdGGoCF3AM7qjB9tIOj/oHCnJt94G8O57gkA4pk5uLIzVlTIVdqhQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKucaddqjxxOhectfasSBT66W0AFFxQVIBoU/zC0Dpj9x/T/LpH
	p/bZUsqQgxfjdCQvuShD1auW5JoMdnKjtqALNGKllqZOnN0crGmyxrC0Z6IgKukpEBYqnyhs9Dv
	nX5pblZXYe0IOHjFXqTFV2WVvfyv+gN7/5fjeJYd1tDbNnAVxD9k7xPqSoVi2po1g1w==
X-Gm-Gg: AYBFou3XUmpT9+KeSo/ClJuUTENZoNuXFefu5JDJYhsnPtYj2JzR7lBqb/6Hf8ANPdM
	j4ARVCsBWs/A3HoSxRMyJrcw6ih79dY/KO3rDhxYyJTABajPI/i9/l8nb3fqTaCgA3lgKXIpSuq
	In2ngMXKNqkX6XvFjAEpgUM9fRWXlyUTn8MlgQeymeu+DOsZr3VXgZo4PD6efrhSQfVuQZ+ark4
	4RkUMPi2h1ovkECIQ4ua8+h+V7d4TKl25AnnMgLs0Jgnl/H6kUqgMY3STTwtV83eWahIJXrg7hF
	hMXaoi8rvza3EaEFR8nihjSMbfw95BMQxE3wf/vHxwep6y8TptJUDTXzxKDpOoDT5C/nOprgvOW
	LtqvlGC7k2lkTBno5loE4ZAXBmUFbFqRd8tYO/SHay5dpL/cCOAMt5roFYd+iorOcIfFSOHQM6Z
	Sp8xEiDytGY+Dg
X-Received: by 2002:a05:620a:2985:b0:93e:c12d:4ec4 with SMTP id af79cd13be357-93ec12d54camr2604347585a.36.1792054744271;
        Thu, 15 Oct 2026 01:59:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:93e:c12d:4ec4 with SMTP id af79cd13be357-93ec12d54camr2604345385a.36.1792054743810;
        Thu, 15 Oct 2026 01:59:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:59:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:44 +0300
Subject: [PATCH 7/9] arm64: dts: qcom: sm8150: add MDSS reset
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-7-5c14928cef29@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=826;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lcd/P+nruFRhQ358i4WAml/LB0EcL8s1zTEbmnwyMQo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9aFqcd8m07PmdPRa/RC1X/HOQu9S8ms0iXHNl9mkp0aV
 TuvbeX/TkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMROIE+z+lc+Yq0xUkOnq8
 V6yKXsqvqn6thMfq9NXmSs2CeleXbyv6vzbvUK37H8WaN6NVreJc1ksFT5PFM6b6/jwxVcbtP6O
 X05L43UFO0ReKTrk1f3q3eeuk8nCBzv3G1jqem7O03ZaGtWc83a4gryN1RvQWf5rK3nR/vr4YuQ
 6dI2WPP3tf2CFepi1RL+Ozk63Eme+Z6Kd8af9l2WLhdspLWEpKoybJrytyzT00Q3muo37pNmmhk
 Klvdldw6xgv0l5w+Eux+ox0xYsKPsuXz3B7oakQ2fqTPdr1u4Mxx5kVfRu3WLV1ss6rTl317lfo
 16fG9QncgiYBqfdjsgOS45Q1VMrWsBya1xprvvXf1hYA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX0+L4PggTDb6r
 LrdyZ9NIDyxVIPdeAkOVWHnxRzXMHj8so7YXwk8c7rHRtpkJiX7Cl8VJWOcMfJQF7diIZRYWJhS
 mq9p/7CA/hl/Mz77fVeB/Kgj/a0nf8M=
X-Proofpoint-ORIG-GUID: 8xGJIQKUZ_uOoHiciArdshQeqfFCAHaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX/rEtmXu1iXw/
 SF3aGNVh/nxCAHTZJdjJkIaEfj+z2ISPwn1YrQ+kskv6tsKfCFM057ilWYcAbat+KzsQpcf5ym4
 qq7TIugffnjk5LqE5LXYy7J7Pd0dolNorD3EFkMmBCqI7wSVKVD2Jf4lsfNK62ieCypNkRRl5aM
 JlJjEqkG+RXwYq5ffj2SbPqKU7/lcxbnsWssjBFWV0i23SQ3k3xkCKjHhkxbS73mtRtgjoFj2Ff
 ofgvq91Uh7dRAa3Za02TWsc239vrJ0DEHjU4BZA33Zc6CzR88H+4XtowzgMOglW+99BeVVNX3pn
 V8KWYO3TSXghn1VxyKof8I/tq8doOjxq7kFyZr9UePgaykj2E0Lv+Q8/yGAXmsxK7O36gWKs2LY
 SqPfRVcDfSbIUSJ9Hrfw23EsBlETscykjH4g6DOPQKFV4zHyRpTHuCS5N7YtDd0invYZ5p+QmJT
 TAlp95GGCK0/98qdvLg==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad095d8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Bz10KyuN3JYNdhx7gBUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 8xGJIQKUZ_uOoHiciArdshQeqfFCAHaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035

The bootloader can leave the display running, as it does on the SM8150
HDK with the display card attached. Describe the MDSS reset so that the
driver can bring the hardware into a known state before using it.

Assisted-by: LLM
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

