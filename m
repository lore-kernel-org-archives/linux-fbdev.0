Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC84352EE
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864177; cv=none; b=qX7+FXQHVwsCaFcUxU4oQOcDvvnUMHwj8Tub9AsuZFfeH0BHpzIWjW9pThVzJDk/4uVVm3FF1IWJpWe5//g/Grw8HqMEVZ/0cW5vDhhekU51VYKhY5K3lK2MI7WvSsqmxWYyX3444OX0G+mIM58qMdZFMDiPlsLgo6LzT5DWGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864177; c=relaxed/simple;
	bh=vKerELevSng66xC6jQJ3bmm9PzkzjOX3+h984hOwKT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5+G2OTY8UhxRG6a3XuzAXJ5KwB/J6eeT9y2yAIwWDJSc6ZN7ERcoUpKhJLJtXi7O6F61e5yGSGopXh7HBw0ikbwN0sMY3F3QvIq5DslRJVRHXYiiO//ezFi3+FggbCPJYcpAwFi1pQ64vz/YuTvo4bGmlg07x5YAUJFR1zLLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dyXLYG5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N3QjcwIQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyXLYG5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N3QjcwIQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6084OmNO3751446
	for <linux-fbdev@vger.kernel.org>; Thu, 8 Jan 2026 09:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ur81gEXIS6mzyuOT+3mLeiSWiGD1gehijf5jkGbJanY=; b=dyXLYG5yvBoRM3zd
	6WqgKT4hyI+1vpzW4PiJe0R82IZCp66vnO68/+bRnJIo+zP2g9mEc3ZostpuRWxh
	HaqHYSOhJowCtwdgdo4sPoYfOYlJy45DkH3PH38GArau0/6cRabZu+ITGTlpNVrc
	mlZbfxE/SO+kT+pOubgVAb/GB4vwJI32Dz0tqp/DhjyTmZ1ugb30nGkjXZgyvMvS
	34NPMqzaSOTCsITASMJ6a0mU5kNZ822ijdhw4SNG3XP7/eF5rQPlr3DHY7Esaes2
	09cYOWI97/oI1pzSEBxx+5qvt0PPGxzFwOfR6gzCAS00gxcHKizZBcyjrJOgAjmY
	2/9hdA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhuxctnpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 09:22:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88fd7ddba3fso10238896d6.1
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 01:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767864167; x=1768468967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ur81gEXIS6mzyuOT+3mLeiSWiGD1gehijf5jkGbJanY=;
        b=N3QjcwIQVyCgjmWyPgZSKRgEjl6ZU74/pzOtVxrlY3KLJM+4RN6i+dE5S17HVcLhEh
         xAU0RwHgMlnq2PCUDhPjmSphftsg8oIihTV0FbXc1PD9Ub4oq6j8IM4e0BQ8qA1fafpB
         VY+oYz9PwbQMc10HI7fXYnRzWfwRobEC8N2Xp7RgivaRQZNSkaDVNgw+kwYNpP4LqqD9
         6RYyaeW7sSp3011iUbe2Y24gN3po7gDghEgQmX04Zs7P1PmU2AeKOfG5+ihSM9TuDxlJ
         4Rjn5l2+0rCWIsuSQbH/xIogjKVti9kLJvG66APONPGufcrlyPjZnv14bim5ErAVpkGj
         YayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864167; x=1768468967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ur81gEXIS6mzyuOT+3mLeiSWiGD1gehijf5jkGbJanY=;
        b=QBIoFi0VKAXDpg5PH3TyGwVKSSlNU+Bnddt7p3TxBw2b5LZEEs+YNxmkUWAsNRDZSS
         X0Vvl+MJKwymeboL0uSW3T/ZuvA3bCngtS41vs8Tt2K55gQK+xDIWhHDukTMB9WIzkDP
         lK6UJQy9s8qj+TU8L1fBPutSSx1Ef1s1Id4TIaKNYqagCn44hQJhIeIaHsShFxHtLMpl
         V6IOKILTuxC093mz4OscR2CPvivfltX+osB6hNinRPd076K/IQYaqLBuig5g33JhIuqY
         Y/48GXd/YVcwrqND9M/dY2MoLBxsfjQrW7IbdGK0eEqktby2OYtllVNqG6Qn6hf1oN9P
         msDA==
X-Forwarded-Encrypted: i=1; AJvYcCX1POtrgmkStw7Aja44pZtB8wnA0SRzhZkqOqYQo+HCcDGgSyQrONSxgldJzdHsWPxY/PAh22w/H857zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDYdhWaJHfuBFGfZ0Kn+ZfwHXanUxKVBD/s2RaKtc5oN78MOG0
	0DGA5EgJ0bXtzWiEaOxRs2BMKQd1/D+89akKaz1KGowzuTK0/QvO+zg0ELN08zbmEjS8jwQVvRI
	2iDS6t/aFZg51IEEc0Xdux2a4rKnrhkvbDfsxcjr4uqVnswGvgw7Sn4nTWmCbcLQeFg==
X-Gm-Gg: AY/fxX5LBQSYjjKQwSgbJS/ZoAxlogRcGDFddvjFgZdeiZ4g2nDTg5InIUHnBtsHdKW
	J0RlyLN/p/B9zHo9BFTw7W7mBm/pLCZ6Yc5iDHyKMheTMQsOsv7cN0qE9XldTefMPZ+az+SARxo
	JXX8PHtzWjf2VMF2rVz5+lobPCIerBWeVa3knF4zLIILWFVRr8vFeg3PNo+GGW/zSIyTLqaChdi
	62Isks5CPg9IglSL4QTGDK52tjZMIgCQ04ypMfUuyhBaHl6//XkhzmDsUsIcH9U9zSSuNPkU/8e
	OQljy0wPx0afQ17257EkfhgpJr7iTx6qZWidf5aX4H9SjOyJGUUWZl2ue7SX42sRC+WsxY5UfLJ
	EN35iZOtmLbZ72dy+m3C2R8uR6BxKj94MlUassHCnaePvTgFUssPrXv4xL6te5WoJaE8=
X-Received: by 2002:a05:622a:307:b0:4ee:1e33:bc45 with SMTP id d75a77b69052e-4ffb48b558dmr58978781cf.5.1767864167513;
        Thu, 08 Jan 2026 01:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESz7XxqM9XjQeyJC6Vabm1GdmsiTvWUlPsr3BFnCnOv6Uphl9e+re+AckjETMw29nhVuUAjA==
X-Received: by 2002:a05:622a:307:b0:4ee:1e33:bc45 with SMTP id d75a77b69052e-4ffb48b558dmr58978571cf.5.1767864166971;
        Thu, 08 Jan 2026 01:22:46 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a230db0sm767583766b.2.2026.01.08.01.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:22:46 -0800 (PST)
Message-ID: <88beddf1-2a76-42d5-9798-3840e0e86cea@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 10:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: backlight: qcom-wled: Document ovp
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
References: <20260108-pmi8950-wled-v2-0-8687f23147d7@mainlining.org>
 <20260108-pmi8950-wled-v2-3-8687f23147d7@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260108-pmi8950-wled-v2-3-8687f23147d7@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MiBTYWx0ZWRfX196wzSh9sLKX
 LoTehst2Ly7R/4rGQ+r1FwfFmjv1T+T13T7JXOzPhBkWeC3AAbY7GrSpIsuaDH1Z7LxNLGP+niA
 S7bYAWYEpRozB4IgSZvBcuvPx8btYjzLnvnXu29rwDDIa9IhvdiSzN5v+8nj7c87+nZ7bhWNk9Y
 S7qD5FnvEqG32Bsvmm1ajpDdt8B9HjsW6rL68onWvNf7MnQ0sw0e/WIIxldN4t+2FsW/y39WM53
 6jGk+tJvs8pEP1eX4PfOruenUMAN4RaEpsNZrXlzEe9AJ7OhGVyLjfQvxEHpFsq6nnIIHQZ/II+
 28F9runGITbrncbyzeivYkuSgBNs6a7u1Uj0i3ahzexQXaL7Xa7xgBGhuNCTlA4D+WEvy0LiC+R
 +O7WTfFu3vDNVn9Ge45J6ZIxY9unSZ5C8EM87ZmKyzkfJvt+FSlaarqKXI0p319X0uBfdNnG8hR
 pbhbbgIhxRBST7AGyvg==
X-Proofpoint-ORIG-GUID: gnzkVtk24DY0X4sdtTggpBMa44uENXVy
X-Authority-Analysis: v=2.4 cv=SPdPlevH c=1 sm=1 tr=0 ts=695f7768 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=TDiaKIjp1V8PvaA6ZvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=YF3nxe-81eYA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: gnzkVtk24DY0X4sdtTggpBMa44uENXVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080062

On 1/8/26 4:43 AM, Barnabás Czémán wrote:
> Document ovp values supported by wled found in PMI8950.
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

