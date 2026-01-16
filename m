Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0635CBCA
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558082; cv=none; b=Xbu8LfVms9IBC3VTup54Ny6qxOTJXtjN6ltJ+2I2EC9GQ0kP4K3Zjxpy4pA+uAePkGBDlXCkyNF1Ii3kklcp7U5Vekftci3V1ACCKDqXnrqmGSBByGNSL33rIJfibbTOuVbLRJY9XLcvWoo1L5Qs8q7eufTD4RdlhQY7Fa8KpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558082; c=relaxed/simple;
	bh=4QebrYHi8s49B6sj+XuT+a7lSGj2d/XpXHh/yb6bJ8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/zTA5qbVW63bOriSGyHx72OayJ+Hr13fur7HRqoTFBjBIXVhf44vA9dBdYIxGhDtUsVGv4wPWlz2enx7zcPOmOQvjBNVVoJnShBTN1rm+tSuqCgQ2dqXgYVtkhUC8USHy3dDuoEZTcgt8meAulclGiBlHZVlFJOK/s+7bG/wvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJwTJJGg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWtQcUd+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJwTJJGg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWtQcUd+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60G7vJK32818797
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 10:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gMp21ney8bm54p1fps9Pw9iiGOGyYYMunTK1tTna0vY=; b=FJwTJJGgW7eFqUaI
	6GTfqzIUGeKJva8mYQ4CVVPw6t0zLMsTCiZZKCkfHsi3cbvl2mQdJ5oq+t8mYnPq
	wY8cD7SvhiT1K3pMBK810jXv382zUkBCW9Js8ZxE+9Ot274WqpxhD1eNAMtM9VCV
	C2faTy3nsHxuLLb1MpBhVnKEamC9ZRxWK+ydhrrdLsBogMYmspZ8YBIq4+mnqE3X
	fiUCq4sY0KJuIVFZoQqR9BI+jcSVJMs4C5W4Qr13hXCOmTQfT7GBemWVRnPt7Cgj
	b8cG/XzCI8Giifi7jz4SX+gAfjDSGqZB8rbXFW/SzztNmhzPTZtu6ivTK6yRVplF
	t85RWg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99ahr85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 10:08:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a182d4e1so38664985a.0
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768558080; x=1769162880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMp21ney8bm54p1fps9Pw9iiGOGyYYMunTK1tTna0vY=;
        b=BWtQcUd+9ibywMpnJZCz/MJMAQvGJj3JrrznDDqCstsA3Zmx/ALgfrLPsFyX7XQ/SC
         euBaDdPEXVS+/frgXqz4yi15o9iccPQ0p8ni2pJUrRniSE5cKNpXvoUcwRSFTOl/ew/4
         nnvGCn/82gGtTODWbEAv8l8H4sYN6E6+YSRZa3ETrft7wJFshXRxtiCSJ/666/Dr7f4u
         3ncI3cpdFZe/OFHTatFWvSOxDMzBxakrP2f5mDU4mSzOJZmkTSSGW5vzoPEyKa0aNJeK
         Gm435Wm6lhCX7cRQs85kLDONEt6lxp4hShuxdjzId7XZwMvYTb1N1KtJvZ/bOY59+Qry
         14ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768558080; x=1769162880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMp21ney8bm54p1fps9Pw9iiGOGyYYMunTK1tTna0vY=;
        b=wVtWbPdExs9E9Ys9bctxgns7UfSZm92SnLk6Yx+FzG3lVLSACCWFFS8dgIZtGREn+B
         7sI1fwaeQtMQVFE/sxBqKC0v6dWdzoDHqfuk6ytYQnEl5bXyIlC5W1bcSog6aPCLksNY
         WiMc3v2U7FSvvVsRQnN1afbzBLzftejbKjywsetG7oyVUkDWRigJdqhSV1WjuTgjbodr
         J7g/qlHX5ZtozM6WL4OOgv9coY9V9mWfcBVAmC84d4sTPOE45dD3gH2xOzPXVb7+NgYM
         m59pg52DX+qPJVmp6m9WruKmLXTzWGQawM+D7ZeDk36HDDkecUT9ww7Osw2tTYwqWjmq
         H2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVMmGoSUrT9Uv4QdsDqyo/etTFAjaVgtGOzQEdC9Uc2ms92IuewfAUq9lnj+NuMFnR2gOj5BQfFoyHiHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8Oc6DOCxsRtfAQTKbg62bJD5Mc6RYIVGwv6pYQ1PF9V56R+3
	otHnn3AIOY82YA7F0r4A/uovvVMlwCbd6vyqOuQHe64bGHIB+0mZp72prw1VEMf1ZK7tjPDK4fV
	52QChpoUK9EkNt6T22UqerupOtLjrLPlhXWQlky+d2RyBjJnComSFoYBLF2OgR6T4kg==
X-Gm-Gg: AY/fxX4Udxqx8JKVWl4scJz0w83HsZxmfKPYFNcTsbKAH/eABUtR5LBvlY2Xah3fGSU
	hYsVJSSYxoXmRO5q7cO7FaHHGC/Tc0bEPKxzWERAgmDXEtwIWm9W3I8lIwfrYWniY8CrVCP+InF
	KIqCpIy3zkWyhDqm0vbFNNij7E6TLMy89dUm3Cy9/IU8ruSSw0jLDBxjl9FjPbQlE6ziB/e4W5t
	JYlhyjMSBGVu8fXE1H6L7AP8zABM3yrDZ0rx+rK8/0jawgN0P53I/LqI47NLcDxwFOz235zPO4c
	aA5HloaUXsPuIkD74srBeVsB95zv1UMj1qK/Jf5t6btTS4CStEVXWlBJEW9jspAvhm9nVlMM0gk
	p5rA8vEZalpN896x4Ggu9kibNvqRZJE2xoN76oSSsp4nR8MocXDGdyCnnkJzxkbHIxms=
X-Received: by 2002:a05:620a:4111:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8c6a670cca8mr237361785a.3.1768558079682;
        Fri, 16 Jan 2026 02:07:59 -0800 (PST)
X-Received: by 2002:a05:620a:4111:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8c6a670cca8mr237358785a.3.1768558079218;
        Fri, 16 Jan 2026 02:07:59 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654534c8c82sm2074279a12.29.2026.01.16.02.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 02:07:58 -0800 (PST)
Message-ID: <66a1716a-47f1-42ce-a72d-8c69d29410d3@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 11:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: msm8953-xiaomi-daisy: fix
 backlight
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
References: <20260116-pmi8950-wled-v3-0-e6c93de84079@mainlining.org>
 <20260116-pmi8950-wled-v3-7-e6c93de84079@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260116-pmi8950-wled-v3-7-e6c93de84079@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IQG6WMfMaEAZDfl2WwZhU2Vx3hTEBo2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA3NSBTYWx0ZWRfXyBVPriuAwhcH
 t5M06x3GIj6DZnl7OcoYojmFPzp37vBdFQxJxDhGG2+/G7fzkOE0WBXx7KWY4E7BsiR7szY51k4
 ief5Tr52bgodOScpzMtTRiWm1CaGXBxe1vECXBh3MD6X2MFD3gcfu2OfhNhpEmkzRCQ0IISgJf/
 g7XyyJT/euEtfzXBEFknlvXErmGBxhptf5aZXtBGmuw6ECaH5x2NRBmo4BGfVlLAbxvaWl46FMD
 6qeelBTESLTewni6kKeo1Bh1mPqC+ALeQZHYnpuVgcJLmOxgFJE4z6inDF0vLUHk7d02XfhYt4k
 t8irN5Y9/pMeUk+dkpqNU7SHspbjXsyFis9xxFeBoeTELG9AguIibqM9V+cCjhJCWhEgWy6zRPw
 I6PYy1dWCuVu7WbdY2ZnWtGqt/S6b8F55NJRKXA4SqGPsAgdjWXkhLZW58KpYaMfm2XaC+ql8MX
 cOSWbpBY7eyS2qrkFUw==
X-Proofpoint-GUID: IQG6WMfMaEAZDfl2WwZhU2Vx3hTEBo2G
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=696a0e00 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=HVKn8-F_4eW3eUG8FJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160075

On 1/16/26 8:07 AM, Barnabás Czémán wrote:
> The backlight on this device is connected via 3 strings. Currently,
> the DT claims only two are present, which results in visible stripes
> on the display (since every third backlight string remains unconfigured).
> 
> Fix the number of strings to avoid that.
> 
> Fixes: 38d779c26395 ("arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2 Lite")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

