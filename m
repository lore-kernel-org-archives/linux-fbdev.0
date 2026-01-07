Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB239328B61
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794892; cv=none; b=HW+yqOqDfOY/6LZQw9OVDqftcAebFXzfzlw2UKkuLOIsa/c8lkUhC96RdsYd3UdktEUz0N597SLZwLcGvzoC74vODBhwzc3G4Nnjxs4hSBTxZTsn1kCWlp45DNUPYx5aA8e/KX5WqDOh5BNHKfcr35E3fuHZeuEZZKLPoAZR59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794892; c=relaxed/simple;
	bh=mCbn5kuKUVOa7StqdNfdgtoPVjIvEhpYuWWE9PJhHbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9UFELoDFwig+gy6GZsaIFx/+p5zsqABVZBno/IhIio6TYFo/iWK6uleUkhSOHY6G2jnVQgc4nWucMYa0vSFt6Y1NLeg4RXxx18Pl4lCZnnG6N+w7FuYCI0e+Fga0ocmHRSk2Om/qxxgx8LnFQKnt1zmb+TEITyLu+xfbYdd8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UBmKmXa8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NkOEhDSK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UBmKmXa8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NkOEhDSK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6078dplI2577888
	for <linux-fbdev@vger.kernel.org>; Wed, 7 Jan 2026 14:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mCbn5kuKUVOa7StqdNfdgtoPVjIvEhpYuWWE9PJhHbI=; b=UBmKmXa8lJdanWPk
	9kQMooo71A92HE7SGebPQ9STM8M+9pq6NRg8hbacBluETQb8u+OeIvIxmi5QV1Jr
	PPJdfU+cqC24l9Ui5QXrV8HaJWZmBMNoge3SDtRbrJNE4HUPdYuKhXIEComH/kSZ
	ZnhYEQ7tTCAp6G+VtP/I5N7zVGPQ9+bew655fML/x62frlELdJzEj/T7Y7Pr8W4j
	+6BtDdiCIzQzxFA77rKgy/Wm1hyR48d4HPmcPVkRzJGwjpMmxbFcMLvd8YLzLmPQ
	3nm0I42bAyVexV9CKB79GExN/2KYdHL/O9gl4baTg83yDBqG04DgH+YNuoCP39+I
	A+qYtw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhm658y3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 14:08:08 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6446e2a7008so440071d50.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 06:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767794888; x=1768399688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCbn5kuKUVOa7StqdNfdgtoPVjIvEhpYuWWE9PJhHbI=;
        b=NkOEhDSKta21OHf6Ejf5UQXtSiR7lSkd0De4rUEE2GSlULWXNqaZNenOVoJFbAqh7+
         YXXaTli55uq7Raysvais9CwIhv45iBdV1Vv970fqxvzRfIkO3y4PGC5Q5ijNnQs6cSoX
         BNm5W6y7CZBSZiRxDPENQMQWYhIl2C1Z1SdxgCto4roePMkRuQXLS9iMlpk1qGkA2aK2
         jmmizSKLkDUCN7ETd1l/9GxX5NRfSzwxlEYMAZSF7KUoppXG2E3cU2JT6AGQ7qSHEc0x
         JOoELehuUkm5JJq/O7uygGMcO25SHnXJGUjmllyMiFvzC2jSVNou37lN8mQL9Msq7Or7
         eRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794888; x=1768399688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCbn5kuKUVOa7StqdNfdgtoPVjIvEhpYuWWE9PJhHbI=;
        b=VqBnydy1RwULMQl9azOBmELEvosKRboGS0mZovk9ueblZXROGqEXprT0XMnxqtXNyE
         DOTlYOb1Gyl0nuIv46cNJEwwCUVUFBIYIrfK0z8awry4KNG5prfdkeSuiPKF5jSnOpqQ
         1xzwNDfppVi/s7FRdX7vdXlOXIyicQH47igdNVCQEAOUPqtPrFccg55alSWExZrzCjFv
         3EYdVKXfKZ4QUIUhlVcZXWJ3gHbsQDBg4qJ6mi3R19ZT9pIjzW+3NXQlO+kRzpPNAypT
         ZQpvg8x5kkjeOdv8JRIUZzdXXtG1MB4EjgzoE1hEk3rWja+vCbZ4zMQ4rTZ4r2S0Va0o
         dA+g==
X-Forwarded-Encrypted: i=1; AJvYcCXkddJ7hksYes9yPH1FdC78X2J+cGbgkCGhie/vTGbFp9htuQINEj1BFo+vn62a5IhlKcOJJURHEWzZcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiroocYLxKde7Gf9bZQ5K/bzs4ihmt3ggNHfqPP/fzwQpe3ykC
	U4Y0OpHYHUG6zBtAmUabR3i8tPPm3QIv5Kj31FlAVzMaLPFs2vR5v/c3Pdz+66Fgsq11ckqDzq2
	LBYezD2GnLoLBYjmovRwqh0Gp2lvFnk62OOxFHPBG1L+fms+mXwucinwgZCfs/o8z8g==
X-Gm-Gg: AY/fxX7ySNwt1Z+4Q+eNyJ1nUQZeuQJXRLqEm2zYeZY/qL45dRMMrpLIVhFExIoRIEW
	WzKb0umIbVJQgJhD/Nudzn4lyuxXQkLc+Q/wSjhXuuZIa2dJbmVzx+bKHHMtJQA3qTFK0NyHV3i
	Gs6+MejV8rLXKNavgl0OybQAOSOzfYorekqlOohz1r0MZ29/OPeYOobm21+UzRulDojOOEGjPJK
	V+ayu6hI1+TBruonv3AMLDnNEAjhKmRJIGATpiT9E1aYfMcdxIxT0u4YoQG+3yj1D6/iubXhUQ2
	tfi5Pl6tR1+98mJrr+FdRRvXvHLCAAhj106YifOy/OaqhPWajhaCZFtTsf1QohmiCQoOS2h/dnZ
	+hj24zk7T83Ry19d9CBeW9pBu4xsDyUHWdgaLFDlMR+UQEgENS4a6AFKgKk4b/tfUPKM=
X-Received: by 2002:a05:690c:9:b0:78c:2c4d:3df9 with SMTP id 00721157ae682-790b54b5af8mr27270537b3.0.1767794888339;
        Wed, 07 Jan 2026 06:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyUpA3k3b3g5qtKWK7Tl1X2D7wG2aBAVLD35CZGCs0GMhgDfMQ+H933I+o6Rq2dV0QTyPUnQ==
X-Received: by 2002:a05:690c:9:b0:78c:2c4d:3df9 with SMTP id 00721157ae682-790b54b5af8mr27270177b3.0.1767794887752;
        Wed, 07 Jan 2026 06:08:07 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56962esm529552466b.66.2026.01.07.06.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:08:07 -0800 (PST)
Message-ID: <09a4642a-3552-44e7-97bd-b26e6937ad8b@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 15:08:04 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: msm8953-xiaomi-vince: correct wled
 ovp value
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
 <20260107-pmi8950-wled-v1-3-5e52f5caa39c@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260107-pmi8950-wled-v1-3-5e52f5caa39c@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpL3+FF9 c=1 sm=1 tr=0 ts=695e68c8 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cwWn7d2NfpHSwl1uxIYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-ORIG-GUID: oKfu4gIyiX_A3ApHA0iy0Q5jJCoT_rJJ
X-Proofpoint-GUID: oKfu4gIyiX_A3ApHA0iy0Q5jJCoT_rJJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwOSBTYWx0ZWRfX1HOGV/aH8PUK
 BLauO2a7I+zG2yd5m0B6+F3yoMnp3DGPjr5GHVXvpH/0v73smE8w9un6pm3OUgw19IJcI2DcreX
 TH8Jx0sjlVWDZ9wFD1/NbZavLXi2DLvxaSWXFRlCZ3ooG0xTpr8ewT25ZwuhxN42suukzTfq42a
 8z6WAJ8HBiZy7k96POjm7tzptr38ard5/3EEq/vB4JvZyxiDaEJTnrwnirUAQ8R/sl0bv2IqPhf
 UHZE/SSosk3pMzLTfzYDCMDD9KlmSfXQ4XY6Vg7ZR115mKn8RX5doNSeLVSXLOXKCv8zwOALgmH
 I6B+K9drXOxpYgH5hMxAuXjsKwo19VYFMvEIHwqT/M942BQBMVCXPXj7kTQ4pQm7jLLZjkc4oO3
 NOTN9CVUXzHewnvBO5N/c5ZkmbB4R3feZlN80yR0lN9tIHLlx1lf5eaULhkWCkTKFQZwVg1wk3b
 tWMA7w1Q1k0tIm2drfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070109

On 1/7/26 2:31 PM, Barnabás Czémán wrote:
> Correct wled ovp value from 29600 to 29500.

This tells us what the fix is, but not why the fix needs to be made.
We can infer the former from the patch contents, but it's really
important that the next reader, perhaps in 5 years, can find out the
reason it was made.

How about:

"""
PMI8950 doesn't actually support setting an OVP threshold value of
29.6 V. The closest allowed value is 29.5 V. Set that instead.
"""

With this or similar commit message:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

