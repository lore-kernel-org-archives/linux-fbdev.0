Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46922A1E1
	for <linux-fbdev@vger.kernel.org>; Fri,  9 Jan 2026 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956959; cv=none; b=CqDfgaCvVGuhAFh1xt2O89Qn7oSXHJShpRn8+akG/1qKh6H+yuCkphy55cbxrjfFD3aOZXXqSHX+kSbMEoHm2rfvDFEChWCXBEZGtJW48X+YFCTc+sG3bxE4h0stZj0Yfox6l8LjUPiDFbw457U1c0ZQ+tHUhiIW1LVepb/5fG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956959; c=relaxed/simple;
	bh=np5AHXSBZDD+N/+A8BMXsBKSc4+aFegJWYRGSXEX2+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1n9ylgudqm+RY0VtNcmYvgFIvXZC8Ow3rYidwik92HpEEUifuylApTm9LdNdA+vNzaGfRJumbR8Icbp+OWnvxl0j+oip70KYoGVCrS75uO362mDKNhxvWyuQYf3+FjasPi9T6ttMftfuWbT/aaWqN0TaP4pSK3tpOUZ5UX4F3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dpuIFfHM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C34PH7LM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dpuIFfHM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C34PH7LM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098M2RI2328141
	for <linux-fbdev@vger.kernel.org>; Fri, 9 Jan 2026 11:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cfOxBAB/NL8Y1LHRkR5yqZTg4muif21ux/cBVZr9MtM=; b=dpuIFfHM0GgisAWD
	pwfwW0apkVLGLOvgZl06nguD8hLBDQxeyLBo0N2hVQD6PXncccyYLsro85pdCPOd
	/054B9hOaZwSrulWucN9qbdiUl3jIJTP2YcXJNUFxQqhjGVLWuCkFL8uunRfSVO0
	Mf/Ghz6AIbzhXpCcNkYdGrHJbDCwTudG9rowmnHds3Gzcw1kDzBidHerU4TZIIQT
	LDhOSEQH8ryNejcKLbUrtQoOzUiYSpoRXKo6F8sDFU/fFkW1JDKR5p5Tq1ZjEYaQ
	urj1UBmzs2+zIA+Gh098UxRob28VLnHmC/BHOuPdyyZcy/kPSjLrioSb/eGx2ZFa
	znrZcw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjfdab312-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Fri, 09 Jan 2026 11:09:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1e17aa706so17269361cf.2
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Jan 2026 03:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767956955; x=1768561755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfOxBAB/NL8Y1LHRkR5yqZTg4muif21ux/cBVZr9MtM=;
        b=C34PH7LMffjGDHX/6fDwsViHXmGaqU/xgvzmPuq0Frghq2IR2G2hTcM1PiH7J1Qzkt
         eY73mLpszu4zsghOHupaMetTlUB+JHxue4bysptdx6PGgZ8m2++MBZ0OVvDwZRCsfFEu
         sjG0i3ub27fSXZUt3b5DWpRSQNEyH/q7VGgepoNvuFR+kIapTzm+kT541in2WOFau19f
         dxS1YPusI5VGTxxcK1kFxMoAlLH1Ll9rqbKpy/+pNH9C+oospeEb/WAwkYw1k8h+rBpU
         hjGSGg92qlNCuIdv5YEiPyxE1/dqG0vs7svjYa5q6GfA1lydrR1w3XQx8aKIelLIcGCq
         ypBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956955; x=1768561755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfOxBAB/NL8Y1LHRkR5yqZTg4muif21ux/cBVZr9MtM=;
        b=THGSI3BwdYF7xPulsNkQJbHiegly+qKnAXrMHWQW6w07XHLGGm0a/ayl5s/BGtrLSa
         jxpN5FRJOoN0XfW+5vRAtYNjpKDQSAjiKguUqm7DV8Rzhzp/Bni64WsZxCIJ7oYsXKRb
         27rveF8JDDWnzcMrTls6k1NifHiTkpHrZlwSJXUDggKd88EU3DvXtBzZtyoKIIHbKTUa
         BQczk014hpAjrMmXc3hmq1vq1DlIy7WQPMozcQS1BVXkZgJTM9faC8+CwEhPSLmrZ+nb
         V0bjiamucH2smLSMfuM+SILDJQxNblTS0CLnCB9tDeL/sUt9C3sVsgLXPw9iVGIjhSvp
         UfOA==
X-Forwarded-Encrypted: i=1; AJvYcCXy8gzL3HUtSGQyKmju/ZbfZaM/wvz99987I3qZK8LQNHLCdIDLHGboOMoCyPXmInrzTBU8Aot1ALghsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtxJQhdQ9xsnVUrFvPY0rOMFQb+c8dqsiZLxEEbATxsIe87nh
	s2xgYzHme3fJzhcrLxEd9GyscRZKY4n6jdN8LE3mhWgcW+frazcXzgkvc6o2AtPTcDSHw+bMHzz
	/Aaw0aiIqfr8M6yK7NrngxpcDxRnsHVBgsL+/DEZ/6KGNSWKnl5v7pG4AX1h5YVOacA==
X-Gm-Gg: AY/fxX6fM324W6I3PLpKgtBsswDCYl9u6bQ4UaMOqjIiznlIkEUwGHHzRg6VnU0JRt2
	cGWq1cTgWEeqXBoJVy2TkmLdWyZGrwLH2sU1lC/I0eMoAhI019zbd300gIZkNw8ZQ9xhnp3Mbv0
	0sB6PEpclp81G4jjRH6jv12aO8flP6Q/ri86xFrMZJIfTbPBr6IhJBt2TXjJ1xDjnkkPy+p5lRA
	2zACyM9l/qWCU0M0HT0mUkRnm3SvwWNkyCgaHj2unxco/r90iLaIK7G+OLbriYNTT9K1fZdq97z
	nbM/isAedVcPcYD4ac2cJnxFQW4mSfpqtP+iPS+JNlbtxkiJAYQX1b754D5JSZjGWFih8lu0M78
	AJHfeJJmPugh9LcW9ZWGZxPoAGwsvZhsETJmxCusmc+xnqccXlFYRly8789FDM5rasG0=
X-Received: by 2002:ac8:5d4d:0:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4ffb4a3c298mr106639321cf.10.1767956955268;
        Fri, 09 Jan 2026 03:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuVugm+h0bz8TunWq+Dll8IN1kIYmy69NaY5S00gzUkJiOLR/Y+VssGj7zYAE7ibYohbDivA==
X-Received: by 2002:ac8:5d4d:0:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4ffb4a3c298mr106639061cf.10.1767956954810;
        Fri, 09 Jan 2026 03:09:14 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d508csm11212953a12.13.2026.01.09.03.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:09:14 -0800 (PST)
Message-ID: <0fe51f7f-9b77-4bff-ab1c-21c44a863a7a@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 12:09:11 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] backlight: qcom-wled: Support ovp values for
 PMI8994
To: barnabas.czeman@mainlining.org, Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
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
 <20260108-pmi8950-wled-v2-2-8687f23147d7@mainlining.org>
 <aV-UyhP7wllSBpYj@aspen.lan>
 <67acbe8ff2496e18a99165d794a7bae8@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <67acbe8ff2496e18a99165d794a7bae8@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ue1ciaSN c=1 sm=1 tr=0 ts=6960e1db cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=dvh1Nh-0K4mN0UgEr80A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: 66Gkv9ZyVnnWmOCHVBapqrBIloAgK_3y
X-Proofpoint-GUID: 66Gkv9ZyVnnWmOCHVBapqrBIloAgK_3y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA4MSBTYWx0ZWRfX76wG9yPwdSQG
 GzqA2PAgdex/L/rTvf3bCVyC5m5FR2lZS+OeWHOAjPltm9d1kzf6ZvA2Ui12MY7vFo8ok3rPPDe
 iVJ2CxcwMPf4rwfoWiRmuavvV3PnxmxtfnXF0OJeW9TFEuQEyNCwfhcNy//viVliMa69u/onBrp
 41VnRgfqa5xU07DBVIFGbkGFgC4uF2+jYMTGOlqrdRYVWAjm3rTAahkuVilKz64a89+wkqTNMbh
 P0VDTmksdIz/kGRZvxeBI59JbCzcrjT576VW9/pd0Ot+0i/5sxic8NU0ALAnLz9BBCbDYVK/YU9
 urzPbhrwNMxseL3+bt64gmNvRxt2R8AxMmXB52DkwcpOfVN+2IVATuxtvC+pPNbhqI24LS4lMol
 WIM/ZcsFBYON74vtsJlkRmuJY5DLVrytNT9HV0sC2HZFQcGKE1zCvOim0ibziWIMFBHYc2/6mO5
 nI1wliKi5s5O+tFu74A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090081

On 1/9/26 7:36 AM, barnabas.czeman@mainlining.org wrote:
> On 2026-01-08 12:28, Daniel Thompson wrote:
>> On Thu, Jan 08, 2026 at 04:43:20AM +0100, Barnabás Czémán wrote:
>>> WLED4 found in PMI8994 supports different ovp values.
>>>
>>> Fixes: 6fc632d3e3e0 ("video: backlight: qcom-wled: Add PMI8994 compatible")
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---
>>>  drivers/video/backlight/qcom-wled.c | 41 +++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 39 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
>>> index a63bb42c8f8b..5decbd39b789 100644
>>> --- a/drivers/video/backlight/qcom-wled.c
>>> +++ b/drivers/video/backlight/qcom-wled.c
>>> @@ -1244,6 +1244,15 @@ static const struct wled_var_cfg wled4_ovp_cfg = {
>>>      .size = ARRAY_SIZE(wled4_ovp_values),
>>>  };
>>>
>>> +static const u32 pmi8994_wled_ovp_values[] = {
>>> +    31000, 29500, 19400, 17800,
>>> +};
>>> +
>>> +static const struct wled_var_cfg pmi8994_wled_ovp_cfg = {
>>> +    .values = pmi8994_wled_ovp_values,
>>> +    .size = ARRAY_SIZE(pmi8994_wled_ovp_values),
>>> +};
>>> +
>>
>> Do these *have* to be named after one of the two PMICs that implement
>> this OVP range.
>>
>> Would something like wled4_alternative_ovp_values[] (and the same
>> throughout the patch) be more descriptive?
> I don't know. I don't like the PMIC naming either but at least it
> descriptive about wich PMIC is needing these values.
> I think PMIC naming would be fine if compatibles what representing the
> same configurations would be deprecated and used as a fallback compatbile
> style.
> I mean we could kept the first added compatible for a configuration.
> Maybe they should be named diferently i don't know if WLEDs have subversion.

Every PMIC peripheral is versioned.

WLED has separate versioning for the digital and analog parts:

PMIC		ANA	DIG
---------------------------
PMI8937		2.0	1.0 (also needs the quirk)
PMI8950		2.0	1.0
PMI8994		2.0	1.0
PMI8996		2.1	1.0
PMI8998		3.1	3.0
PM660L		4.1	4.0

I don't know for sure if "PMIC4 with WLED ANA/DIG 3.x" a good
discriminant though..

Konrad
