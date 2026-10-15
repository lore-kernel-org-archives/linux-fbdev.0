Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF747F3D9
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055720; cv=none; b=ejIL4atZYwSdzEs+9DwwdviUwApaqzGAk7Os70wfn7kljt1I+Uodq+DNsB+nPr7thLGD3AhTvne4l5upOvZvhXsHEErYPJiwbkhTQYvuZPufZ6seVj6IF5xkDEn/xSw9DOlo6NHeSXRUvwCpMqum3BqQI31qMdZgY6Mzy05e2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055720; c=relaxed/simple;
	bh=z+BWBGlvD7j43OYcW9UusO7ekWqnSZaJz9t8vXKA1yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPO14mOLIsrdiafQ8jDqafw+kdFWkkKxGWdm0uaRiYH4QZfYpsdXQiRPev1BvVyXcoSeR8cfKHaZjlx0JGQAt938g9Ogy+cR9a0lyYFIiIsV8DJXntvZ3N9ikj+3378M6yGqp5yVbohyeVXtnAyUnOH1GWb3Lsz6F47AQGEtR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azbW2sya; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/zDq3Qg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azbW2sya";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/zDq3Qg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3wbnX1889509
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mbz1I+0D7v4YlTuSxVHwUi2rWWEi2PQQC6WAIH4knOY=; b=azbW2syaIxiAklhX
	1zIMGP1og2e4iIi9ZHhc/SANhUraFuOr+/DGkSZWHbqw4LDmzlIxtiCbn/myzXNE
	Mom5KNaGtL2X2o/go7Lrvgp0g5WCf1wRU7ZyWkSwHwdU7BRv/B5NvgaAZJpjygav
	XaOdj+OUU1WD873tYIT/RfH13BFNfdwHuiGF9xmzJlx3GFqfrd6r1xBrIJOgFAQ6
	pD9CtFp7+OYdltJp/tR6hsxrOTnzvCiC3jBVd3yr0PHyz76iURhXVed63SB+9C68
	LuAm+6Zt6ZZ/qn76rPwrvVQm+Q3lMLonpHqTjcLaiqi7yAZR4FZHtxUIuxmpYMX8
	4gV/EQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda17t9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:15:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5338bd59032so12258451cf.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792055713; x=1792660513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mbz1I+0D7v4YlTuSxVHwUi2rWWEi2PQQC6WAIH4knOY=;
        b=P/zDq3QgtbushQu+9gMWt18bLnV5p42cAetdcCr5/m0UXgXhqZtvnKTxeEKCDVAmXh
         CmSPwCidmnApA6fQxwF+70a4Y8Tou86ytsMDP/CiQ1cFtD+kWCywqNikmSV3BWHJwarz
         fPtKesJ4CPgRMI9IxxkOP/6KsS5WEZrYZV601Nj/P6pMQRpufqIBfoDw58tVcfZ5YJJe
         5dhLpzOPYMzKK6Ab2gLcSFw3MIn7n5azVQABloHSrj0q0XJ6bnl/2JOYk/dhKVOpbjQ4
         KJOQRLBvdFqZ0rDfaABCvIc6nSr93K8MYhNS/BW5+r6aqGfbHJqtOSQl221CySE9E0Ie
         4uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055713; x=1792660513;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mbz1I+0D7v4YlTuSxVHwUi2rWWEi2PQQC6WAIH4knOY=;
        b=MbBtxOQtv87Cn+Kvkqlgkt8rHkvTxmFtSaX1mXnz8TxXFsLM4v+vrGvvPh/MtVElKO
         scgnymhZJRlk99Tlrust6Wam7E42yelLGGruah8mL/KUETj3nxquilF6Uh2Vs+/ilhsf
         R7tSBxXmlp8zuYhU5jI0VDwGSLkjkAE3T5+V51KEdB1QYZ6rPgYGxW/GbKPkOamhbvHU
         PgvlNQqRGJv9KwxHqAmKiA0O7PzktbJj1W065xXoLVT7fQ92dpPpFSoaJXSkj8vZy39G
         eBWgNjyO//bPlVIr7BcyIJr3szZZQlxQ9WNemmzKeAyZpr6h7eVRv1b+F+UnDOINTT3t
         2zKg==
X-Forwarded-Encrypted: i=1; AKwUvBwm1+7yhAmvke9Di9wd0OWyZYF80GULiUAVU7JgIvs9GaBaQthbbstAH1I79HYi/22tx6r4cBQ++lPUHw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvISzYtZJ14MsfCJrMLMO3Qt0oxFHKgnM7rSQ4LKu1cdSdKgdM
	VK7VufKZDLeXN5VNDo9LfbHqnyAo2gjPzLsc95GAa1M6nUxga8S5te6KqYpj2u6B0PH5pYJJvlx
	mTJWBuQkYQhsefKOGud7Faaw+55TS1M+ea9tFJh0fuACskovKMyk+Seiua0fpQ+IuNw==
X-Gm-Gg: AYBFou0yxfp1RHaIwV/CwIR10tUZ2yLm0/w1Ik83HN+Qgq1dBYDZe0XZWYTEq2L3v/T
	4GpcmTC8sYwgcCBgRWcjFg1BSoQxhU4f9Hc9AAxkEx2e0N3cMcm1am8ZelZd8uYD9YAp94mdKWM
	MT84YZiGXuRgwnyyYaQhru+7WenBKIsRo2hrZf/d7POYoXgKe6L/hLLrJSbXOtZupp3JS3BCWoh
	oJBBiFCgbeq5DNt3bIkV5mjqgRmn3iHNjhtFUZxW5ksn2Gq7rxIdpAis7/6tfIaiftc3IKGUvD4
	j5ePqeD/r4eVr1lGLedzX1m5PHqWStyjh74j+WGveG8cGyeR9/5Hrp9fvbeSRKqWURQsk37hpH+
	JP9AF3lJtDDIEIVKd9wpo2Q==
X-Received: by 2002:a05:620a:4449:b0:939:9ef4:79eb with SMTP id af79cd13be357-93ebd27cc8fmr3410265585a.6.1792055713568;
        Thu, 15 Oct 2026 02:15:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:939:9ef4:79eb with SMTP id af79cd13be357-93ebd27cc8fmr3410260685a.6.1792055713032;
        Thu, 15 Oct 2026 02:15:13 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed6be6f15sm101465966b.10.2026.10.15.02.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:15:11 -0700 (PDT)
Message-ID: <0e456ae9-7286-4c4f-b56b-9bbaf4076732@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:15:07 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sm8150: add MDSS reset
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
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
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-7-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-7-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfXxLdadQK6OYfJ
 6pJtMBYCMaaZmH5p4X35s9rOsK/z+RLBSzzwQHIopOVwTSPp/HLSFAmXSwmuEGl84Fg4s89k6Ji
 TG2FYp2ssm64FV0NQMAwkYzjbkbSl1E=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad099a2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Jhhi1Yo89JosEC0CkA0A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: nnwHRmufN0Etp3yTy_bZ1OH1Pj299IYi
X-Proofpoint-ORIG-GUID: nnwHRmufN0Etp3yTy_bZ1OH1Pj299IYi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX4g94Y+HweDAT
 0ZcqxhpPTzn352vCYgf4REmBY7hY1ZW8bAI+e9iaFYsuLApTxWZHB8+ADQb4kbisbwHYuChg7OC
 sLj7ynYm/mUdVusb8Vm2oTHL3GXzKnP7eGs979/tB5GLa8Y6D5+45OoNP8ycEsdDef4xvBjqX3S
 GX0/Narvww1f7RiMGI35XDJ80x+gTPukYfqq+7/Nbj6E510/FfmMmNdwEBX0NOpMNzwZlqG5QaD
 +rG39Q3rdjugzFJJsVt0tk//lQEaO0RwideZjmOP+3yMaoCnqrYULcMy7ULuvhUjSk+M6oc84Yn
 lSQO14tI842uxvC3CzB1obyMkgPnUd36Wp6aOabm6wRjXA4e/IXtLxgmsqxFka29otJmEchULog
 GDx9hAI0rARKhbT0Xwf/F3cFcAZ0Xlhw3OqrgzrtMScO+TQGbyqPK/xlxHEmCrvJnZjPsdD41cz
 444LXhg36S0kb4Tex2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150036

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> The bootloader can leave the display running, as it does on the SM8150
> HDK with the display card attached. Describe the MDSS reset so that the
> driver can bring the hardware into a known state before using it.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 293fcbacff34..a2d6e6947c4c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3817,6 +3817,7 @@ mdss: display-subsystem@ae00000 {
>  
>  			iommus = <&apps_smmu 0x800 0x420>;
>  
> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;

please put it under clocks like in other DTs

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
