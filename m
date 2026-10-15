Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1481B4138
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055527; cv=none; b=HDxgJzEstLFtx9Q8vJkMBP7dKL3TcR0yfzkrEuYd198hXnIxzDBxCm5yukQgFCfm3CZmrmyo0cBL96oQZtRW60bLVrzX2YLB23oU58i5rrnyaCxavbST6ghPRxktgeCKa63hShiPpg407O5UkyjTw/Thk28KhtJ0zOvia0TiVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055527; c=relaxed/simple;
	bh=14UNhDwSqIGwxH8eFCUOb/Ru8LN9tAiu4BmjCrwghaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vqrr0zk9knshqub3dgEfIDB5ZRHdUQqh8OtUl2DCufH+01dvcIbiyGK+do/kCNAmfNfUUdn02TNjokngrF173cPou5tx0ywchBPfxyFNuu0uqvtOoEcNkSBdFNGqfJVJs4mQUNwOmsDA/8aPfc8tZbELSsPG0X0IF4aJtTEL15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMNRiQwI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdZJIOaw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMNRiQwI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdZJIOaw"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3wbmd1889509
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HUBB12m89z/qSO0zlxArjpEPX2BkQ4pnL/v03QTeSF0=; b=aMNRiQwIIFWHlTal
	SIMFgwXbrdTzdpk6c7h5Fcz1W4YB/+YEt+u2yda6R1bMQEhvFAFGefcMhLVx4d6b
	cfrx+yJtHLY24a0xFmPGjI0TgUQS36D3YZFADs+ib07/NM0eNuP5HDMeuDPBF3Az
	FE0Z4+ApkZAntbkmtGmpDzjqllBIQo7FPDXkmRcQRKc1iTBOo23zjKxOiDzxLtxE
	xDEGP6YBLly6OPtftIC1XGtF7RpjLajAgWFHSsXoFHXniHNU0lpjME4SKEJ2w/rM
	bjC4ShzKR1cvtLxdqSckr/Y/1bkdqM0G8UOZUmBocuZ4WnZLj6N7+WgYxtkOgZ+m
	oXxSjQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda179p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:12:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93edac5877bso50711285a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792055524; x=1792660324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUBB12m89z/qSO0zlxArjpEPX2BkQ4pnL/v03QTeSF0=;
        b=LdZJIOawlbS/ar0c4iL2op4HXcHDicWfU5NnYxtsitHluYHJzrUBWSFlCdAX0DK/JR
         STR2bh4ugvTf2zjzLEkifKkXq+mqwVsG+CoHrFwxSBE+Nlg/3vA/4VTf+RIYL+HHRtP7
         NPlnOwhZMoTVcMi/lw00F60wYHMTgXsCTV70Va38Co8+y7kKfwww7pgoJrm7MljxaZxg
         WN9woDzk5TPf6Zf9XnWoK3kPndudq5GG4gnxiFnHpTZ9P/KWj+bQj237X1yhYYlP0X4+
         ZfkA29f4NxZ1ZAqb+nRk8hVlrQzQr/3A/xwV6hRSfExZUTt2P7h2R6kOEn5VKD7w1DYO
         d43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055524; x=1792660324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HUBB12m89z/qSO0zlxArjpEPX2BkQ4pnL/v03QTeSF0=;
        b=BCmzTWLPbhR5gW26DWisK4lRnMjBuzAjM5kqkn/JM1JPcjEEvULlcxNBZUuD8hlTus
         iI+rJgviN7naQeeEKNblwyI30Uz8wbcvVpYCqUEz5Tuch/MAokCen8uIKodeaQDaqkos
         6YYIc3O7V+tCn1Mzdpm8xAoHBTnzb5u7KMvxrqgdor8FWEP06UVz9NsFFZKbIczuJafH
         iBW/Lpmr4PDp7XTJVTb4BnaCz+U8/E7rcGCmMwvw7FWWyahi1YLXQkIFqgJcDOI16znT
         2Fuvlx+Mu97tJzSmIXNK66sGx4uFJVsdSHmLUcQ1hb49ZJlAfUVCqmmQkQGX0ty0b3MJ
         08tg==
X-Forwarded-Encrypted: i=1; AKwUvBwwG22RYATd5xLVEiSK76AhNnTyH2kmm3WQb9KQx3MGnpr+1Fd4PAGseUXxYyZl1wK9aDU4867y+at2dw==@vger.kernel.org
X-Gm-Message-State: AFq9FYISAzu8LZdY3qU5ZFg3q8O44kZIkSiM0+sk5ndd6u/1B8qYbEfX
	4RN3gq848f/OYwCqLwY77h0ofRyEKMshgV4H1b1/KfN7bTa7lyfwHDZ62ykGirUci51WA4htZ5n
	udoNbuKtD/jA+9ADkqr3LGXKvtvHonFcU/rGLqfefkCxjHFQwFO3QY/bjwkErJkMADw==
X-Gm-Gg: AYBFou2ffirqsDQNA5ouSLoA/XtEtGr7vlhT9eZTH1sIiwfwDOAKY7sLruzzAM6rgLF
	hk8U2c39XBCDY9W0ikVyFot+TOw1nnkJURaCAqUvUftvM26g97uoFxhlfJzep8OyphT4Jx6z+fE
	WC3XgcuxsWvNAny3J3VXQwYxRjo8T3BJaWBO6SXmbypp0YhGcV8e/9CprNQnFjpsjtBoKZ9ivA7
	uVdlNR0c8PciyH8tzbaUPKZ28HTOer3JV22P0hF8VW9V10Sz9NYjXYY9cFqFC9Ra+xdhz7fw67X
	hAgb9YBvKQfoIaT2psmttRQ0kNbcZqvwpPSoZwv74xAfL51I+M0KZnkwjv69bJYfVRvDXmT2rXT
	eZK6+wvtJPq9LLJdGMCADsA==
X-Received: by 2002:a05:620a:2b86:b0:93d:9dbe:5bec with SMTP id af79cd13be357-93ebd10b418mr3112658385a.2.1792055524097;
        Thu, 15 Oct 2026 02:12:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2b86:b0:93d:9dbe:5bec with SMTP id af79cd13be357-93ebd10b418mr3112654885a.2.1792055523631;
        Thu, 15 Oct 2026 02:12:03 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20388c1f1sm2263767a12.26.2026.10.15.02.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:12:02 -0700 (PDT)
Message-ID: <eda50ac2-bd4d-4151-b041-7f9fd56d9fe3@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:11:58 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] backlight: qcom-wled: fix unbalanced OVP interrupt
 enable
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
 <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX0LpdK6/J6fas
 4XGwhAzBQ0kvxw5wtkur8QxPkgc+347S36eVSTcwI/EbwD6utUH4LVl3AUiGJWttSjeiuyw/Cj7
 UP5euEEZhcJf8SNucJsvlxQv5xbmbnE=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad098e5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3BQMGBUH80HoBbyhx_0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: TvIUX4l6djArBktWtgWidJDLK_FqnIoJ
X-Proofpoint-ORIG-GUID: TvIUX4l6djArBktWtgWidJDLK_FqnIoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX+xHxwKaec2VS
 rIeLpnGzV7kyzBJPkZv4jDH+d6GEaxlcPA908JVvHIsGGGCxrXovfFSm40sCz3tIfesF2gRIUGd
 qdK+ak5m3yppUyqPRMmLmBn/wSNqzJiAs7UhLHYg+mk/TCGQfjamYvmqPiNWjgAIh0G0chXJLAJ
 9QdpLGcvzlx3Y8JP2TJTCVtw4eJyN4wLgbGxtkkuwRPb8jJg8LxG/SADtRz9axcClTL1Cy721IO
 TFnNx3lsBHhcsgKW8yLvZx/XDLlqE9kBbtIfAM0Uo82g/VsYRwEBgKRFloDCvcQEbKfbpOTY2kr
 2txKDvxy4CWWfBmGeCK+wqEHVZEh6MLFEz8aD3/qVJBtBCajDburhBibdXRyjV3uzLLc6CgT+r5
 XQXswCF6AfzwrLSDG49idKJrYS2VPs1eu1YRQi95wPYtDNBq9tJaQZSYEuKEFj2P7vyrxvOvFnT
 BW+Mhs8OtYEkWoxUY9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150036

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> If the bootloader leaves the WLED module enabled, the OVP interrupt is
> left enabled at probe time. The first brightness update then schedules
> wled_ovp_work(), which enables the interrupt for a second time and
> triggers the "Unbalanced enable for IRQ" warning.
> 
> Track whether the driver has disabled the interrupt and only enable it
> back in that case.
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

This was merged yesterday:

https://lore.kernel.org/lkml/20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz/

Konrad
