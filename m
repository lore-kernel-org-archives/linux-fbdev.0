Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5D39281D
	for <linux-fbdev@vger.kernel.org>; Wed,  9 Sep 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945505; cv=none; b=nIOlTltVBiWlLET+Jb3enDdzAbpqGl/Zay+KvJpWDpscCWilgmnq31fmQN3SK6zfNfTNf/LGyd8Ed7Ru5QyXPEQWBacIGiyc3/BB2+6LIvsfDd8S6Fd22fev9fZ5ypBlAX3m0CukANNhOEcCLzrenss0+wK3WVRy2FGGrgArva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945505; c=relaxed/simple;
	bh=SxRyqWCBHjHzWDAjeyEn+IJRbAXN37BviQxJFqbg22Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8bV0gRihddx+Y4A+aiAVu4VsIxngLoD2hier6HEuKPt7ZEMzJcLZVmWZPD9Em+O6PzU6v0fcO48mLOzhKtWiRiMylbUOwKJ3Z4zOPgY55WGq4pP2TZgOJKtmAHatbDty2Eqd/6YfqyvsZGvljR25HTGPx3Lo1MrEDroGNrmHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqg5tL40; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eWbIXbSZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqg5tL40";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eWbIXbSZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6899AJ4g3771144
	for <linux-fbdev@vger.kernel.org>; Wed, 9 Sep 2026 09:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4tTCnaPUXZPu+u+JFAUI2y1je+qTRzz+PfxElcpWic8=; b=lqg5tL40txC/Nobn
	gCWxF8hRx8Xb0YbEHSOoOMxpknm5kSJAdUL0Xy4CwRn5PXKmZpzbSwne/dYEYviV
	q40zad8lV008uaQ0Ki50CHqmMAO3q6ABB976fJ7lSwiSIX7TnBkSqyqaTC998QNR
	KVXoajZ576ZZXraSR8UL7+Q+AFaFTWfuMBO/6+DG65IMUQiiR4KFu7RnmP7fbKw0
	GjvUuQlJk4aoh0d9xXoz2+Of/yKH3OCHbiCtdOeCzTGzp51IuBATViO/FKAk0yxo
	F+ZNu3/TOsD9DVCMrN/yuVNn2PcDttfOxkjKiWdcmD1UusJE2WYrCxyy/j+v/s56
	w2oCVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjywr17kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Wed, 09 Sep 2026 09:18:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9375d92d0caso62945285a.0
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Sep 2026 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788945503; x=1789550303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tTCnaPUXZPu+u+JFAUI2y1je+qTRzz+PfxElcpWic8=;
        b=eWbIXbSZ+Zf6AcpmBogjFWV8Sout6fScrqWRKMV6LfklELIbEm9ceq1KvZU7Dz0Boi
         0EhFV9k61yitNwrZ/sfcklVTaJ40An+0QB2hSI8fXoP604pTMfYW4Al2rSlK5d8kpscN
         jsXHCBeeY9JEdjH5Cvi1WS8t8UjRPF8DIVU7lLqYzou9Yww4zlnv9/IKYijbsLoPCjM8
         /gE9WxNGgZztieGeR40cs2vvdYyYaokVO2vQttaJfsV89+rQL1myYXgQ3l2QdQydKfNX
         r8Kk8oZDgNJ7JPKrNQEhzf/dG+7EZFoIORGDkH0DrIuTcU2AbXyzXcG4LcbneQSXjkot
         2Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788945503; x=1789550303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4tTCnaPUXZPu+u+JFAUI2y1je+qTRzz+PfxElcpWic8=;
        b=MfMJLp6hFZm3zpMQMw1ZbeSWIrWMv/ntuae9u0WljEsLvEQBeUPIPHhTPv53RD0l9u
         LX7lugNsKN6JR8u2SZfpIvTtKYA0Sy+JDZ/hW8smjnpSL3eF5nZPZrECFkmsuLSGPurT
         Q9qNreM0868YK9SG0ZE7FwaXIRinElVHSrG0hYHLgSKK1sxSEzls5CtLq4oXksOlyXqr
         ymmDxBodXXMb8CeBYtEtuJisZUrWBbgtTFMLdBGk7/najH1FZc8wCOKHezeNKiVoIdjD
         2SZ8DrJfdes2+YWlIhqtFiJ3RsxGGC2JoP2HYgO8LUCiHEGhPY7t/sstwRYrkq8e/m9H
         PHCw==
X-Forwarded-Encrypted: i=1; AKwUvBx11fqh4qcl55Z7fHeB3hjGS/PvN9zft9lxTNC7JSufYFiATPk69n1x5hj+gNYW+bCNWTFKx4d10wR6Tw==@vger.kernel.org
X-Gm-Message-State: AFuF++kzIEhz+rocg3k6aY7f+4K18G2GeW5h8hfreY5B8SHk+liqBguA
	gj3I6ghtOEs0HBJO7+yb/F5CAjGGpRk1WrbhFA0CNyD+O8bNK/UJ6Q97NMP96Bl4XeOebCNdAkO
	A70zLJqkg4xn0UrIlAfuvRKAylAyJ1l84pcw4moOXEOC6L5D7JPmdfDewNdXxHem1Ng==
X-Gm-Gg: AYBFou0hZMkLAJY7Q2t6ojypn9h2oZuDeflOQJsot+YP3j9Fmqhu09LnLngLJrLbhDl
	FwJyX0SLlVR5Lc1a+0v5eVTaA7Ejkk1o3S6svRhNKv9xoEPtwZbuzLZWFvPGW6hnDXR/ryT49cf
	j3EgJouvwlhsG/cIZj7i21upQUo6WrPI5gN4Rx4N7g/f32uLlTuOX7C0J84VgUmtAqUS4jJAchF
	6iCPb98etZAebQHJ0ZKJ549QL4u0gIxCYGS2+2rm5fTOVP6NKRyTX/yGFJGWTqBUZXTuoinoQ2m
	JrGojmsbwyzuMO4uDgX64EjZxNTMqxs6f/GgaN/YcvIvVoHliMfMKa8Wo4xRgi8M6GzpAoKdzgy
	uvWu0KwnGlQ6q/68bfetJaw==
X-Received: by 2002:a05:620a:1a06:b0:934:95d9:85fe with SMTP id af79cd13be357-9399180ba67mr2231678785a.3.1788945502725;
        Wed, 09 Sep 2026 02:18:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1a06:b0:934:95d9:85fe with SMTP id af79cd13be357-9399180ba67mr2231675485a.3.1788945502185;
        Wed, 09 Sep 2026 02:18:22 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c261e24a9e0sm680491466b.4.2026.09.09.02.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:18:21 -0700 (PDT)
Message-ID: <9db74716-b0f7-4560-a5ed-9ecaca6a31b8@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 11:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at
 probe
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Marco Mattiolo <marco.mattiolo@hotmail.it>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, stable@vger.kernel.org
References: <20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a4YAM0SF c=1 sm=1 tr=0 ts=6aa1245f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FSV59ufblPRWrHBwF98A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwMyBTYWx0ZWRfX/jQesO6+yjOb
 pczZn3QRcbOHQpJxmjEjPCmX21n4WGFW5dUNSTIs6xRGoLLeSlZkR+ExWxmv+iCRvJpPtDB4P7z
 VOEyDGe1zmAVia2XhQs4m5OdHV4n+z0WP5oUR123RyfQWMU8W/5jBqg3DiApSIMHbHaQjOlOyf+
 cLmD4XAQIh5V1ytJce++q05+kwcxJV/eEjjrKGGbemwJWJYxwb/4vMJ+VYPKr+V5rIKyOyqO8Ps
 ORIotxup5kqhgYAAmGdYvqN4eLOs3tHI05TCGa9zR1/OF6ThbNvhIu9aOVdx9NTTKz7muM+ejG1
 2BuNENOQ1yGnniP9VXvJc09vlrxDUnNpZNXS1i4Ek2ofg+2baoEIHJQyLp7VoVnOJpQHLDQePJ6
 QhNO/wli11nQ0xxLHfw4/up7fIiGYoHCE55MltGhIfvz/UnCemkDsz4WeWqoJM4UX7t9cKFxMKf
 iO+37DWjRAWvRDFFlxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwMyBTYWx0ZWRfX/tbT1HO4zUjo
 X0FzCBpZZNKwpkJO05U8bz/QY2EQjae6GbZZHpOIOxQ/p0Zb1ejIVi2v1+ZUSvmpCci3z7yrVuf
 0t+Hd0Sk7Q+JaBnMpLgtNDfdUx/MplE=
X-Proofpoint-ORIG-GUID: cInn47iDFhEM0qrxwQ3bkw9UWL9_N3Nz
X-Proofpoint-GUID: cInn47iDFhEM0qrxwQ3bkw9UWL9_N3Nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090103

On 9/8/26 10:53 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> wled_configure_ovp_irq() derives the initial state of the OVP interrupt
> from the hardware:

[...]

> +	val = WLED_DEFAULT_BRIGHTNESS;
> +	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
> +
> +	/*
> +	 * The module may already be enabled, either by a bootloader that left
> +	 * the backlight lit or by the setup above. Record that, so that the
> +	 * first brightness update does not enable an already enabled module,
> +	 * and so that the OVP irq is armed from probe rather than from that
> +	 * first update.
> +	 */
> +	rc = regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
> +			 &mod_en);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (mod_en & WLED3_CTRL_REG_MOD_EN_MASK)
> +		wled->brightness = val;

This won't work for WLED5, you can implement backlight_ops.get_brightness()
and take advantage of having that function pointer

Otherwise I believe what this patch is good

Konrad
