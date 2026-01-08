Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225923033D6
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864168; cv=none; b=su/77eehSRlEr6lGl8GkHQGEI88/6qhHTjnPS5X4ObKJQJ1JdIxUPg80MK+Ch3mhCNiKxwWooY9mQl5rVHi1FWvwoj1UAile4iABdE72LcyJ99kuMkjbawp8ywPBBhTHrLGjCLrIWIpxLSnaKfqLt/VEVZMdwC714/HfgkluDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864168; c=relaxed/simple;
	bh=7vG6OaMdoY88+gn1n5QHVM4pj2RKJcsBaH9fAfIpfg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VG69UO3a4bcoOWVvvu2xyqSUKvv7XYupDGjPhp6PKpYSWqjdI4eWw2IztcvVx97iNR53ryv6t8uNqNKabMbWL1njBpLDZ6II0XM/52BUSdYY8Qa+5RYVVHqrnPwqVaidSwgeouIFEa49jq7qK0xeDKFGeJFF6f44L2hEHYOSmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zr/0udCu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D8z2iyyb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zr/0udCu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D8z2iyyb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088wYPf1571617
	for <linux-fbdev@vger.kernel.org>; Thu, 8 Jan 2026 09:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	raxQEHkAo5wpTxNFXj2x0R0HctM1cb4gUoaC2aMmpdo=; b=Zr/0udCuTdVjdeaN
	aqzIN+PgSWqcWrssxYyKhYJvB2EuS5UAlwenZHEQxPknppA+07BnnDLms1YbvGor
	+gKF4wRx1lFqRyIQNXJD1rzRWN9cs+UQHNKshFjiERedss0waCsRClHStbnN5uKR
	1QngrrNvX9yy3seieG5fQ8EBu/EARmQ6jkVenbm3vXygOlYGA0KCIkEnQ4tR7akF
	1w4a1+nQOwWtHGchdrGWLj/w/Ix+1+GIR/7dEx0riPYxjb0WrGFzmu7jl6mgTdk/
	JINBnDt4l9/4BEfFMoplvE/JIT5LwEZymbnPXrV+3bKoy1+HuqxWD6G1EhpwfcmT
	2N6RSg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hqr3au-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 09:22:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8893be16bf2so7789816d6.0
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767864157; x=1768468957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raxQEHkAo5wpTxNFXj2x0R0HctM1cb4gUoaC2aMmpdo=;
        b=D8z2iyybUghcejjTEAOamYuv5ZDVj85ymjC2gMIlKxIPkLwBV/Jj/X/LoiK+m8Pyqh
         fskYmNAuvryGntPXf4mY0GWXKBpBkgVjyWegiikahWh2syCasbRxM/ihBXkSXjFTKQi7
         gktPJVq9sDlT9Zxumm6fxLgrVacYUwb1ES46oDLBLJTmQphXKuPYxLDrXr8aTyMPuXwq
         U2jqNve0yX3fO6MnIqA9XbY0FUgp6YFwam/k9panIap/KVPX1DwsKdF+99oxEU/IGhpQ
         2R+9dm27+RZWbpYf145En/Klec34wMmz2a9gECGycftpD37ghiFUv+mYTnrh0Fo+hU2y
         N14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864157; x=1768468957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raxQEHkAo5wpTxNFXj2x0R0HctM1cb4gUoaC2aMmpdo=;
        b=Y8AdFU7ZuG1kdvxm0NVqlUYc3W2TPF5WBfC0PDl/I8N0av8TOpot0W3TZWVxFsSGlm
         ZGGhJSRgtuLgmook/plBfXkgqKIkZxIHqowrX3xlg1jdlzHJ8+6jpNinEfdo+Sc4VFxi
         Mikij/qwEgnQH83QSZZZhet8wIu9bRX2Nbemnk+Xb7hLvclGFneAWdI8GOPG8ULONaWg
         qQLoB0ln1KsM6nz63k+ABTWGTF+hn4qsUI8AgOasu606LXZXYISi0r3FSP9aGaZS5FkE
         YuC7eoQALEWukXebM8fHYTwSZ7eCQUZ8PY5u+c4hjLFI4q6WzoDZECFdb8uPzSTwD+iM
         IkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/rMdD16Vs1JDEY1LwnxHjEAzHW3hOlkYIg4mjz/YCrbuCAtGXcB7YrEUIRLZX6IPRUwjKVF8Z1qCbew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPqYJ5+LcGbMzotrsglzFsMH3k0I/3CMjWW06X9dI1SC1Qy99
	BBqd5y7n79oZ7LcTGVcAZcLoj92aNoAIF/zQ6ummiS1fqKy0b1w8L3JMTmNKuCGOuTvkGqSs9T+
	ixpPgf7UIUTxA2rk0H5vNna+huNrhG4KhZDqYhfWB2O4gNyPaeZEaelQVsEAt82UuZg==
X-Gm-Gg: AY/fxX7hJAdmN240k1Tlt5fJWnii63w3G3ySzUFePHhCfWor7QUbeC09Y7r4O2/sUMA
	S0TBSnoFO/+fjz4hHGbm44Ir+LzisK5iODNTHExamYMpIgx++lA1LiHr4igfZObfaKV75MTDJ9M
	qpAtkYPWLif8n1PIDl6gi7mNUjh8xRDbnGBZIJKw63GfaBHwPY8VcOKKwXtqSP99cmj4ASI90Zw
	PjVhv1mNGK385Vi3hQTmwD2G0SoxKPDgu8nwRwOAjSmcWHo3UaplZQYiSKg0evBqJUlgWZMOQqN
	cEDlrovQ+p5EEc/y4dX4MVf4q6tBm8DrgOSSrArcho8fn7wkbmR0Rh1cTnyo3rrVe/K39f74u/5
	iXan4QNBjDbn2b4SwkHfGSMko3JlvxixUnsEjb5NLObXEVA/d96aJGeyFrnlrENU8A5c=
X-Received: by 2002:ac8:5907:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4ffb4a256bamr58410761cf.7.1767864156974;
        Thu, 08 Jan 2026 01:22:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgk+SEzsp6wNWefdP+6JTGQNVInVd34cgE/aXxaCXZgCrNOJott53yL5pFKxHfuIwh/vLdMg==
X-Received: by 2002:ac8:5907:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4ffb4a256bamr58410441cf.7.1767864156534;
        Thu, 08 Jan 2026 01:22:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3113sm751657566b.43.2026.01.08.01.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:22:35 -0800 (PST)
Message-ID: <e8c37f1d-53d5-43e4-9c8e-be44753aa1e1@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 10:22:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] backlight: qcom-wled: Support ovp values for
 PMI8994
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
 <20260108-pmi8950-wled-v2-2-8687f23147d7@mainlining.org>
 <736c8986-7adf-446e-9720-c4a71272825b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <736c8986-7adf-446e-9720-c4a71272825b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=695f775d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OuZLqq7tAAAA:8
 a=H4St_WrzmzoQhtTZYGsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: sXf9JYzbI3ldj6_kTrn0-dI_HbR0Uldo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MiBTYWx0ZWRfX82s9AkD6CM8Y
 Y9Atj5Q+RWmh03yspDrrsw2GHpDnTMY0yM2/rtCwhucecnYGqO1xADiJa9IkWVJ6dBOvhCKb85i
 Teld3Q6cHh9jiNCyrkTXc7+V+10OfCgAxGiUHttOFOtDFdXArmeYi+VMW4uRdkYudkCm2gWcAXb
 i2+QItDx7/difmANTk9zLXWDJ72f3lhD15cJBWY/DE1y+fjMgBHDt8VBHlK1ply59ps4gwQlDiZ
 yO+z/2WIwUwIa78PsDXFqDTB8M9eDrw3BHPq3dz5MMzbd+lx26CFZAEnPwn9ohG8yXtqPVEheSr
 55+5uDljvbjNsopZbkBM6Lds0xMjBD9X6eX7cJO+Rm57kukDIOIcv/8q7fcN6ax6mhH7rTTnCgA
 v6mzWlat4jAo1fAZjlydPsAtwRodR6j0mGPkGKB0SPAtH3RCYpfLHT6/VWsCeqr96NwQ7MhMGv1
 fI7AxYpeo2O2CyFzzVA==
X-Proofpoint-ORIG-GUID: sXf9JYzbI3ldj6_kTrn0-dI_HbR0Uldo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080062

On 1/8/26 9:55 AM, Konrad Dybcio wrote:
> On 1/8/26 4:43 AM, Barnabás Czémán wrote:
>> WLED4 found in PMI8994 supports different ovp values.
>>
>> Fixes: 6fc632d3e3e0 ("video: backlight: qcom-wled: Add PMI8994 compatible")
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
> 
> Likewise, I reviewed a version that said PMI8950 instead.

We can keep it because PMI8994 seems to fall under the same category
indeed

Konrad
