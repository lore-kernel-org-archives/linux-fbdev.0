Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850A32548C
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794627; cv=none; b=eoFn80nsC3ocommUW0xWG7JmwQ/LaZYBwW83IcXYTFnW0/lHuB7uWdDu9YGSq/YBE1TWOXWtfRwS5fmNAbzrpfYhFaJYtMRmfwmP07BVApThlsUsqWA8YtrOPJ5SZcHfjgJ33swHqr492G9yB8eyHxpKbkv9um1haXRc4F+JoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794627; c=relaxed/simple;
	bh=+eBgn1FXDfynTOWRPQJQcXgChNeUrZJfwmqaclXZWmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFO9qcKyAr/SE8UOPSM32iPbw8Ce080hSmGqxLcm45K5y3gvDo3Bj14jh/kT/coqLiYE2S6+w9U0x+hs9NND72oWci9ZE9GN5Ii3ZU7N5/tkfBiepnwAtctWfHpzIkbSIix+7xUsFWUmgH3NtL5mTxM3bOadfmGl9ymRj3EzvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iSNboE4c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BeQCoNn8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iSNboE4c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BeQCoNn8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607E1gXa2379157
	for <linux-fbdev@vger.kernel.org>; Wed, 7 Jan 2026 14:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGUEfPXYzSComK/4z89HH9yCe+htm7JQCogZL+pmhcU=; b=iSNboE4cXnSfjv6Q
	T9IeoddUr7lZJW8JimTlQkX8C++dWLYVbrQ3iI8zPng6hDQm7HKgCdwBej/yd8UP
	DdT4+bAvoTp3Jj+n+IElHDSqe2QA9boZVBngHYuDdp15iYidSpx59EPsmBOpwjmD
	L4eEBIWgi4TPqLnRfUqZyphcvWM85J/1bkwbon5pN2YoSeZvpFF3ocYNh5Clos7i
	Y/+ckUU78QqaWvGIjZSSUtWe5olAFd96RWRQZ5/tqdDRPVW2OT0nz8x0oumcz1To
	4dzl9vRKocCBRkcKmeHZxmvdS236A4GGd8wjXQElzTrQ29gcf/RDtEqWNXTzXpNI
	DMkEdQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhjn4s95t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 14:03:43 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64475bee138so528033d50.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767794622; x=1768399422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGUEfPXYzSComK/4z89HH9yCe+htm7JQCogZL+pmhcU=;
        b=BeQCoNn85dpOdRPpdu5Kj/HNnppYqNZ8jbVakwqbyxUaxNAqs/8Z9fAjHytgcl/y4B
         XIVpVvoodBQKXxIIeUh1g4oucWKDGP8tOexD3+VdbiAPZiMpQiv98Pp5AZhgtnqhEV3C
         fBlqMT05KIzxboZ11feNiz9IPFc4baUMeA94yX/XCMSWnER4SUI0qq4J4pPtQaPE4Mlu
         4oLVldvV3jA9Y0neTV1DMogS31G/DyaIdC/jEfh1sc5d7gK0rDcCa1QkmXLo5WjP3ich
         HhlxfAqJwv6eaiVZ0rer8jxMMn9xm11Lx7hvEP/ETZAPPepGaDiXiNxJWk8EwtBcIci3
         fedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794622; x=1768399422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGUEfPXYzSComK/4z89HH9yCe+htm7JQCogZL+pmhcU=;
        b=hoMUqMYjFEwhKCk1IOww3L++0SbnxQG28mvuN8QB9FhVlQ+9Odv6vowwLUNeOZy51p
         4En2i/7fgqaDVm149hV6RIqdCTE+gOIyoUmujY2y0oI0yUjhkIwUU1Aza9WuUkA29Oev
         qyM27cI0e8sxu7/NPalQq0SOTRTme+a73uAyZCfd73ZgHvbZHSNEyFmDSJ/0L6jwaU0z
         HugnZzX0E/bD+LrzvQjNTzH4M4Yw+YkMGx9sFp6MWD0AmrSJJQ78pX/BMLs6v++5Szpc
         66x0qcIBjdVuDlYLboqmrQwHAP1bGS6czz75oSbduhiLVZ+JujdPmHuCV3cyW3bgUnVb
         nMlA==
X-Forwarded-Encrypted: i=1; AJvYcCVsiqdeY4tHd97h08/CwLg4hcAwPT9s/bNRuOQLCnoksvB4hUpiR8/N2q3NGsKeZ2+qyMst5c2MJ9CElA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0ckW6TajcskJleD0OJ7cB8MkDODE1Nb5rcCVPKFgQ7DBqwih
	mXEExuPm7XgLW44Scri8q0uOH04Z33Ygx11l4BoOJcHKvBSuQg1zfyLwk6VLPCfhhjyWbbAAZxG
	6Vv9jhU2mvY7l1MHBoVZ3lLNyyx5gqglN4o8FYxbQtv4cKG2mmYpZlP5XN+f7HgHdmw==
X-Gm-Gg: AY/fxX7sURwffAzEawpkax2qfbG+L32P8Op2qi6iexjj34yGP7fdUDdyAVyPjhmdOSJ
	txmVNrFW4G6J4jqVP/UTG6OfjwMlDUWUVehKMPoGf2Umv2LQTO0XHoEKmzCrBxUws8mMCac8Jo2
	lqyudHk3qwqjDiSk8o2+ePdtPsm8siLW7FhHXvkP4c/qoK+dAkoxUSogfBCVLYcYKOt0R1zTTA7
	pCh7YHGWsV9YMEM6WFPuqBo5JoSBKrhbt7WbXTLufY0/KKk9X3v1JCfX7cOB8EuQJB9AgBugiZk
	kLbuKGK3OOheS9ZKZT4Sj1zB34rwI2DkaUe0IiYgL54xtPyUNdI8qH8HQb6W0a+Unx3Q/Fi1Gau
	7PdH4abIVhXGhEdE+9Va5XkiWE5w1/a1EI3QXWcz3apcAFjxygExClS0VhiSOAkIyuSE=
X-Received: by 2002:a05:690e:1486:b0:646:5127:ad64 with SMTP id 956f58d0204a3-64716c9291fmr1920181d50.8.1767794622203;
        Wed, 07 Jan 2026 06:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+yD6IwhCJBS0M0IdpMAihYXZ2W52QH5LWTaJGmcGDkAkN6V6xxs4QcaIu2Pf8pk26NxzbQA==
X-Received: by 2002:a05:690e:1486:b0:646:5127:ad64 with SMTP id 956f58d0204a3-64716c9291fmr1920088d50.8.1767794620266;
        Wed, 07 Jan 2026 06:03:40 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4571078a12.10.2026.01.07.06.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:03:39 -0800 (PST)
Message-ID: <bfa54cfd-b5cd-47c6-b941-3bb5673d19f6@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 15:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: backlight: qcom-wled: Document ovp
 values for PMI8950
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kiran Gunda <quic_kgunda@quicinc.com>, Helge Deller <deller@gmx.de>,
        Luca Weiss <luca@lucaweiss.eu>, Konrad Dybcio <konradybcio@kernel.org>,
        Eugene Lepshy <fekz115@gmail.com>,
        Gianluca Boiano <morf3089@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20260107-pmi8950-wled-v1-0-5e52f5caa39c@mainlining.org>
 <20260107-pmi8950-wled-v1-1-5e52f5caa39c@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260107-pmi8950-wled-v1-1-5e52f5caa39c@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LJhrgZW9 c=1 sm=1 tr=0 ts=695e67bf cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=WZtaUWDQifwC2z0g4SgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwOCBTYWx0ZWRfX+agQN2Do1NDF
 W2aB3ufMetHiogt9lrQ01BBKSI0iuAi9jNSA/NhsYM1diElKQytthrnuv+mRNsIXVPJ+HcMuWuS
 zg5NXcpX8DsuWNpZG3x1ul1v5sWFplKzDBFuQWA7qn9bNIDoU1sfvRo6DVoxRTpAue8MlNT1qHD
 14pI2jz9r1tsY9ZhTxg1KFDxQ91NOJ/DSACvfB2r5P8x/xrXmYlVL/AAX9geuhB/7EqI32hS2Nd
 v+VzNBHPfkMPUvg6eYk2NJ/KM8pruTXYQk6mIInkKHQKLKPZaauvHhGfS6g2y0IZHDuD6i5rU3s
 DW0BlLgUKJ5KdfKiG4ct5zPNYEV0NsMAj31Rgh/TSXK3loY9q3H2/aozxCg9XLai5mvQre+0zn1
 Wn7g9e3J73uKyeRzbT6KvY/D2MCQN6LlcKpX97bF22WwZXT/Y6ht7y32zE4C3tte8Q0Ls2vg2ms
 OzC2LYzu6M0QsY57Vyg==
X-Proofpoint-GUID: rO0g_stEhLh-Q6a0I5R8lk-RsjYl2d76
X-Proofpoint-ORIG-GUID: rO0g_stEhLh-Q6a0I5R8lk-RsjYl2d76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070108

On 1/7/26 2:31 PM, Barnabás Czémán wrote:
> Document ovp values supported by wled found in PMI8950.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.yaml           | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> index a8490781011d..306fb6642617 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> @@ -98,8 +98,6 @@ properties:
>      description: |
>        Over-voltage protection limit. This property is for WLED4 only.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 18100, 19600, 29600, 31100 ]
> -    default: 29600
>  
>    qcom,num-strings:
>      description: |
> @@ -239,6 +237,24 @@ allOf:
>            minimum: 0
>            maximum: 4095
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,pmi8950-wled
> +
> +    then:
> +      properties:
> +        qcom,ovp-millivolt:
> +          enum: [ 17800, 19400, 29500, 31000 ]
> +          default: 29500
> +
> +    else:
> +      properties:
> +        qcom,ovp-millivolt:
> +          enum: [ 18100, 19600, 29600, 31100 ]
> +          default: 29600

Out of the supported ones:

{ .compatible = "qcom,pmi8950-wled", .data = (void *)4 },
{ .compatible = "qcom,pmi8994-wled", .data = (void *)4 },
{ .compatible = "qcom,pmi8998-wled", .data = (void *)4 },
{ .compatible = "qcom,pm660l-wled", .data = (void *)4 },

I can confirm both allowed and default values for PMI8950/98/PM660L

I could not find any data for PMI8994 (or PMI8996, the essentially
PMI8994-revbump), but it's very probable that 8950 is an oddball,
so:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
