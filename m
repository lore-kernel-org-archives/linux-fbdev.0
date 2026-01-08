Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61E318BB7
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862554; cv=none; b=SWxzDL3aqH/8IVKRmYzAJFknYd76aH12GyH8t/EJ71/Z27B5Xhy0ocBP9UbbISR+Uo6Pm9lp2/GKlqiiYaZY+8uuDU1gVWHvTs5DMR9pcPc9219MAAuUQJzQP9Kkb2JYI4zeLyRFd/FdI6h1v8LQmRaz2LCEQc1VKlc6UYNsIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862554; c=relaxed/simple;
	bh=vihXKZgC0RF0ZvWdSb9dihAYRm5zi3vzFR6ngUhuC5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPjGtZ3fXvEJuarlRD/EdKzAphU4OLgWqv38ZBB1WZlGbEzUahM4FU9XuI3Mcx6Pz3z1oXPyz9vEFAI3cLgeGE5+YPJpQqe/JJcljhVgAeQqQEDxX6OrpgGQvxdGsbSe6toYEsJl1ikUFtvIXoidaGgkvgIm9Hr5lZdXD6Q0rEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J6el5agI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ke2ubWbp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6el5agI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ke2ubWbp"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6084euhC2593277
	for <linux-fbdev@vger.kernel.org>; Thu, 8 Jan 2026 08:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F+LUBAWmsVKlASWBuram6zTfQJk0Q97+yOU2s3t9Be4=; b=J6el5agIdb0Tv0H6
	AweZ0W4e0nDdcw6KClr0kxkxvvWoaHjpy6kcoeFZjAHksZ9JORlHI33VBmUyiXNZ
	acCvd8okWKfonyTboawiXCvDBQ3lCF2mozB9amhs1tXGSSj0mL40Y9bQ/h7QpYHL
	G5rPr4mqfumhYo/0MT5F5bk0F0fCImunLaedL4Ee8PjE9acJ7ECMNmCuOZ6D5KLO
	OL0R5DffkJuXu4g34WsFaS54u5+QfEp3D06xvlf9ivL6kg6L2ciT8yXNQmvk/BJm
	NzDNTqR7Vkscyqu/t2R8AEJEWZ+XyabSlRussylCI5FbIuJJRupxtmDuUnYzEEVD
	Hmmyqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn2940xq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 08:55:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee07f794fcso8598181cf.2
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 00:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767862544; x=1768467344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+LUBAWmsVKlASWBuram6zTfQJk0Q97+yOU2s3t9Be4=;
        b=ke2ubWbp5m27bThrAYFevJyC5SdLT33EAIAMrYIm9W97HCUucpt0E8+oNxGAwF5l4i
         jXOwbfI3YCcAUCO30QPe0kYbPUMK7rL51DobbjFp/iDwO8oEHCFmZy32wd9RBCZo+v6w
         mFEhJp6t5QNaEU8vnen9K4yYPVO0ew28wADf7lcTXyc4dslrtK5O22S6mahxBCK6V6Ny
         uLz/F3gzcn1AYL3TXsx87dJfqNtpwOlJ6g4cCDVZXEOYgneGFTluMgDFkWLnhMObV7u5
         IrXjmeUWIWyS2Xt+6DBKKNeF41C2fIENjwuc5LDVQeRkmMoT7Wzv5a3vMTkyYtLR0nrw
         UEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862544; x=1768467344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+LUBAWmsVKlASWBuram6zTfQJk0Q97+yOU2s3t9Be4=;
        b=tSl4NYHhWuSPMOzfrLypWIs78mD1dpcT1uzdCpyoPbVNKZR4N+SQXdTfs+opj1Pkp8
         Ii5TyMbmARZzMwAWR3CbKo+RZgoNpDUZyPdUTXS4u1EzhgV8jyqezPLKyWVhZwf+YhlT
         6nc1Z94+mOvGTqo7Vx9Iz3WJN7TAFyZ47ceD+GWjdWNKLpfTWSxzUTGVVmsvp4os5g2y
         wx1jmoEjyH5Sc4wtfhOXg8QF5GBRJk7UAx9Nq1KyNh2coso3qD3nskemweu4ma/qjm6x
         fIolBMrzompK/xbSEAgvQNvE8QMq9/g75ZkTTrSQXxixMHJ2z656R/SxP4j2dk5YXckJ
         h2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgBFVTbpr5K45ctY5k95gaEi6rtqC2eq30sMKcbzG0hci7ot+zKW3AWRoZ7C+YDYxxLePs1OFQEDwq7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFlHW4z9gKDvBA3/vEiKm+j6tHY/dALJ1mUnH4L/6La+8uq5A
	VZDcCBnqfwgLm0R7QDOyQTgAaJLbP9lJh8M8fyy2DxX51HsaHlfT69h9z+L+CQqjFH3/HkpfjxZ
	bbqjE8QM8cG7LRwJA+DoGa6MhJWlAkWG4GDl1TER/sSk2lMjW+D8h6joviF7B2/tdvQ==
X-Gm-Gg: AY/fxX74CPB3rZXAyuIpsP3NS5IcTrIG0idbwAc74KVzB3utZwZh+uqn2d+nHTsHEmi
	flp4y7J/yVFXn8HrJdByHrbUh5SxCP0EiyADgdl17YPDo6ngRo83aZdEBDzHChmn7RNCU6TMBou
	9Vlg3pgOG/cd+dsCaya/lY/QNtJaYMJjT8wY924aPjgbVphzJAj53gz2e1P8FnecmxXtojiFxJt
	ARdMxX/ymUCVW7SoKbTci44eu7cA8N6ay0iBdDRUDHKB0vMdY2SsOEH6Ab8xkbj7R66Eb3wFLxJ
	v0yhldhpNT0A2XOwLMjICn0IhVJOg+Dehjb/AmLSVff+pp3+1NrM7wkfJ8ayeH7A9IEIV1sq6SL
	/Xw8sEPpX3bUgVIzWmH5BWYNvfR3j7X/WSDkCMcQadWPFq7O0wimOwtMfjKM4o2b0Xr0=
X-Received: by 2002:a05:622a:2cb:b0:4f1:b580:fba8 with SMTP id d75a77b69052e-4ffb48d3b42mr58398561cf.3.1767862543697;
        Thu, 08 Jan 2026 00:55:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9Lv86d+HKglAfIaITF0v/1w20K9Yw1Cy6aKrCbkHCUfrjyUTzhk3wIiJr3LYFJQaOUvw//A==
X-Received: by 2002:a05:622a:2cb:b0:4f1:b580:fba8 with SMTP id d75a77b69052e-4ffb48d3b42mr58398381cf.3.1767862543327;
        Thu, 08 Jan 2026 00:55:43 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm780584966b.0.2026.01.08.00.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:55:42 -0800 (PST)
Message-ID: <736c8986-7adf-446e-9720-c4a71272825b@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:55:40 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260108-pmi8950-wled-v2-2-8687f23147d7@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xUcTDiBYkl_zdEnOLSZYw9DNZdSwd9oO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1OSBTYWx0ZWRfXxNwgtD5n/x/g
 EUulBOa3V3ZtZljUG79+0bm0tKjQKZab6af0H5/t6Vkrjtp3h8jL3MTl62ui8Ut9Fb6ULyc2uuh
 GlCZsL20HUjRHGjqD5Ck3MteRGSDNuLApxLrj7JlgEfE8GizNLwKPqP+Zobmvi3uDZJ30jqtqnR
 ETgwQbFfuLvYJvOFkbb4dw8JIF536uHcSYXNgau9PAEwYN87oY/+VrFz8UKapkiVVF8wuGw2JKn
 m1S05Q1Q6ItcIdgqItwBsoafIjrwV9IVzUrfeFowkc1CiIBiKN2948KLy161UQuXFso84RasOZY
 ifuZUmZnaL7AVk+oXEk4QJxl4eQtGVsaW6iPRonwx0nGbbOLrI7a0XW+NczGpvTAfwO3JkK3jTo
 MuB9IpxZQpy4PJq16avOPJeWZ4B1OxNb6rttseIaIQkdXF7YU1xsphYFzz1tL0GLzh6rdsAwH2f
 kkisuT4Z2RvpjO7y5GQ==
X-Authority-Analysis: v=2.4 cv=P7k3RyAu c=1 sm=1 tr=0 ts=695f7110 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OuZLqq7tAAAA:8
 a=GYwjzM_fwieWSpg0kukA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: xUcTDiBYkl_zdEnOLSZYw9DNZdSwd9oO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080059

On 1/8/26 4:43 AM, Barnabás Czémán wrote:
> WLED4 found in PMI8994 supports different ovp values.
> 
> Fixes: 6fc632d3e3e0 ("video: backlight: qcom-wled: Add PMI8994 compatible")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Likewise, I reviewed a version that said PMI8950 instead.

Konrad
