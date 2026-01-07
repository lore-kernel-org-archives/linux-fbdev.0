Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D8302140
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795198; cv=none; b=SciekLuwEY4tG7zehejG474rRE4ielFy5VV95djInkt/kSaGELsjUfkzLECb+JPT77dOvWfKW7wYnQlnc+dzxsb5yYhixGfHuzznqIyBKWbbb7h1WSNvWuBXczu1y4sN5/U4t23A46CpC/4mKXCYxteDZxbl3sCRRyFl//EMxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795198; c=relaxed/simple;
	bh=rV7uwDQK9sVXXMMSbCrFkdiROsOoC7NEJyUS/32GXfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dH66IpaXnkDgzgLecf8N1mtyty5jF4boGqHnj2C9Oey77x5lFPdRcAvgoGLMcvyn3vjEbfamWytF8AdizyJgTS8zIRtUe5NrFVITEIu6Qe7SUtkbpPuEyNyjF3s8UVvEoXx4G/P0FdO3ZePKc/5bjpqitc9EPVUYRpEpcmTyAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DrmMxHN9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HlJtf0EY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrmMxHN9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HlJtf0EY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079e09w2593363
	for <linux-fbdev@vger.kernel.org>; Wed, 7 Jan 2026 14:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i88csJUcM2ULCrqraGjde9aKEzx82JPtrxGeziCgzEU=; b=DrmMxHN9fMHEppWv
	Xj5gayauNSS8e1mPVGpyWWqwnIjNqm9W5d4QjFtObGKEPP1wy0h0EnFKuDkDQl50
	kNcvZPQ0qyHGhvJMw5K1IKBzBgtt1mhs077WbJAYYq7oY4FNnDiISvtSiLjd9Bwr
	Irc4BojmDTTiDWqAAzQF/qayX/cDJBoax+NPc749Upi4dZyJnT2E330Ln+CAvQl2
	edV9ikj04F0s7Wugk77UXB3uNeBqKdnqAWj3axGFzw9DHseUOMjBFhJAf8ViX7SG
	BdnyNPiM7YGN5LTry9r3HsjuSXCzg90FdtgcY22XBDMEr4qtDday3GjwNYnkOOLk
	Tokrrg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn290s68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 14:13:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f3564e2321so4312021cf.3
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767795189; x=1768399989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i88csJUcM2ULCrqraGjde9aKEzx82JPtrxGeziCgzEU=;
        b=HlJtf0EYNkI3kCfJCUIMu3i/0JPjQHFKYnVDDPqsy+blESUiHX6gMEHb4NRtu1UXlE
         jK3ywHztRJNMWFCn68Oaopvmj8r9aHc97FTelQ8UaWKKQnRpCIiuMcqGn27BD/+/fp3a
         Qx+hoKylqqBE/zKHGBMaKr1sJ7HyGhKuhmoXxjVwbxrmItZ/kEbnxcNuXptQKVjPunAn
         AQ645X0aYMxb9i2aIXtDc2ih8cgwPlJo47dzx2RJxINu2+pHcQtR2kFTYlz6VFkjNgVV
         dGnC4Km+v5gkHtr6pi4TNprzNFkWWJq+Hkfu4z5zOdXZ/alLzXfjWjZmNwQg5p1pJ6LF
         x3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767795189; x=1768399989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i88csJUcM2ULCrqraGjde9aKEzx82JPtrxGeziCgzEU=;
        b=LZ5eLhprFv95U8ns06JdQ3CZRiW1XwCBEr9qLe3VAlfLcukH7+7VVCQQpw71ieWEQb
         yQSNMpZPP+x45EiokitUv3YC9VkielhTzprIY9M6o4RLKYVzYIvp0NJDgH91CViX51yt
         z8b8fF9/BdUd+5RiycGWnSMAEvmzyr0Dl5TZiNL987CBHQJ6PxRn5A0vlcXE5ghEoXoM
         Bx4PZ8Uyk6M+2wuAHaqMm1YShcBxoAL6YWn9D9R+eHYqt7V9bbFhloMGfjujz6o9eEhn
         Jfk1EFPeqnKumjsRENnzEgMABrFELUBMQd4aisE0PpmbOuIi6kQ5euKckjGIsNPSHhWX
         S/Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXtib2cMB1FDfSf8jvxa1NsVHAj9181LfzHqfmTZM5c506itqkQtJw9flXnOKK0dkeURnsOiPakcoQLXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mkWIul66VQ/ooxiUnPRdFqsBPDniT5de1OuV3RkXJIuwh1nL
	WnNDdHMUicTzexY9Pg0cUHoMvGH36TLrEf8jivoUYG6VBkPr47tqDIaIxtwKIOjEDgddy7xC5tt
	gFmD6BlN9IHFEihybXerS+HRl+0YM/F+7IYDRs3pzJyYeZxn/RKvGimXpsEEePJK3aw==
X-Gm-Gg: AY/fxX5+VjLj+zL4hRqg8uLmeJvnErhy6kvBWoaBE0c5XvlTF6SL46G8Fnza/B+BH7T
	u1is8QA+Vn8/GMF1U6+iIuOdKmprkNTsCtmgzvAK3jKRg54EzMAIKKnQlYLNP52ok8VqwIXSxx0
	mddYJaQ9O6dp4reZh1YkXjP11V1lPACYGxw7da7QBXozMab6S5aOzZQN+U7CMHo+6AZtMcnOlTT
	aqmbBTwh/UdLPiTBFQWb1TO0kAH5nhuMK5ulhMzomWCKecTVnK38iexC7yjOX49vUs2uzSwWOPH
	4Gl0khA3dhKhfmuS7bNvG2EnOJET5UStdc5KHRHd5KVaphPrWs/gOrNNlmJlVr950GdcGOCMTwG
	YjwUK3xGughG2FuewT5T70X5mSALtRBvGbkCF8tGlHogG5/CoHxajdsdzy0PX4x3N97I=
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr25633671cf.11.1767795189098;
        Wed, 07 Jan 2026 06:13:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBwq+C7m0bosWHj3HTwVxZmMkUGfTBcl5hp78f4iYACKooL8OU/CX/+Ny3sPLi5gByEeejsQ==
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr25632931cf.11.1767795188359;
        Wed, 07 Jan 2026 06:13:08 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d89csm4659986a12.35.2026.01.07.06.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:13:07 -0800 (PST)
Message-ID: <db0ee006-44bb-4587-b4d5-3f767cedc3cc@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 15:13:03 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: msm8953-xiaomi-daisy: fix backlight
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
 <20260107-pmi8950-wled-v1-5-5e52f5caa39c@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260107-pmi8950-wled-v1-5-5e52f5caa39c@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2tpXgcxXAmIUEueAGhBTIBt4nKxBuEEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwOSBTYWx0ZWRfX/W26RP8L0Xtg
 euiTBkrHPDctsAakLKLnjh16HLa+RaLb1khA0Vj3GU+otGe17Lq5Xg5MWvyKt9X9KQG6ZtnB105
 1UbxlkQpS1Kuv/P4ZANOY3nHXLCyfjtBeAWpATSmnQ1xg34lhPyd5bq4jGyXgf7+wUveaJqmRi8
 gNV6ILUqR/8jlrsGpfJVmMpxVMp4ENkkpZWroohVVkZ0oo1rRFl/Gakhv9RLQzfLNtVBJL225pb
 tNqobug8By8dWDYN0j18EaZ6iczGZPfkxxKzoF8Dohnd0ZlOI/jYcKgETLqls5od3uApEC/lpf7
 mPLFOsPF4Q00Er7qDww+2/qwUZYLMEwxobfudpTBe2PD1LUvUtplal2iRMWbDQeTvITjuOYy6Dp
 UHJiMnx7rYm2QlDGI+FW1yLzLcuAnfVmMzDju25tlWrXcgmnPCqalxxvo2GVMIccPKTdoEeE3NL
 0j0/h6w9g6eHPrrRCAw==
X-Authority-Analysis: v=2.4 cv=P7k3RyAu c=1 sm=1 tr=0 ts=695e69f6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=tgJsgVuRmq43osI8c0oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: 2tpXgcxXAmIUEueAGhBTIBt4nKxBuEEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070109

On 1/7/26 2:31 PM, Barnabás Czémán wrote:
> Set qcom,num-strings to 3 instead of 2 for avoid stripes.

"""
The backlight on this device is connected via 3 strings. Currently,
the DT claims only two are present, which results in visible stripes
on the display (since every third backlight string remains unconfigured).

Fix the number of strings to avoid that
"""

Konrad

> 
> Fixes: 38d779c26395 ("arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2 Lite")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> index ddd7af616794..59f873a06e4d 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
> @@ -157,7 +157,7 @@ &pm8953_resin {
>  
>  &pmi8950_wled {
>  	qcom,current-limit-microamp = <20000>;
> -	qcom,num-strings = <2>;
> +	qcom,num-strings = <3>;
>  
>  	status = "okay";
>  };
> 
