Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239804A4835
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055445; cv=none; b=Ywjbx6iFrOX3Zz4eI2KbUBFjdqkFjNtq0IjZbDO3WCnIjELTPmHkHZVaLBRpcZ8vjMMjFu2zaqfXwp4lF3MlpDXZMa0wAQDSQZqJ/xs7UKFNHHHup8DoY5tS5+ZPzUOBENNojPC1MMzbidC6yk+YkzgWhDQMP/i5c5sOvcGY1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055445; c=relaxed/simple;
	bh=F9sCs/Et+Q8r2QxPlaxDRFhUFrobaL5SK4g9Bng5fxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxUN7Vf5IFvSz9weIFSS8jRVvIwqEhkSAU3paeY3NZUOJaJTEl1f9AY2c00jjgVcfN8B4iAxOU6ytQjvvjmUtOQYEJBDl+YF9HaZ2nJLtS1ZhSqv5UysgFwMmHXpYiNHeTaoJL7Ta031QLOqkBSkGbaxFEM1LpOuK4r65pai2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lNXqNt3t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=efGQ8lNf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lNXqNt3t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="efGQ8lNf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F6KKW9644643
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BdDwoOcc/IZIcemzbEOb6Rk++kVeyFBUpRdmHijaAIM=; b=lNXqNt3tkE/p961B
	wahr3Lmhg1umEwgGeBlbKzdQD6+6DynIJcumsyW6FdgTDooOm3yrmyvioHialzms
	4apGwbfbo6HiiyUDj1e5uBpp1Ee4wERSV7RwMiy596LX/OmTC4reOEvy51vIHXm2
	ynGUNLCBTYitPT1RcFUlTqM5l49FExlq1TFFBc04dxFmK9M3f+1IbifZII0Ndiux
	taB/MRxOO7o9Jw/b3Xc8Z9JLQLWfZlV/p4OPfYk2qSS7vS6T+Z1CmYIydDcZsuvi
	KZ+71i0ZmtUzqvedLDcuCYCk2u96iDIPO76GTZpBlu/Kjvgj3KgXi7xQ2ui3/X44
	QLkjrg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmya65x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:10:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53389750985so10410301cf.3
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792055442; x=1792660242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdDwoOcc/IZIcemzbEOb6Rk++kVeyFBUpRdmHijaAIM=;
        b=efGQ8lNfNn2oMJbrd9Mo/emcmGmOyRNlqaEQ/R7Rpu2GenraIp0X7rIaYILNM/mmEw
         cacFoAQWMbCA4JeBeB2O7oWpgDmO8FFC5u6RMW8NgUtqlzU/xMd+2+41TudaLOkuKAgO
         Wu+brPREoPdFrc3Zrq/cxCeAlVcO1ca8iP5ltF8NACtg5zSq2yEiQFWyMKJdfPN4WrCE
         ekfyXs6eqHOwJcPYb4JjFCUMgJho0Ki0gG223DLi5Hq03s0Z03lo0bCi9ii+y+N29Nqo
         mWm4OqwGnrlqaeMWI2kwcakTWlldac//ksAjeYO9XCpSk+4NNSkN7pmElu2KY2jOpNug
         gNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055442; x=1792660242;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BdDwoOcc/IZIcemzbEOb6Rk++kVeyFBUpRdmHijaAIM=;
        b=QSYqg4RUSfQGplolcjyRkiONeh1yeVzER6JC6+qV6fUCDTefx00NDpY7Th9jpV8UZ0
         2CsNvxUiAlf7dHhej475Sobcp6ArcsVh5lRZBactULZDSMoPr/bt8s4M86TQVSHHZINg
         c0FVhXKSh3sxEEbddgXQCzZpzAX/8pCeLUoZ4+rQdc8BnZE/TsemO2c9h5ikiefiLc+K
         OZrWuVph1kS8P8vffAOkLV/jML6sQUem607vjbvhlEc3G//A0GnYr19gPZb8fM3H8GfK
         zaTSDNV7/Co16wjvlhZMBI/ZhT1qBJXzzMrSptxAq2BJmcDwsDtAU/mzkMBptts7NGTb
         svig==
X-Forwarded-Encrypted: i=1; AKwUvBxKQjZXBBrHFoe6upJUQpYJ0ChqOlT0GOQ4Bd2EPsx+2lBNReGG9tRF0kIQ3DUoFGk+w6jAvUAxpbKs5w==@vger.kernel.org
X-Gm-Message-State: AFq9FYLE2i2vkxgwqS5PkuXi6SOu3WerejdOLDc5hkFCKdezPuIZN+1Q
	vT4JxrBuCL7hFfS3ITKzodsnJn33/iJNXsoXpb5e7KKqb3papyAljyNAbozZ5Xn9en4BFK3nzq3
	pAdo1w/87K8EZp1sDOVksvP498ywhll6mXO7lpu7qkGS3PRl/GXa6uBTAAJevPP0SoQ==
X-Gm-Gg: AYBFou3plnjfiJRsX/SP9gGZqrpSn2x5QUV0dXn7Z4qfEZ6UhqyXVlOZXog9UK++AFw
	TaB5ezToA964IwmJE9GRMSvK+yRt6EjdQmRSYT5ugXy0mS3FkTg1GE/Hb5PqhVkl3TtfQ55CbZu
	WVFArwKjgOobiNIxRliX5eMLkNd4VqCpXY6mZAvbYKgHF2TdbVvEr6wA6vyIt072lapunwbZ1cg
	L2YqvUrlatnS4GE69vRHya1GugvQWX4kH25++n/BCVfXvuLO/cd/Tir0dBJLRCyEfqSV7sVxuWM
	GLXa1SEnL3hoPmpmxB94WmgwHPzXAp9GhrYbzcTTSckrAFkaJdv+fzatjmBJiBgWuxlHfq/30/T
	iOjRkJBqbvgWGrXxj95hPeA==
X-Received: by 2002:a05:620a:199b:b0:939:eb09:4458 with SMTP id af79cd13be357-93ebd1de450mr3641735585a.3.1792055442360;
        Thu, 15 Oct 2026 02:10:42 -0700 (PDT)
X-Received: by 2002:a05:620a:199b:b0:939:eb09:4458 with SMTP id af79cd13be357-93ebd1de450mr3641732685a.3.1792055441898;
        Thu, 15 Oct 2026 02:10:41 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b2038abf24sm2188025a12.37.2026.10.15.02.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:10:40 -0700 (PDT)
Message-ID: <ddbb547a-f59f-4ad2-8c99-4436bdae84c7@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:10:38 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -h_Lrh1QB-t5CXJ_-2i5GQnRQYhWwEed
X-Proofpoint-ORIG-GUID: -h_Lrh1QB-t5CXJ_-2i5GQnRQYhWwEed
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX2gBdSYqQKk2T
 yq3AjvjWhqymEAG42FFAoGrXqINQEWeNJ5509VlXE5luWeAJMu4Mo4A34xuPwha+GPXoouLyM3U
 4NDFoIjRyqPamA5CNluxVHoaWQH6b+k=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad09893 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7g7iOhDP9QsUep1Qju8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX0Lphw4dhk/Ju
 IK8zElP4mnmhSsw607JGFsFCior7KA9TQgOOxcJQ5yWbOem2aC7pw+1FrZj+4VPG1vfjc7vkhmp
 OVxrss/o5wz2QY6+HDZcd3jlOjva/8LDnmzvg8SZCiOyBsJr9mNBOTHI4MFGmhvFYD5hvxdOZUp
 50B9Urn72a0E1kMeJ5U2woB7wHQv+k3oB6EApII8tdSOUgWlx8hsJG3NKNCHMeIX0GVNE4QasH+
 tzqPuBLQFO/rd/hA6KM9l+FmELrELDEQfuwnJrIZgYfe6ggL/Fo+XlWOuxQCX8M8mNJI5NxCtiC
 N4nG+Tx/YCfdxW0+7EMQ5ltb7w7qAQDfo8MRBnOh2yceP/9ACflfpF1iEI4z0xyHTyMELTTMjHz
 kB+ycef5VNHOeP9QC1JVhTsp+dE6+js1A0AIhh1BPOBGJpE7Pe+rxuiSitDOVq0dTdR2+3wSTka
 ge4X+IUCrF+Te/mIyjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150036

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
> the wrong address the mux driver fails to probe, the Type-C controller
> and the DisplayPort controller keep waiting for it and the display
> subsystem never binds.
> 
> Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Hm, there's an ADDR pin on the FSA. I wonder if the previous guy had
an earlier revision of the board which routed that differently or
something.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

