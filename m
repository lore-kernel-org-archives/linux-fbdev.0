Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BA49E144
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982950; cv=none; b=aqIWbreNdcOcm+3NjdRd6jeLhqlgnPpX/qRhCgEqpR2cf/8moDn1r4NCwDrhKFX4IMHWPYOGkAffDEOohwg3FHG68VHYCmQHjvxZ6T1cb/9hX6h6vWh+ifq6m1D/g/kb8Rp7+5g7Yw+wsA0Y3SrdXgZejMWKpELOLmMMJGb9WrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982950; c=relaxed/simple;
	bh=GZh7TLiWSHoFylXh/htKohdUX6adPDJdp5jc7Atnung=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk9L0RrdzSA53u7OpEoCaSVJsqb7XIZs+hg5Vx5xK8xAc6qCIxgKO3RqMa3jMtQHME8rJ4651NxBq7nbUW4ONTjHcYOHIFMe03qQ3VcSBvrXea8wvWSt1IbRt1FhVMN6zoy5TDsgbeZmm5rWXLzNLSMteFuGrH9u+zbMLrmPsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i8XfHTSe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aC0RACHh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8XfHTSe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aC0RACHh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7A0VG607146
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 09:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=; b=i8XfHTSeay8DT1Fh
	4WrZG5wurO+Dfpp+YDGEtXm1ZVk4Yk9CN2MtkbRrnes6lByDq3qyDNiMofF9HCl3
	t9w7AM4CSKL9jPqVeeUs4T1Y/uZzcQnjrLFfqaebRaJE4dnH58uEkH0EyGMYIOfJ
	t546zULee1PNU7JJgbu/2nSUpP3boSRJFFLrn0zeL6UTgJGaFtgBY+6kPteNUAnO
	NneebAST39au2u+cJuczn6O+eSlpkw9F0Y0XvQ9/yxpcwtnbfWS7+pfdSsqn0Pt6
	moZ8sLALYa+sPX2pTJ8ero98BS48PzNqOYVBSfEmUXoRnTHc51MK1VVMtOeX0tSV
	D7rBew==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1ehkgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 09:29:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930a312222dso74096985a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789982946; x=1790587746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=;
        b=aC0RACHhn343+0QNSRzzsKOrT4dHIV0JAOi1l+qzQLepQAGZbAeeXTQ87r2E4ODAfz
         LPMqyy0IKdWphbYRlE/LpTPimw8A42h7alPUCPm7fTeQJNkwiGPP96g81gEMce2ltEaZ
         WBlW9Oj/WBb8zczXwzZRATO0LwfGytoBP18xsEA6+EqMr+r3+IWZgnOujYmE0R7eCTbS
         mNMfwX0O1iDwrHyUlzGmqi7h9QSAhOXZ50/TJZLwlrHTDi7etsg2hH1AuVjU9xVk2oDA
         WlzGl+TiBfV57PJ1M+YFJ4NbVDjbwan8W0elcid2jlF7D6p/YMXo42zQBXmtKtis2nOB
         YtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789982946; x=1790587746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp8pjoffAdrQ2Yno0i8Ngqu6RPdDWIsL95RhSPJ18pQ=;
        b=MyaelSsZYX3iWBhwRfQKXLNvtIB9SSKArhhhyvdNXHUYyhOOHsTTWHs2gGQG/CNDEx
         Y/R9wiVpwdPVsIz3vzdpOp8qTTj/J8k8gPmySBKgJzJOW28ro6vOwkXI1VRImyjeoUKO
         kyU/1VRtBUItLLjr+D6tv9gYu/hTdvLjCrK20z7ikpu5lHaghcswugPIhLbT5JpG0Kcm
         eBXCgqQAoe8hw3qgazso2HibQHU1RPY7uopJEdrpriif5vzmoe8W85sE4Kj7eiSxTCbI
         mSQXF6YsSOdAtjGyZuZSKDSFOnO8cWiGAdiZbxsTzSVhjG2n2JWqrFF6gvSvkY9mi0CB
         DPKg==
X-Forwarded-Encrypted: i=1; AKwUvBxIyq26iXWAg/nuXST9wayILMruY8htOkkSnlb83GjsAQoIrzQp8Nt91oMofHE3BTUyII6X6w1Gx7DrOw==@vger.kernel.org
X-Gm-Message-State: AFuF++n73qCRJW+/6cmch78pHB9Pit+Q8cqdQer+mLzJdLnhAu4UsiFW
	IuXjza0CUEUHUCl9Ks+oU/On/MmlHOkTj4i3C9CkBFd4881+GWcqcpa82f8Coj+4NYgI5D+uyPE
	D685S1PvDffsGg4G636ccMpCYfOIIiKw3KjU2yUA5/55355MMI6THZApbdWFgpwB+Fg==
X-Gm-Gg: AYBFou0kvjGtVktqyxGxyu0UQmR8CZ1j5Shd4uWCF6aJ7l8BjI4gr5vGNgdUQp66chV
	goA/gLCl4//XZdCEL7b6TJ0PRZV54sP/TI6WtdlwdP+cK3LA+9ceSJgpmDDi4pRHvHUAT5hdjLl
	vdNmPzDrGGz09vyVhn9bkJe1KpIrV11CLN2NeeDVHkOwoaUS5NLRadokUe7auEzVvcvAZVz+Vwe
	6l6Zi1zhtOrIrd5YKK5hKEB/M7otIX8H+r+eW/N6rExVMRw0J6q7FJyAo4UzNMgkDpekCGf8AHe
	NZT7zXpgyGPLBhw8hpx6yzn2BpYt+vwHRLmct91vy0az4zrBjemajnP4wBIftw395drFEsnVH1t
	n8QItAVp1ClNXkoqCgry16g==
X-Received: by 2002:a05:6214:76d:b0:90c:e7f4:8bfe with SMTP id 6a1803df08f44-9129c780e3cmr115802026d6.2.1789982946586;
        Mon, 21 Sep 2026 02:29:06 -0700 (PDT)
X-Received: by 2002:a05:6214:76d:b0:90c:e7f4:8bfe with SMTP id 6a1803df08f44-9129c780e3cmr115801736d6.2.1789982946186;
        Mon, 21 Sep 2026 02:29:06 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e11071sm3867362a12.23.2026.09.21.02.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:29:05 -0700 (PDT)
Message-ID: <acef563c-8eb7-4c7d-8048-49e3b0545437@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:29:03 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] backlight: qcom-wled: Fix WLED3 brightness
 register stride
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Marco Mattiolo <marco.mattiolo@hotmail.it>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
        stable@vger.kernel.org
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-2-d69fe9843841@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-qcom-wled-backlight-v3-2-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfX9B5jnEMyatIN
 6kdB59vC1Ml5HyA+KQwq0yJ48wA/bKGuf7nfn61LlQ1OMqrrDjr92ofTlps4DumlpDQ0HRwjs4n
 v8S2xkJhvUYe9IfejMr89OuZyNCGB/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNiBTYWx0ZWRfXxaHJbNXScYS8
 cenfDck0t0b/9veUwsYeS3ok9fmtUGIvIiHGKf3NKdEsq8PfC5lkRqy9rtP0jKV4ienCQJoyEx3
 nDv9CJOIwLrjWdXH4a269vg0n+jJdFjKs7mjDpbueNgezP4tV5KN0qeottj1l47utD8tcx1MTYn
 INzQJaFRgt5A9pyiji/hYW7VVE81sz1kB9HzKMr+NaCrwaiqkxQegLD4To1RCQmRyc0wD03srZt
 zsjGjjV955AsublK/5CFcKuPBxZmwggbgRDdC6fLgBwPrNu/c6EA1FG+RLOJ+SOFenpmD0drfr3
 lBZp6a3qUT2olnsGdxdjffz8tczsLttUzAJH9sH63esTkSIeBPnf5m5H+v5VbCOdTImBgZc3Duu
 DYK0+X4xwncDEaLkjYDNWbjm8itRghsadupkh4BfKN8By+VSy/3/nDC52sa5NtRgYyEAd90cyo1
 k5aX417quLmn8a9jMVw==
X-Proofpoint-ORIG-GUID: 7Kvk1LmKCck9xfF51Egfzvilm1ThTS4U
X-Proofpoint-GUID: 7Kvk1LmKCck9xfF51Egfzvilm1ThTS4U
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0f8e3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=fY3HbpO4PgkFXDM8leYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210136

On 9/14/26 8:14 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> WLED3 has a 16-bit brightness register pair per string, at 0x40 + 2*n,
> which is what the pm8941-wled driver wrote to:
> 
> 	rc = regmap_bulk_write(wled->regmap,
> 			wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
> 			v, 2);
> 
> The restructuring for WLED3 turned that into WLED3_SINK_REG_BRIGHT(n),
> defined as 0x40 + n, so the two byte writes for consecutive strings
> overlap: string 1 overwrites the MSB of string 0 with its own LSB, and
> with the default three strings only string 1 ends up with the requested
> value.
> 
> Use the 2 byte stride.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/video/backlight/qcom-wled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index a76158a298335..e1962c2d90ed4 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -54,17 +54,17 @@
>  #define WLED3_SINK_REG_SYNC				0x47
>  #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>  
>  #define WLED3_SINK_REG_CURR_SINK			0x4f
>  #define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
>  #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
>  
>  /* WLED3 specific per-'string' registers below */
> -#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x10))

You said 2 in the commit message and you set it to 2 in patch 4

Konrad
