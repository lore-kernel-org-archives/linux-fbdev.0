Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1335FF4F
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864140; cv=none; b=mkVsSArvP1n/XTGNImsTQTA/FIgrItoP1bgXkhrsv0LhheZub4aV+Pgw2Zc2nwFy4Rjde8u/ltq/bRr2kUS/GnsGua3GzbJZqh5sbPTMNuKsw/tL3R/tmoK7q0XjpNknW+YzD49U4xKfW3jtOhLSiD5Zfz3iv16A4/ncdSY2oDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864140; c=relaxed/simple;
	bh=NykHxiLesQcmL2nusIInhtRLoMtoWy5GzdgE9w8Y6EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CixPLMIqDahLC8u8XrYsj3x0u7YkSlPc+RbGYHDaPlBAgvUeOvScpnf8VrgoP1W1hV/7nPyM+mcFCHdluqGfbDMvI3np/feWIHKY7xi45j/cuTQgC2b40i4b+q7bXeMw7Pf1D+8M6azSF2Ph2OdkUMxZTpqUsfIEo7+JT+4kix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=plQhJESP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Re+uvKy1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="plQhJESP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Re+uvKy1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60896Ib74050108
	for <linux-fbdev@vger.kernel.org>; Thu, 8 Jan 2026 09:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NykHxiLesQcmL2nusIInhtRLoMtoWy5GzdgE9w8Y6EM=; b=plQhJESPDxEeM+e6
	WXA3kc/FSUTvnZS1khnkQ/Vjx0lvvLW6JQ0AE4QeMbPjlI/iVXQ98yXUt3SLs8F/
	0VGcfTyI2POoi/JlLLyev8vCDbJlIy9LP6BBYnGD6SpbVlrRB4e/NicTKFXxKnBJ
	nBDzQ9QVlHg2CBAHq7ubQ2swcWWqDXD3UeZ/zyhpb649EQV45S24Qv4KGgFhM3nQ
	f7OFya0bzEfnloulgLTlSqfxe6qBs7xiFDREP9FU2hj3fip1f60e53LDINSpBOsf
	G0RdJ7zWPVd/tpneNzO8uO5uACEd050IBCJVc5KuQy6HXi9R1rMB+RzadENkNLd6
	Vnqs1Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj2n8hdk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 09:22:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88885bc90a2so7490186d6.1
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767864133; x=1768468933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NykHxiLesQcmL2nusIInhtRLoMtoWy5GzdgE9w8Y6EM=;
        b=Re+uvKy1XG/zRpfe+uhQOjfwedit7InXKmvml4t4Ghh/cfeR4ZYCQ3uh3pr6QoobWQ
         M7C1yhKc8CXmZg4yY/hKFvXiD+On/zdSL9NDZ1KsulHSfIEo6Ia0GPs6/6yVvsUtROeQ
         l32ro5ptfk3vA96Z4Ud7IGDIcK2nfmKTy29KvC8Ugk/tafEcruWbW5H0+W8REBuiyiM9
         Fs+7NB+XsRgLzzZD+moX9QBoliIH+TbmdJLa+Y0dTlWDl7HxQjD+KOTK7OkKOunlGjmg
         TvLItDF1uppMNZD3qj57BNT1Nk2d/hmbHZNYwaaffPMz+Jo3nRtKMd8x78Sa57EUvhnT
         geKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864133; x=1768468933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NykHxiLesQcmL2nusIInhtRLoMtoWy5GzdgE9w8Y6EM=;
        b=GcWG5YGtFbPnG3fLp1q44LWJelS+6/7enmzzakl65QCt0kN4RrpDepUJqg2ciJ9LMF
         MkFJ2Px9fP3OWyjglG7vx7gUOUnLd3IkAf7j+kCBcyJFP9VLPzzLImcYf5X7JheNXSYT
         ohXjgYFnkPbf8+JntfHJNbTvZnPStPEebOdIdcQGsscxCfdJaDVKPmNjTTl0+5GqNvL5
         fWqHeWDT9kfvgiFLLtrd+OSZjsWs0Ga+FA/LNgvZYhvCNGo/aaMxMofnkJ/PZjg4MEkH
         sk2a8nY7LtUsDKFZqAHcDtGxGIGKZ280UyKHFofzfk+frWP4RZfkaJbe3uSORKsqov4B
         3uIg==
X-Forwarded-Encrypted: i=1; AJvYcCWum0sDhm4/PyOTB8wViIGXG8iTaLFn9PiiwquoDJDmoWmfGrCqfriNHJwRAF2e5fmAcg+zkdW0MJuPYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4gQNkeLkyUJm+CzwA9wYu9c+rTginYIzkNkr5Io5Sm/nk2/K
	hLDqy2/bzBte1p4cG3zFyIKiPZj2l4Pu+pf2tF9cWM87wEM6201Jr7e/9zMkyW/W/MA+P3c9Ak7
	MIb6RqvRH+4V5uEUf8gFwZUQAS4McXU8Wjvz+DUI2BxyMtSBUBAyTbfNmHVRW+WTDxw==
X-Gm-Gg: AY/fxX7z+qy9Y/S9pmRAvJ5HA2XT8kc3ejntrxCDwlwwIg7YFxPaOfesVc3KTJyE1VK
	crqnLlIzR62biTIhJ3/oLeKnTfplUwr+2jxYt3J5TipsI/quXyF3B9dzE2GkYYAyFk2TIL6YXXm
	X8b3eMtPODKu9X6D0zMy/8mvrr6XlCIAFHmW7PA+0xXnqznJ0lCLaO8KFpNJKbJAN1hDYyPv+8S
	a/gL15axyadCH1TCuQmrwx738gfxuQEDMVa+tCcVAr9ITzsXSITIA9SrNvyg5k1XC7CNBNqq879
	1GTPYYd5E/UapvWDV4PiAI1OZt1KLCQfEa4B94mPX5jCfgqEm+E2YC59X/yw8lelJv5CdtJ2ENW
	kRBVyvFAY672GtiSi8XziMp8I773yof7TbCeQErEt80wO0dOgMKvbhC9ymvr/8SAL+K8=
X-Received: by 2002:a05:622a:211:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4ffb4a73847mr53808771cf.9.1767864132593;
        Thu, 08 Jan 2026 01:22:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY4wdNCuBrMFoo9DDpE5DqvPtrXyk71CRz9mJOSVhhSxeHi/+bMqRghkU10RrDVSHGxOxCIg==
X-Received: by 2002:a05:622a:211:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4ffb4a73847mr53808561cf.9.1767864132191;
        Thu, 08 Jan 2026 01:22:12 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be641e0sm6930953a12.22.2026.01.08.01.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:22:11 -0800 (PST)
Message-ID: <52778327-69bb-4f6c-8d64-094f33809480@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 10:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: backlight: qcom-wled: Document ovp
 values for PMI8994
To: barnabas.czeman@mainlining.org
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kiran Gunda <quic_kgunda@quicinc.com>, Helge Deller <deller@gmx.de>,
        Luca Weiss <luca@lucaweiss.eu>, Konrad Dybcio <konradybcio@kernel.org>,
        Eugene Lepshy <fekz115@gmail.com>,
        Gianluca Boiano <morf3089@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20260108-pmi8950-wled-v2-0-8687f23147d7@mainlining.org>
 <20260108-pmi8950-wled-v2-1-8687f23147d7@mainlining.org>
 <45a2b510-c825-4191-975a-1389f4f18903@oss.qualcomm.com>
 <c7bca43b1b912a6a100d83229d78abde@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c7bca43b1b912a6a100d83229d78abde@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d+j4CBjE c=1 sm=1 tr=0 ts=695f7745 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=mtDAOQl0mCcS2X4wXL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: jm0_VlMdWMtMbbNsZ4U8rSD3_nbjLTfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MiBTYWx0ZWRfX2z4AbD5AuTBx
 ONzw2CqiMvrPyraptvzdTr2Jv2w9pbosTL9fYbiFs/FG8xXTvalqJNnl2cozvhEG5gKmpjUoIaX
 4B/qyDWbKnDjKYxRsPJnapPNwa7+QOZi6zMJ118wybdQHAYsjQvkkGgNYnjqC55I8txnFZgmvup
 08YPpfiFJYE1Pdqg39a1FWabOoKgqNKMWVpDX3u7LlBGUf8hHAPJpxcMAgea6sfr/NGcXiGokLc
 juVmhvjH2dTv7tNmdW+IRHNA4GxE2nb7GB1TNF+AQU6K3z72FVGfqCatJcnl/sKhE6lcd+Y5tBG
 VVlg6OLW//WM7T821yLxkmpR4KmTKHD508iPO2fMrfH9CmAY1v+pJuJQTeIVWMQs6DApwUoHmZ6
 VT82IhZlQaF72u8oJEkGeJA31uoFolOzrdi3fWuPOH+ikjCqWMY1dn9f7IXt//ob7UYEWwfzLxE
 aZ5aO/bvt592NFRYflg==
X-Proofpoint-GUID: jm0_VlMdWMtMbbNsZ4U8rSD3_nbjLTfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080062

On 1/8/26 10:17 AM, barnabas.czeman@mainlining.org wrote:
> On 2026-01-08 09:54, Konrad Dybcio wrote:
>> On 1/8/26 4:43 AM, Barnabás Czémán wrote:
>>> Document ovp values supported by wled found in PMI8994.
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> I reviewed a version of this that said PMI8950, which is very much
>> not the same..
>>
>> Let me try and get some more docs to confirm or deny what you're
>> saying..
> I have sent it for the previous revision msm-4.4 contains the documentation.
> https://lore.kernel.org/all/95f7c89fdf9b856f567a498cc56ecfa5@mainlining.org/T/#u

Right, but I didn't send any reply acknowledging that.

On v1, my review tag meant "I concur this is the case for PMI8950"

Because you carried it in v2, it appears as if I said "I concur this
is the case for PMI8994", which is not what I then said.

Konrad
