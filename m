Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB214329E67
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794743; cv=none; b=qFN23NAfQnNLcj8KDNhRL319PN0njQ0cK6aM3znYG0w3D+qmJ89p3zhj0VwTvQLqqqKcnuC3Wukorrr3B5rddb5X4OX46pcOl6UFd6lw0njJAUe3KmlCS4YyLnJFzT5tLK6TmTtrtLaPiMvhXuFxie8I6EYo/5KINkQL699cr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794743; c=relaxed/simple;
	bh=kHO1GfgESNMw3/GQ6yHWd3+WOk49vjbI2/ozirdvW5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6Hh72mhH2x284qPGDD2PlC/OpibZalfBLL5g2KvoxnukuOu/x5urHeuJRNABtHUmCzHiXpTjWCfQhEAGE84V772p4QaSyv0dd42ezIia6FaY5isYRLzGDbNejVyfkjApuJ3RLZIsbxgd2z2LIdBkj3pgUlc+fVYwy79WyTihdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldoPIHBj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aX7GE31L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldoPIHBj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aX7GE31L"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079egl82988483
	for <linux-fbdev@vger.kernel.org>; Wed, 7 Jan 2026 14:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/dYPUxZoqHhXGVsRsNUTNCnu3BPPm6di+RgA5mKj+Cc=; b=ldoPIHBjr0J4Kklj
	EQjEnUa8ADWp9M7lYVVQn39SuIKTOBnYVM+rnhq0BcizUeNc5pmtXvvvucdhRNAL
	eLxUu+pIDjBKo1JXCE8V/3aLZyN0sLl1eo3vDPGBP0ZXoNHe4C8wWTKIRBmUPYiz
	vtWqBRa4AGMmBRui9uWMmpfJRTq4sCzHEdUOXDKybVXNwysnyfblEcjA8X5P88Fr
	MQoS57S+Yp4tigvLlL7s9r+aw6edTjYIRzjjypt8NOpCHMCL8EzS5dHw2wvyhAhT
	O/KByy83gabv1tWoPgonqHidobYG5nOyzvr51B/ABKtXH6cbaenHnlrpKUFunK30
	gc0uaw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn2nrrc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 14:05:40 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-640e5edbce4so561931d50.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767794740; x=1768399540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dYPUxZoqHhXGVsRsNUTNCnu3BPPm6di+RgA5mKj+Cc=;
        b=aX7GE31LawS9Nqr/HA5fJq8uDSA7i0OIB3KF9KwlaSIPCs/mZhHvfAme4k32uH+gqz
         HPci4mmyywX6CV4tZmrMpB2qGsZMx2ZsoYc2UzfDMFu033QfqwGwAiUwhf1fuewbscjW
         ThDLTtri+gNPZ6E1oz03ws1msWLfrHsk4kw8uDDxwLL8j552d6X0UkdGnWke1Ps4fGdx
         yM6IJXf+Cw7D7+KR8rgpQ6lTLsjIo13A4fX/66joR3FgYuIDHtZOReTmyCJAteMTOxGA
         cKKZQ0XgbeUhqpg3bvvqRxh+mth9ra9UHShJhuoAiYfCVZPatSyMAHSwZvzOn528jyB6
         wLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794740; x=1768399540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dYPUxZoqHhXGVsRsNUTNCnu3BPPm6di+RgA5mKj+Cc=;
        b=Fdw6qKX6Bz+qY6xGR7SeGzOFhkh4Kq6u+2j0xI1T/Y4YliZcjaNBCSHQk9b4kXIW+b
         5QWuGL7Hv1U2HntZY0XTtQzI3wWTX+Ft5Xy0QCxSUHatl27d6iUiID9/qYxlymGWVdTg
         aqvMiASFMkTRCuRNkh2+VkKWuR6raKQOhTlytb2dPP69l1RH6K7YBO/AK2qaqMYgRsTg
         v/x7nL1bZgKgwCVbCrrVRWBjLWNf4D6EEVIyN3d5EvzcOvleKJ8R2Uzg3KJme1DyoNBp
         LkAIgAMTqZVHs7Sk8nO4OO9bb1MAWIUIslQ1M+Pb6LIMu6J7iPYk2l0tuIoRfXUBYd1B
         SHaA==
X-Forwarded-Encrypted: i=1; AJvYcCW59UwZmRewjjL2kmr9qtAQeGJ2HcG4K2SLYWWmkl3+9NRfkURJfSvyIYmWFMNlZBFV0BfzPqOHypARSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJq8gA4KaJ4UTEiF9sP3FPB9xXgDLk2xBZ19bxNw/RcquIR+Cn
	0r3paYFLZNEXeJ4y0AeHYUVBWUFdr5U+J0ufbEN09hLUxfB53hSSLOVjfRWSihXEGQAg+7y6HdD
	f7bhcc+52pQimrGtdlibLMBLvqXCCBwCv9FzK+G/yzIhX8zwBjOwMrtO8YknXUPXgZg==
X-Gm-Gg: AY/fxX72OoS5TnhnCrutW0KQX15Vh9o4qADt3M0nMvK0pgnpuAyRDfCK/VKkgkqBs5p
	wlTF3OcWIm9RkWujKLPa29+pH6jNjgKbvaAMnyZrLzSm2rRG636Re8uIIeHyCeRUmbDSTwwjud9
	MkwgXi6bHgOlP9JolOk0plgu7hj+GlIyLo6IW2Gxx8eKe8yBp3zP+Jq3x7y773ADx00jGe2KVPp
	kJ+4l0wLJTlG/z8RofxpTFAW5i+q0OLY+7Rq9wynZD/pRfvk9eKqXaCOQtbq9Itj1kAKTwTVzr5
	2m47UCtpVK2+JLL+vtf8lplOQvEZWPMoDe1yXh/45lio7EEzHKOQrmUkmSYF/4AzHi7hnOXEFxl
	JMhyl/lFezeScZUyP1SticoaXck0qYeqdO28mGILAqRZYnmHld2nhD0ouO6Qu3YcWzQU=
X-Received: by 2002:a05:690e:161c:b0:63f:b410:e8d with SMTP id 956f58d0204a3-64716c7da8cmr1450648d50.6.1767794740172;
        Wed, 07 Jan 2026 06:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuk8dtNnNc7djajDkI2qFNJzxGYcVWgt4Hwy4aMZohg0n1wAnt/4mZtVfjRdh0tsRspfFjoQ==
X-Received: by 2002:a05:690e:161c:b0:63f:b410:e8d with SMTP id 956f58d0204a3-64716c7da8cmr1450573d50.6.1767794737711;
        Wed, 07 Jan 2026 06:05:37 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c755sm527241966b.18.2026.01.07.06.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:05:36 -0800 (PST)
Message-ID: <990bc3d5-40d7-46c8-9e14-192aac7fd2cc@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 15:05:33 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] backlight: qcom-wled: Support ovp values for PMI8950
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
 <20260107-pmi8950-wled-v1-2-5e52f5caa39c@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260107-pmi8950-wled-v1-2-5e52f5caa39c@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwOSBTYWx0ZWRfX9xxxaVspguEq
 2KUAypjFZBkpLh6SBiShxnleQ08ZRrFaHbteIiiIYj+bfgh8O6X7RgBwOoFh7o4MpJhHF28Wlti
 ywEeUU6XGWDDIerpFQlKEaKaqP+rlSAIXIzcvZwqXw0SyhVxtCAbM5DKiKaKs88Jc385slkDtf+
 7mbbs4AHnSzuIVa99Tm8tMVHL1aCkKYOmy9s0w7VqxYqacekj76NXWA+v96pJ6DLiVg/bH1k1gV
 eewMlKUMAJJF1io0aaJneEmcgQww2yFJYewR3VrZvvsBIjBoC6cZaLSlThbBsEdhHlgHDPqSucd
 fYacj9IRR6+ps2I5YS74yp+I5HEEDRmNMuCmILTijN1imQtEFYVuoevP9voCN9stpP8LEUV6jBA
 OQMgIDNSnoFcFSApqc5dHWyW/Bps3ubRuMamqi/vHIGDZCfQDZWu/hJCUMMnKJawsSoY5fDHysH
 PFrOEh+1qwAwsbH/Z1g==
X-Authority-Analysis: v=2.4 cv=CYEFJbrl c=1 sm=1 tr=0 ts=695e6834 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=M3M7KMW9Y1EPzfeyKr8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: 7uXCOdw1ue7fQmyd2DpDdpSvgnB1AMal
X-Proofpoint-ORIG-GUID: 7uXCOdw1ue7fQmyd2DpDdpSvgnB1AMal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070109

On 1/7/26 2:31 PM, Barnabás Czémán wrote:
> WLED4 found in PMI8950 supports different ovp values.
> 
> Fixes: 10258bf4534bf ("backlight: qcom-wled: Add PMI8950 compatible")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

[...]

>  	case 4:
> -		u32_opts = wled4_opts;
> -		size = ARRAY_SIZE(wled4_opts);
> +		if (of_device_is_compatible(dev->of_node, "qcom,pmi8950-wled")) {
> +			u32_opts = pmi8950_wled4_opts;
> +			size = ARRAY_SIZE(pmi8950_wled4_opts);
> +		} else {
> +			u32_opts = wled4_opts;
> +			size = ARRAY_SIZE(wled4_opts);
> +		}

I really don't like how this driver went about abstracting parsing
all of that, but that's not your fault

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
