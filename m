Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD942A57D
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864078; cv=none; b=OoyZ/GQob+ebM/Q0c4KQpggYTu55qEMT8/l/vf0nVSq3kJNmx39YhBlofQdlYcTFmUflSW8jhx1Sjq0ftaFb2BSa33JohS3uu8B9DN8SV1Lz1oPkEo8XwmP/nAo4eRCOqc3PfuP6sIvGoPaOcfz8td3ImCQCQK0oP6MBb0BJbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864078; c=relaxed/simple;
	bh=0l6Iqs3MgqzCjVQEYOZPwQFM0SA2heWQHlyq1HLJ6Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3N/J0HyzZLv5kXO2RnX9mm7jMn4unGvLH+hfSeaw9W63++cF9zi56x3HspjMpjZclJLK7O/SqDAZ2tg2ZJh4GLtW0vMqtOab3s6FwfEd4vDCSP9uesV+5V8TYfg4sa0BjZtzGYmaG4M171yMgNBK9YcOaXjfsRRz5nKBp9B68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GsYouXFJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G0wVTuRy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GsYouXFJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0wVTuRy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088hBOM4049342
	for <linux-fbdev@vger.kernel.org>; Thu, 8 Jan 2026 09:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RUASEvoKgRbhk1dUkVLvuBQGOMUb3++LPBZvsx88wnc=; b=GsYouXFJYnNMjuVs
	IW9p0883DTxHMonKCRgmL/qi+ODHEw59CvDzzE8ITwPDCXk8weNAmtaQm/YQdtdx
	CqP8NtLsqrrglui9Y1Xw7nR7T4pqHQ0U5aPZERxKnqH1MjjQW2crPSezbyHg0SUl
	NPoQD6xyKGzVzNf0MRMCxH1GCos+0cWXJTgzR62uJt6T+R4wXiANh1BlEvXxmBWM
	kcSTJhTHR55Lgp1DeuqsEKlT2qP+47zwrPzCQ70mb7r1rTgPQmjaJhU0fRSgq/SC
	CNZhfeWHmsUAr1C7DKuE0u7QItPhjIQcot8F2GNXY0z4cUG3pUQhq+h80yOKTmPt
	aZwpaw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj2n8hde8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 09:21:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bedacab1e0so100630685a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767864067; x=1768468867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUASEvoKgRbhk1dUkVLvuBQGOMUb3++LPBZvsx88wnc=;
        b=G0wVTuRyYUAsO3L53davM3FIs0PcNofE97FT6irKVNuHCyylKT8vObMa5+CsxI/2kq
         UrxBAAXlqMuvKS+aT2RWUeV4QUKF2xBa5PnHD+5W6sXuwSwsJrsiPbsoOFWxWY8ASkRM
         dwcAx8UdC2yhtDNR4kcuaV+KM38KYkctEKNbguU/MsoTq2yw4JoyAHudE2dOr3MNR+Qx
         vrt0IelW68/PstPJTgA71U9aHNHflPqnCcFuKI1L6KcORgPrdpIWzlX59xm7tMKmk7sZ
         g53LZ/hx+lwEsv/56anpo57vi+7QAe/BjGSMEbKDgiRP0Q25aGVk7GuWkgG131b1eagd
         a3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864067; x=1768468867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUASEvoKgRbhk1dUkVLvuBQGOMUb3++LPBZvsx88wnc=;
        b=OfXITFcWksJw0MWxdZSce8RHW9zJ0wF36eff8qT28eQf+S8TSlrPqQ5V/hq/ZzsX8a
         0kBEuwvikZEPwKBYdgY4i0vK0GIazS67yMXPleAvwDfjZpXGDr/aOTTYHx1RXW3mRxf8
         doFKLR3n0hrpvTR/Gom4f2oxCYrg5FEJtWDEcGU255M+uvAOVwACIJKbMppOyYL+wNlF
         3bXxTEdzaYGNs8JYPjDJ7vYhTepJNxCalxUfDFFHW421V/xIEVENOyyivFZ3Fhdc1hKk
         1Vqn5ZUBaznmT0cakNxOmeeiv2WRUEJ+M3tiAY2723k3Vg5FzKI+fuNtfZku9ehaznDi
         EAPw==
X-Forwarded-Encrypted: i=1; AJvYcCUKKCb+kdjsV3KkVYhySF6s3tvu8gsQPnY5klI5UYOEg5ONPc288IpLCQGH8Lh2ktWqETGpE+V9tR3+rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZ7QiHkdMwbyYvZOjKbt6Oy/irWOdK6BVOk4JgJmFK7+/6BzB
	Lcxs32GRd6wirlqhuYv6yvCyQQfeCAd2KC2m6kRhYYvbHubNzDiHhds28A5x6skf6dki9h9dF6l
	EKH3A7pzqZpzcW6fyl4Xwl+CSYwAOMr3hb91/hKcYbpykPrAN1hRlj2F4zy6FvGjKfA==
X-Gm-Gg: AY/fxX7/nYjr2Cyjg8dUjYZ0L3w149KDDi+CgkCccgpFQd7cC8wuPsGYx5bcdECTcnf
	Mq7KZinnKSDdsopTVj1Cp7OCyg3LGNSSDsilk5WiX93Z5LbIa8Nqy/K5Td0ozWHVU7kso0HCxPb
	CxKc1mZWn0sMsEmGfGQcHq2PkLawHQ4bUTUvS+dr4Ra57DTGZrmQeE7mVlgc/eHoM42pA67xhg7
	CHkS0zyc6uF14iPdXttgDYyuXDY8s3ncaLAb1IdZpA16zvOYNI74VlNoqk0Fk3iEMVO+064AIPv
	3M22y6aHxpqQw2HrMOiwB4zvLGlzPuuCQWdm63HmzkolbsJ/g/B9kd+h2SfpDWnaaHP9YrtvNoR
	vHKgD9d0fAadMknEJ7GvAGedm+EliaUwvPNTWINZAKlhjy/nZU/cPHc1PJmcjujTbShc=
X-Received: by 2002:a05:620a:4892:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-8c38943b7femr567259585a.8.1767864067004;
        Thu, 08 Jan 2026 01:21:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSH8xh0nRYmxacJIRP7jsT1v/IUGFzqMnGgVqOwnhbwUDo4bcraE4vEjb3nwQSNnL88CCsDA==
X-Received: by 2002:a05:620a:4892:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-8c38943b7femr567256285a.8.1767864066468;
        Thu, 08 Jan 2026 01:21:06 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5118d3sm763110966b.47.2026.01.08.01.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:21:05 -0800 (PST)
Message-ID: <ce7c86c0-6feb-48b1-9fd8-7ce3bb825428@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 10:21:02 +0100
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
 <45a2b510-c825-4191-975a-1389f4f18903@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <45a2b510-c825-4191-975a-1389f4f18903@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d+j4CBjE c=1 sm=1 tr=0 ts=695f7703 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=tn3pFvwZU5TYnyux6WMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 7Fu6hJ633FMnWTc4Y4TB8gxhSjXCmqCO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MiBTYWx0ZWRfX8lupYdwWvTNn
 gSojjZswIu+DlJeAWk7XKJ9gd683LaE/mnX4hzjc5TQYU/z1tjk6288xWK/yFdILEt9rhJpE9tR
 V9gri/GZ/gTmYAr5Cuti2eB0OCJB09zHdC2YJqlPKMGmIZpXrYVaO5YwmI5OWVQPhYZrXjv4zzN
 /yTOUMMa1sjdH5A7v7O6YGjWIjJ5MiqIgP/gxGv6h0wRzRD2cL23DF5xBDdJuv88FS6tBpaKNAh
 z47oVHzJU+QZQkfYaney7rjfw/OexAednXAXC4+USmlUsFuTYZI2DyPtWsKWvWmdf2rCNEAwpOV
 SmrpHKdQdhxLOjKlC1qgtj+zk8mdF6YqFiP1ucYQugEiYxkFb4CK7EFcfOixwQX4FwgNXjySfVZ
 b8tyCsU7MpvjTS6UmPWXvQYcrYywMsZ9IRTL7g74iplQi5MusygwFMtDZXXmQQZlfZtDerw4hdf
 S3E8cHfqNe8lfSPbVuA==
X-Proofpoint-GUID: 7Fu6hJ633FMnWTc4Y4TB8gxhSjXCmqCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080062

On 1/8/26 9:54 AM, Konrad Dybcio wrote:
> On 1/8/26 4:43 AM, Barnabás Czémán wrote:
>> Document ovp values supported by wled found in PMI8994.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> I reviewed a version of this that said PMI8950, which is very much
> not the same..
> 
> Let me try and get some more docs to confirm or deny what you're
> saying..

PMI8994 indeed uses the same values as PMI8950, so let's keep my
review tag (but please be more careful about that when making
major changes between revisions in the future)

Konrad
