Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA23D566D
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392068; cv=none; b=ep3/6DCsfLYScXisDkJSYuF+ht46GTIKZWwVcKgGAtKGubTOq3A6//BUZ7H5+5aleFVebyJUVY94ZUHF/gmO/jaXKkMzCy9dvMkiWBgGVOwOhb6AyQ7q5/c7PmM1ncycEQq0pryfood+sayFxw0lkHhwpDmXWtOLrOdGIs25KSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392068; c=relaxed/simple;
	bh=X1MDExZhVzmc/fbyowMR2JAYw5sbyqlJibBNUw3YlMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MorNu4IU4rmKYNP/Vd9WMOFssVnKfCyi9IskN8N+/oPuNhhqNOG5suGcuiaKiKFJJmiVMsPI4h6roOVt0UuC8igD41eWPJMF0XEtrFzlmXrdlXIB9LiCQOj0PH2y8ZFfkT1DTD4bByop5Xx/tN3YQivf266hVZf7+TVqU55J40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QNvp4vA/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N+RC0zeE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNvp4vA/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+RC0zeE"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0Qvt674431
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 13:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e2jE0G2s1QXqJo24O7Ni8kLViBPEblU5gPqHIox+cik=; b=QNvp4vA/hw71+fNq
	opu1Q6PkFnO/todSJ1WPvuJeYJsk+8gh6dCGViY9KnAf0Hl+D5SuRT1rxGb842E9
	IAZxPc2RpGBNSYbxH/1dfh+4n9OJlvtplukY3LBgOKvs+w6+Gbb3eDIfQdWpyzbB
	bjE9DfCxjJDOlEJ+ZsZgQgDpFrzmS7d0b4RrSl1Qwhq3/0gvm7IB1IiDGfZFVKf0
	aC+D9LED1dUdnVkrs/Mereszf1dfn2IRN1EAVOvQeelFu7tSxOrsx0jeVBBRL0JZ
	CmFqPW/wUGDZS8kg4ikF65kLGm4DrSpQcKXnn8l25UnvLu2WZW5phC9w2Nw6kRWA
	S7KfSA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpecs8uvy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 13:21:05 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7c0d2b0aaso1349138e0c.1
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789392065; x=1789996865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2jE0G2s1QXqJo24O7Ni8kLViBPEblU5gPqHIox+cik=;
        b=N+RC0zeECaFh84nt7IfWhF7J/9BPiYV1VBaSSZXpSE+ZxTWkRRZif21mO7ebCcFk2Z
         z0qQXnRGPLt7X6ZLZfbibMWva0SGV9At3cDXzkYfwiGl85FrFBEvMRR64qpxUXyAzctj
         Ndq6dSSGrIBCnYmLLhpGTMhNfSU7dTMzPT2RGb5Enos0wc4X6CDkYvduPCZbmpBwHorR
         4aAq014sC3Ny4Qks0SIC7XEEz2IQ591CioR4tLiPGjF80F91fv0RIMdpgoMxVCOSTkg4
         NMVXYqRfC5W2dr08DkXFicIDUFF1bIJgvGlLvDFTHQ4UN6xyI4voPO+IeykAIuiyXVnz
         WB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392065; x=1789996865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e2jE0G2s1QXqJo24O7Ni8kLViBPEblU5gPqHIox+cik=;
        b=UNmGCajz5ha69X8240zf2r7lj1T3Q9VMEwM7ykLY4qAl7oBrMJjQqjid0GfKBSEWva
         GoyuLaEOEUIfwXgNsyx7j/4eeJKx+FbNjWcPEIZjXogx/UrsUu8DCc5Js4a4UpG0o2lB
         vl6UFHId2kyEaQVJiuxOOjOhHH6JD12VLpwHqqXXFChRdJ8nkbZWUtxIHDftAqfsvq7Q
         ftZm9E+df+h0o7NtqF/LeXUIECkWcysXd9zeNnBVJ3mhJxXFbE0HS3mo8JRorBJsdMWa
         I+soVIbiaYAeM8CpCflRQiBCSLV/5HRGJEZS9DpRih1zYoOfvogKQgYxTgx3lkph0kjj
         i9cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFRGEAVSHTlr7NrywCQRUu8UiFDTWTfDIWe24NO5hkL3yHNEjBZ19DeeZJO13a0SSUc38co1oLUyhMDQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kUu9vstyyKP4AiV+6vUd9Z15NgeNpGl7OM1qdo7EU+YqmuntNT
	t1c5EPO0UogXgZUFSIlidafbRJBPhv4DSmesBXUKGnDw5bJTelH8ZEH0o6RW+0DtTmqEMFjN6dM
	FWwRnxFXK2j3q96xaKmT83M2eJKuFeQ1jUPG1ihZAQnjHkRkjUn95bxb20WtP6qA0vQ==
X-Gm-Gg: AYBFou2CJ/+3OwL/3caaARVMu22IIXW+p7WuFsZlD34B1d+srU6aONGnvG42bsQYXIU
	sijBc5+2VzD/KRptBJFCcSudSTynDmj0KamwRYJ9moBPf2QqwPcsSKACUW1ZkaGbN08uGb/sZJY
	bffT7KJghMtHTuxcWxEPiE7/Z2yXjADVnvbe3KSSRIIl2VyxM0lgsooFqC3YIWh0e/jrPmVBh4Y
	Zvg/dVbPwIUb8/wqeYMJfmTB3EGCv3Ea5DPFzhnX7d0egCyNLKHNOkOOgut9C+j8BX8TWu9cAvf
	GkyjzsSdanOZ2JiWSSShPDFQvki0g3D1IvWBnp5ko7sULxy3ZchC0DQLNuHi0A/RpCT/iqno472
	kB81PkIWZAvP4Livsyc1tcV4S/9xkPmzq59LDXVt9ULBpn+i/PjqC2HSt6uLs0YCJZ5H6zY8kI9
	lo1cBEZatfC0KF
X-Received: by 2002:a05:6122:20a3:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c981b4a171mr1773077e0c.3.1789392064545;
        Mon, 14 Sep 2026 06:21:04 -0700 (PDT)
X-Received: by 2002:a05:6122:20a3:b0:5bc:42be:f758 with SMTP id 71dfb90a1353d-5c981b4a171mr1773000e0c.3.1789392064094;
        Mon, 14 Sep 2026 06:21:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0470d6dsm2485419e87.56.2026.09.14.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:21:02 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:21:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: kavakliyigitcan@gmail.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 07/10] drm/msm/dpu: describe SM6125
 programmable-fetch delayed-start quirk
Message-ID: <6zvweenpt7x7qnyrxptzz4h3cyl7azqbekyluekhpcrb5gk6ge@pfdkjp44fhbv>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-7-0e68e63a18d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-ginkgo-submission-final-v1-7-0e68e63a18d4@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5MSBTYWx0ZWRfX8Fo894tMriM3
 enKrde/fKkWqUVLfPNGiKIrKJ6bzMou8eP6CYIImmr5dtgJWtrouTcuoxL6EI2AxozZ4ExUJC/M
 6pAGR7ZDlx6xdHN8S6siE8b81S6WulM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5MSBTYWx0ZWRfXwHEwqfq3yayp
 dWo9fqsuQnsrHUIVTUQKd3qKKk1ZP4rtbEne+jfM+e7eDtFjJQhT2vCmjacVyv1U24TDs6Mlmgp
 jo1zUnope9Bsj14w7PIx+Zilx967I5rABUsx8NQL2pX9m8NUi4Gnlhpc+qtOU7zM2ns1NbCSqN5
 hrerwExCwrNpeLXLcZxZkdSG7gPm/gUBYeGv3ApBoc/GlG5j/gBSj8pWwHjvYfmU1VxfkbzVt2+
 W8k79bB62NSlfNnW62VyqXE+H7ON2gBA1TTmTrr6Vyp4FsSRXzJwdKC3s/VeHjVqnMs37iefU5c
 Ynj4h0laMeuSVC7L3v2dMrQ3goOR3vYJoU+8B0ea22ttMoeAGiF18ffLWL3TYFeBqlKABeLBJEO
 AqPpNomg2eoUGf7hT3c99Ukke/9cSnupPFdBEiW8/8WI2ttBLtc49ooikTx4wJTb/KDKT5IlGNr
 +MJ/Aud0VARVIcvTcYA==
X-Proofpoint-GUID: GgD5STTIsxwUzyr2RTAWmIR9saapF4l5
X-Authority-Analysis: v=2.4 cv=b/cncdGx c=1 sm=1 tr=0 ts=6aa7f4c1 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=T_hHn50QQsNSpKpO-EoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: GgD5STTIsxwUzyr2RTAWmIR9saapF4l5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140191

On Fri, Sep 11, 2026 at 11:51:04AM +0300, YİĞİTCAN KAVAKLI via B4 Relay wrote:
> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> On Qualcomm SM6125 (Snapdragon 665 / Trinket DPU 5.4.0), calculating the
> programmable prefetch start counter strictly as:
> 
>     (vert_total - vfp_fetch_lines) * horiz_total + 1
> 
> causes the fetch trigger to evaluate on the active-video to vertical
> front porch line boundary. In hardware, this triggers an internal line
> buffer FIFO conflict within the INTF timing generator, resulting in
> immediate DSI FIFO overflow and timeout errors (status=5) and complete
> loss of pixel output.
> 
> Qualcomm downstream display drivers mitigate this erratum via
> delay_prg_fetch_start = true, delaying the fetch start by one scanline
> (+ horiz_total) into vertical front porch line 1.
> 
> Introduce 'has_prg_fetch_delay' in struct dpu_caps, enable it for SM6125
> in its catalog entry, and throttle fetch start in programmable_fetch_config()
> when the capability is set.

'has_foo' usually means that there is an optional feature. In your case
it's more like 'needs_foo'.

> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h |  1 +

Fixes: 9b6f4fedaac2 ("drm/msm/dpu: Add SM6125 support")


>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 11 +++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h         |  2 ++
>  3 files changed, 14 insertions(+)
> 
> +		/*
> +		 * SM6125 (DPU 5.4 / Trinket) quirk matching downstream

Drop the codename, please.

> +		 * delay_prg_fetch_start = true. Throttle fetch start
> +		 * to the second line after active video (VFP line 1).
> +		 */
> +		if (catalog && catalog->caps && catalog->caps->has_prg_fetch_delay)
> +			vfp_fetch_start_vsync_counter += horiz_total;
> +
>  		f.enable = 1;
>  		f.fetch_start = vfp_fetch_start_vsync_counter;
>  	}
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index f45faf87333e89bbd463504ae3219609ef6209bd..db3cbf9fa04a13baf3ac40390757ed24120ccccd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -273,6 +273,7 @@ struct dpu_rotation_cfg {
>   * @has_dim_layer      dim layer feature status
>   * @has_idle_pc        indicate if idle power collapse feature is supported
>   * @has_3d_merge       indicate if 3D merge is supported
> + * @has_prg_fetch_delay indicate if programmable fetch start requires a 1-line delay
>   * @max_linewidth      max linewidth for sspp
>   * @pixel_ram_size     size of latency hiding and de-tiling buffer in bytes
>   * @max_hdeci_exp      max horizontal decimation supported (max is 2^value)
> @@ -285,6 +286,7 @@ struct dpu_caps {
>  	bool has_dim_layer;
>  	bool has_idle_pc;
>  	bool has_3d_merge;
> +	bool has_prg_fetch_delay;
>  	/* SSPP limits */
>  	u32 max_linewidth;
>  	u32 pixel_ram_size;
> 
> -- 
> 2.47.3
> 
> 

-- 
With best wishes
Dmitry
