Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B164410D02
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864186; cv=none; b=tJQ9KQ8uqbQy2R5jlPTbD9UbfqeuULa4tL4Lbk5o8hNU+17+5a9YLiQakA7jWutirzv7yUigCWQGLQaMkC5j8zsMFlRHb9vbpOWQon2LUUp0VLfrtvDuPkdyMx1kXAHy7VydTk5jxzaUTQJXeIyy+x8jNo2W9gpxQdIrJ/AiOxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864186; c=relaxed/simple;
	bh=rEK9eOmfwrcdm9xKIPuyi2yOvQ6nKX2oKik+EL0r2Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIfL9Rpf6IVY04ca1nWonyQw0MEcA/eeNm5cwu8yu/hPtyHFF0yG2y1y9HzODMb1rp55V6uomPUUy8N1u4ymEeXHVCuAM0p6uAqwhmuf1FbGgmIGd0ryhgbjlJjaem9S7XnUrysHeBM/OR2hasbnxl9UrTcewC4cisIf0z4/bJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mYqkHID8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XBFKmzmT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mYqkHID8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XBFKmzmT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088wAH51570573
	for <linux-fbdev@vger.kernel.org>; Thu, 8 Jan 2026 09:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o4qHXzXN/j3GloedtwAbja7LzZdHCV0m7/7mZLc2m/8=; b=mYqkHID8mg2NfpF8
	gqQcF0cxspHvu4+F2yjd6y/tJ9Uqj/hLpuU10za9QN/bjEQOsCrGJP0GR73LkmRl
	4UVnKKZE3pantLlDnLBq/eZAKZvrWhVa+1AgsKaGaBnd0PUBcZzKHo3MjqemZR0H
	8fIlZ2W6U6i+bUDhihG5ZkUt6Xl1IZ+LrR2y7zke+srPFoLchlm6oplP2+iE1e/2
	ESlPhKZbg0f9CQdZHSxbiqSas8groGlYgpabrEs0etQ9W59QUWMfeQibh9+usZyU
	5PiB8cxZTANW1A6enj95UlbHWFKSsUqWhGUWmXs7/Lv/WdLxdKrgZSbTDfUFd7vk
	tjKeFQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hqr3by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 09:22:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b196719e0fso92249885a.2
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767864176; x=1768468976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4qHXzXN/j3GloedtwAbja7LzZdHCV0m7/7mZLc2m/8=;
        b=XBFKmzmTNIO1g50RLe6gqTF1W/AbhJS/feLzFeA4mzph5YHLI3h0H76Jf6kEkmZSb5
         8zPYvKka8rGKw/25GvORKgANOu7IaJ9qdClWxd67mZKLf7cyOmD3dXP/raI1tfcJ+ito
         7PPOeveRtstlOYnRmCaL7IeQag64tkTy9Lwi1MHjIAUwOJ3m04doXhPB41YJ3YDr+D4P
         QwKSxTGolw482C5B0wpNip4LhbkcriJt0ulJYL9Lbh6oQSfbyqT9O5ChTn8EYkKrLl5v
         zfEvE+jw6ydDOFj8mNeelqjXPfTqLg2t5BnNw8x/NKgS4NY7mwfdEhBWr9VUMX58H2Aa
         KeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864176; x=1768468976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4qHXzXN/j3GloedtwAbja7LzZdHCV0m7/7mZLc2m/8=;
        b=uFgKo/Ro0kGQdx0HlC3U/q8jg0rIVcOfWpxSgGgLM+sfC4U7Asy+26Rior1qv/Bsa4
         2wl4yD2+45oqnIGjfcoWpNq5I4pJwsb1k1vGYrZQvsAFZm+/SmBQKxDMGwRQMpW4miwe
         pol+y9unHSXDXyKsvkX+EYJukt4uwp8ws+ZwpUBqXCXQj3LI+kX+GT3wrz96Lam+4sPi
         K+kbCWiJV/9FERtoxWP1IKWTqaGZ2IOyGH1SmzdNFOTXWP1AlRavadF/la0yMNl5wg0e
         DtU/oz2m829hQqjIY5f/rUotyWHkptjyjlv1bZTmMUyJptxN5OE9dfvlVGhu3E3Uz6Ab
         YAcA==
X-Forwarded-Encrypted: i=1; AJvYcCU9izmCPcPwqts1Y3ghPfdXi4QdpjrC7Vk9cJWcID2vHBT/Ofcox5ZR5abScqbv7EigGEK8+oLNAZFE2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/y0MmcQWcb8XCLBaOFwnm70EssUrjdMoa7qAaVsfsm+/r7KFK
	xc9yfWTCKR286Eo0un5Jx5YC741IihkB5o0bUkDZA+k3eGp+Ou9LspA8A0stlAJcVqAScQEcY8f
	MDOqEMcJm6UipT/TCtA5D+H7CMK4XGINXEwmLF0ouW52QiWm7unfLkKmOo/lFmqL08A==
X-Gm-Gg: AY/fxX5EalTNcAdOCanyN0TQKwgcu5ngmFnFrt7aF+704TNSXtUcBSuJyKTh5WEJp5u
	UYv+TQlzmYDWcnc22s/hP3BpmhDpamnmNXf0Y4PxwIOkoH9xVI7nZEYKOyxWRIUlpYXXwMHoRVS
	avM2NS3OgktCZPbHKNRtZpF3KOmJrblBtX5rVQXYCTDO1GkxsslzIiMNZZJjtZqgcm6Zqg3eKuT
	eUKCgn4O0HjwdJXNgOBZIW37ylTEXCgX8XjWKjfSLDTa4VDGBXMqivI2qgAVjyoPNPv4nsGHlud
	7hv38bRvY0FYDIw46wo5jMSNQJ2/ZwnXUB1SGDxHtthOdOZHAiJRXAfmEp2sySy+hZQfoFxZp2g
	5nZ8yLx3Ck8H0ETVRN6kvRtQdxllrJEIelmfAdodcsfcPUouYj6Q+aus5iXWaNTpfu8Q=
X-Received: by 2002:a05:620a:40cb:b0:8b2:e704:55fe with SMTP id af79cd13be357-8c3894104edmr508522585a.10.1767864176210;
        Thu, 08 Jan 2026 01:22:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzo9qVwE2Z0L9gMrnjAB3lduyOMVsOLQ8jFn4jFHZjA763oWPC0dpsRmyX5dSTtMfXTGlU5w==
X-Received: by 2002:a05:620a:40cb:b0:8b2:e704:55fe with SMTP id af79cd13be357-8c3894104edmr508519885a.10.1767864175781;
        Thu, 08 Jan 2026 01:22:55 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a230db0sm767583766b.2.2026.01.08.01.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:22:55 -0800 (PST)
Message-ID: <0b768afe-8bed-4ee3-83af-45bb51faecbd@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 10:22:52 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] backlight: qcom-wled: Fix ovp values for PMI8950
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
References: <20260108-pmi8950-wled-v2-0-8687f23147d7@mainlining.org>
 <20260108-pmi8950-wled-v2-4-8687f23147d7@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260108-pmi8950-wled-v2-4-8687f23147d7@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=695f7771 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=x0-Ntm4DP0gVEan9CnAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: c9lC98hC9ipCs28YpHtNf1Pi3UuVsOK9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MiBTYWx0ZWRfXwhW0eeM5VT0v
 1Xs/LAT1fh/w3h95KDWl5uLe81VpIzXzq8UQER/lU+6TG+wKsU0uBGnxcc96CLi1ljPoekrNv4V
 EFGdkAlQmS5ZBheQc1UPXJrb+nryWWoa6yFLz7a6pYiL35XzrTvb7rBGrJQ1CaNFZ53QzKW8w8F
 1xnb6dcxg/ZlF1uiqtpnZjgnulTdoIGyfMEhKOhrF9ZN7cwxMCxT3E4sre+1Wqy3CK4AOIBWhvG
 SGgm92vQquQVaroU/cyyI2uqxYKOyjHKnQqviqk6nNdIW5E6Q4NuP/q1avNRtdy0cBxHxKfZ2r5
 /BXMetk2BKUGwywXEFcn56q/M9IgLi5VJqyHVzXou5kUwil3THTnmOcAYrUGw+v7LKLmfP438LM
 5QG5cnNIHxExjPwPj6XyrT8rql7RrqTIry7lRbfKa3Q+AwikIViehWaHPb7pOuvQvhL099xQslI
 hhSdlPxM2amMpf2RgQg==
X-Proofpoint-ORIG-GUID: c9lC98hC9ipCs28YpHtNf1Pi3UuVsOK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080062

On 1/8/26 4:43 AM, Barnabás Czémán wrote:
> PMI8950 WLED support same ovp values like PMI8994 WLED.
> 
> Fixes: 10258bf4534b ("backlight: qcom-wled: Add PMI8950 compatible")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

