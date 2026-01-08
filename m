Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6843ACF17
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862493; cv=none; b=WNstssmabwl9j6uAaWP/+lAxph7H9O+0IuDDPYPJRKbxiiECxDfmCsrl1gzY81DzAD70MoMm5jR9pH1HKRsqK8I7Fr+2JlnODHbCX3Aw9tWAxCexE1aiIbPw9t5TqHZyu6ghxvxNRLgmTFd5QvRFWNfsS3IeiEE1JxZgZO9sgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862493; c=relaxed/simple;
	bh=mVSMXFK7v+Ah1A7LBJUtANrEGYnXVMe+OP0c2TZf/J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU4FRxxlyYpgmHvAEL9ravp8nmva3mcSUyeBI9RQWWKrpFTKsxPk85MjavaSSewuOslfXJ/AozwrFVe+RY1lG4DYbUi7QSloBzHrWjBDk/dtZlt+lE2IOPcEuZRjShMwTfCTNVRrC9vNmnefI0jLBQQWYuShV4tSVvHBd8GqyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/Bb5zSa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mrjhl7Ez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/Bb5zSa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mrjhl7Ez"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60846Gme2780200
	for <linux-fbdev@vger.kernel.org>; Thu, 8 Jan 2026 08:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yoe34/R7xZJT8mu6kS6uEUp3vVo/O98wM0lwlPWZ0Hw=; b=Y/Bb5zSaYvFdWnf9
	awnXNWIyId5BHWwCbCccY6ArNvfk2q1nmPmyJx+RNUQGOEQeXZavfE+cWYce/IC9
	omeP7S6yRGQ1dMdbZaMuq8vRsdWQZ8ZJIFXQxaJ47wdOwBWe72+/C0yZKN3ji/ch
	t14YsuAz3ofZ4U7u0kA4lrAUR/inDAV5xxx6A8HMtE2EcAXcgXA+tJ5eEfOM0dAs
	/bnveI08c+Uf1hHIHozvyzhjSNxXwwrHgK0BWe4wXFHc3J2vxhzaK1crRB5eWEo3
	aKmJJKmtKcXoFCvuMGgzBze6OXT48ibkQ5e1IcERJXEcj+lP9riFt7D0/8ukMNIi
	IUNmzA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj58ugsua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 08:54:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1e17aa706so11942471cf.2
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767862477; x=1768467277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoe34/R7xZJT8mu6kS6uEUp3vVo/O98wM0lwlPWZ0Hw=;
        b=Mrjhl7EzbXy3I2SqTBflfUT0ptztZTZwu91OLxSv4JFJVVdTsVIQ9CAGAwYHcUvCRy
         phPrnXNdq2QkeM7+e2vZcxeV9jWizyh/+ziQc//MZ7PElu17u0XrszgRTRYOviPzqHHR
         7N5tjbtdQzmsw+luUhku49wsDmBMYMuBb4JhtkM1fImf02qwEca0GK/rQE1gC1NVeEiB
         t7PPvAParvTFF8SSBwIevxIgsDC3hhlxscwZa9j8uD0Q6sOs1VK4v3a8agLohIdjHqi4
         GicoIwJtUMsLBQ7ST4eM80zGP6s8V8i2PFa5gqOUz10HS3fIy8UU+ykZTsPYqo1/LGal
         BfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862477; x=1768467277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoe34/R7xZJT8mu6kS6uEUp3vVo/O98wM0lwlPWZ0Hw=;
        b=lEdDBgJXdwMDAE4LQGLVmHmwV0JgFhz13Ud/18ychPJ/i9ObUFczb1GwH9oCRONuvP
         GUC00KKBaiZ8IaunB7Bvo/SL95bfdmTFjuxHYBuehSL5K3GPy4H3xenYJDmOMBUl4FfB
         CYavlyA6ZjlHV3qA2B5QJJHomtoe7RTRm6C1imqPiw2ToUn0uFyxf5DDNG84cZt71pPl
         HTjZFg2fzUhrA8J1FnLmsJNRi+TA5AGjT8kUon3wjTXFwUb2AFLcdnm1XFUlqXwclSqn
         7/3naXtO8OUvmt/EXhKwUZ9WvMsAe9JvW52YQLRMpcI5nV1WJ7l3pUM7C4RCpr6dPpFG
         Rs/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3vGKQN4RnlDfeXp5NJ22IC540ja2zaurT88v+H1YNE6k7Ei9cryMpi0SNFAs4BHVCN5PdZKLtIup7kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFnocbFcle5WuZO8cXHP5xRsqCeEQqKp6Wup6iw6b9oMPrTCZ2
	hSByqYpCt81Bjs9goo5CxiTZ3tDejqPNcTQClhtvkp+6dQ0C6ABtWSWSbl0tDosxmzJxiDNIbs0
	JLCStB4I0fDHkdStC3M0ZSoS+VwAnRN5sAR1zWE8bWBcY4pk3TyApBr1qoLRdoB12tA==
X-Gm-Gg: AY/fxX4CwsL9mOBi+LuzdPtMfa2CNKIjKJDw7DswZbVVukDA6umUiSnPUIFu84JGed7
	WWxvfogjKUl2wQ3w2YFPnEst212PCFzJw7HAw+ew5HvNYpl2Hg/uvknKGsXAvRe43LwWMJlfK+S
	DE+j8B9S4Q9iYkCQFvAMd2i6tVArAf3rAuzFiiW6bkdIW7yapcN6JJqcFTvG0Y1fYNlb1ph3Qmm
	zV0udynXnf61gMek7hvXnokZHpNrjVUGKyD9rYIa6OSdNw/F9yBotUU7foLbWsdfKNlxYWHoq2w
	A/Fkc8HmmGgaoMkEhBSPIUC7GqkJIq2WdU+o4fw6YoG+BF+q3NkLPXtdyfFBHnwrHPpBjGQELdC
	cwtxErIUhfmvMdceXhRafPvn4f3lp7naC87JtcXNVaGxBU+r11Z62K8vo9lQEk6NLoW4=
X-Received: by 2002:a05:622a:408:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ffb487595amr54667771cf.4.1767862477037;
        Thu, 08 Jan 2026 00:54:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Zu4B4c1u8CU9ENDyOwL5KHQpxYNvhOydpv0jjl8YDszapOdfdCaPnmBYxJ0lXpbM7zjfFQ==
X-Received: by 2002:a05:622a:408:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ffb487595amr54667601cf.4.1767862476596;
        Thu, 08 Jan 2026 00:54:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm6893952a12.33.2026.01.08.00.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:54:36 -0800 (PST)
Message-ID: <45a2b510-c825-4191-975a-1389f4f18903@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:54:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: backlight: qcom-wled: Document ovp
 values for PMI8994
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
 <20260108-pmi8950-wled-v2-1-8687f23147d7@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260108-pmi8950-wled-v2-1-8687f23147d7@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1OSBTYWx0ZWRfXym4fd5odFOMc
 JtxFaztHLLYur6JR/98kZ5i8TrUawQlvAQDRaMFYDeA2EEK6rd6jTYD5XHl6d1mKKQlfRzcBtmV
 sTnRR0YtWj3vmcXvfVtsvceQjAvsw56Zg5gETeHJPCLSnQxUhDodze57dBM7oqQJyAYdnh1yDdU
 SBIO25y3TL4whjHsbXByDOL78T8GUC8Bb3A5tX7CSmn4eM0t6e6mDc1rwOdpzUD1e7ox72h3V/R
 o8PxzhgiNhqMhZs6WneYHhnP6stneviKo2RXJtfekR+XLvdKOaxYDFlTYM6U07uLr417qQw6eMt
 VvxFO9LeGYxhnUeQfD3j+HouNkVBrkbsc029TiVUwPAwBcA5NZt6X16xJJIJcUuFkDzoFkFkdgF
 Whq7fwqijjBNTYjIfwm6ERr0dEauUto1E4Z1WlOZ28zKEcQenRM+vyGNEedKKkZRyCZblCQrsfu
 AF88LSlogeD6xXFol4A==
X-Proofpoint-GUID: G88KJLmNbGenPlu9-xFWsV5FuRNH8egX
X-Proofpoint-ORIG-GUID: G88KJLmNbGenPlu9-xFWsV5FuRNH8egX
X-Authority-Analysis: v=2.4 cv=CMgnnBrD c=1 sm=1 tr=0 ts=695f70ce cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OuZLqq7tAAAA:8
 a=RLX663m6bzWGV7rLlMIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080059

On 1/8/26 4:43 AM, Barnabás Czémán wrote:
> Document ovp values supported by wled found in PMI8994.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I reviewed a version of this that said PMI8950, which is very much
not the same..

Let me try and get some more docs to confirm or deny what you're
saying..

Konrad

> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.yaml         | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> index a8490781011d..19166186a1ff 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> @@ -98,8 +98,8 @@ properties:
>      description: |
>        Over-voltage protection limit. This property is for WLED4 only.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [ 18100, 19600, 29600, 31100 ]
> -    default: 29600
> +    minimum: 17800
> +    maximum: 31100
>  
>    qcom,num-strings:
>      description: |
> @@ -239,6 +239,24 @@ allOf:
>            minimum: 0
>            maximum: 4095
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,pmi8994-wled
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
> +
>  required:
>    - compatible
>    - reg
> 
