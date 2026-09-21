Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D148489A
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988937; cv=none; b=VRmmZkya5Iy4/bVGxpcsrNSyMwniBbj3gEP0C3HKhPg1UE9bEP+GJ3sDsIlSG4ZBw3xJjFiyA90qdf0Q8M7vY3Xpt3wKw1Ht4d7VoqxwjXWe1psKELG0gr+ofq9XGYgA2KAYlWdVwyL+Ai69NC02z6wbpBFNqWZ8KzcxF8REgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988937; c=relaxed/simple;
	bh=kUWqBH/ANEOMF+OfYL8lsNbfxAwjX2wTKEKovjJYSgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k10ZI5AleOMByVTVjnLAYr0d36a4yaXpafRVWRW91zUT9qyI5DiWz/BrL5clkalGTW3f1/aaK4UXlmR2MP4Eeq+sN7BhaeH3uUJGyMwUak4hvq2pdzNJcWjCcvXsGmE7EQwHQuR6qSDnivuXYxHkuV/nMDbR+AsULXj+PhhQwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EttIX+wK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L595+01X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EttIX+wK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L595+01X"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAe910419325
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+mt+jOa2RriQv+B+Wbv0m4jlSkeIIIrbl/YtagK9qk0=; b=EttIX+wKKp5EGn3p
	LtPmFUpyLInUxUc1Xw4Bq1V84fkHazBwgBh0h1WAZfY4jBHhzjG539FVbvvd+lZS
	FVZAZgA/316LeCbLJkaIvC9i7Od9EjBTp3/dL4ULavRQCxDs12SzPOA/uTQ8iGB+
	Xnr8jtfAzoe54OwdyLbnNmhjMscT5wMnIxRwoCyXCHCMrVaa8lNw0Z/1zmmZ7Jay
	cVZ1U4Us+i+8IrNhAbn/byrG88756CDM9wKiSpqeNATtmHaJp/uJHOC0X1mYxK0c
	cpv2vYCqEciAl1mPWRUQxI8/yOOlZfoVVGJtbc1kV1uaODpAZ2Hej888xHrX1lsO
	1YchcQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq8xfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:08:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530e0def61aso5032431cf.1
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 04:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789988926; x=1790593726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mt+jOa2RriQv+B+Wbv0m4jlSkeIIIrbl/YtagK9qk0=;
        b=L595+01X8adB+O6K7edEM/wbcWnzMJYDVXgGEnwbRVc5K9w2KhJc06TqxYFzBEz6v2
         1BAMwIo7OZ9ScwOMo+Lpr/6tWnica0qUOPdfE01LcYDcch6uns4P17dKO4Xf9nAcPXfG
         v04JFR6l3n4A80KZxQQcx2rW+oUe6UU7+9XhfvOR8eXn/5lTL+2nck0EDNW4Zz8TX3FT
         YUnhercBn4c0i59mjXGTyZhsM/5VV0abBdT+Q2Bm3lpsg8QbsXCfDVYDvFgWYm7q8GqK
         TGFNEH28+E6j1I5RYXPq09ENNo4Osf/hwt+E9JYCQCNxFeyJc0Uf0q1e8f7Thmx5hvXj
         9fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988926; x=1790593726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+mt+jOa2RriQv+B+Wbv0m4jlSkeIIIrbl/YtagK9qk0=;
        b=sy/CytFj2+/eIpgWTgJbzyVGgMjeMGrM4lZU06YjkhJg8QC0UmMyMWRKXaTyz3BnNq
         fG1WZn7x4vVcY5NB/vkhl/tNkMSAT+4BtbCR0rpiuRDJd2btJLF1HIa7y+GkSK2jNjcB
         XAGf7ACpKSTUdCzhJxUiNwdgJ1TVrnyqpuSqhHf9O6i4oY9moKocEix3Yz4jF6x9HxkK
         U+m8MIbOHyBsoqjIYn6UTb7Lr527CjX7KWnIW2zkhjYbyyUMAJkavpDy6sLEll+pOGG5
         vEqMzJF7opJkvi6bbGgU+OcrbergkpFuq3ssM5ZxtSxQ/jJxW904D3fnhLeLUT86nsND
         hzTg==
X-Forwarded-Encrypted: i=1; AKwUvBzHwOK3eleaDHiTcqkrjPJKcPkg1i3jiYMO+feCltwqewprUTRIrXNPIKkn+UPMEMNj8/ksZ99hqra6aQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l2EwPQPb5dAQgoSv2iTx7gS4mloeNSBIWBA6Ue8m4wLC64PCdw
	Wehr9+gdPEl2Y9g6RILozMZNA5BGQd0nXuwkfl0tJg5QZiFSIskwCNNES+aht2kAIQiA2XfOYgt
	VJrrc2oqzpLL1pOGhXDtKnIJrE1vTWKnS51RFadb7kVXz6VSI+/kEUYZkW0GR8xCvAw==
X-Gm-Gg: AYBFou2fYnS/4lTSFH79e8gJYpKppKXZMc38ew1YUTGjQnASXAlVGW1yndGqZCzPnRm
	vf3Y9BZsdE48StJTZi8FsQpFSy7LjBFGDX1KLBPpHtWFuKfh1i1MSy88+0QpPiLnjlGDMaQhRSp
	fQVDCfAn9JfAfFxfHvJRgztWzYnxFQaGX2zILVsryBIZrbV+ZorzEMqB3cX5xHvwiOxmcBnCvjj
	xBKLpdWifdy5bo9cO+ZjxRBI8x5DAPb7evyJkhe+Tnirq8E/UgJf08EvIf/bK6CJtenEdtgrpYl
	z3Uzdi6ziqOj+Mc7lJjwJnefihl0JaAQLKubiw8x0dC+uiP8RO1OGowiJY9YjjZ+0u6t3en5a3S
	Zkuh/dQ/T7SuNmcmwzaxU2A==
X-Received: by 2002:a05:622a:1911:b0:52d:8270:8e36 with SMTP id d75a77b69052e-532b743d863mr99486041cf.5.1789988925767;
        Mon, 21 Sep 2026 04:08:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1911:b0:52d:8270:8e36 with SMTP id d75a77b69052e-532b743d863mr99485651cf.5.1789988925398;
        Mon, 21 Sep 2026 04:08:45 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a607468ee9sm22436471fa.3.2026.09.21.04.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:08:44 -0700 (PDT)
Message-ID: <22355625-a2ea-4b6e-99b3-65cf93ac8034@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:08:41 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] backlight: qcom-wled: Fix WLED3 brightness
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
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260921-qcom-wled-backlight-v4-2-bab8c7ef73cb@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ixzaJreJyJbszCGJaxcCiC6caf9jtQbX
X-Proofpoint-ORIG-GUID: ixzaJreJyJbszCGJaxcCiC6caf9jtQbX
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab11040 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q3U7ue9uqBl2Npjrlm8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfXy6Gl5YDMvZLL
 lCxC+WcDbxTXFuklIblSBdFh8SQ6HitRxE6la0hzR26cex3myv1TB7s1oKLTmwF2DqIqSlOTT4Z
 Fd10MYfl4i7CLYb+YUhwHOheA5vF6QmZP6+sAJtGUbd8P5FwyJL/NSbjgjkr8u84ZVP5Zuy3gz8
 e3cHbHAg0xiDrpric73gXyVOy3vVKdpRKId/P16l7kJ/ItLgxZ57G3TgqyvmBmbXJVXYlWVyTha
 sjAFMDaSHoLfnSZY2RBRUL1kKBZRlUBPDqq3AS8mF8vr2LNOqOoRV3exNMdIk1ciX5CJjVqLssA
 qOoweXT3b5kTNxUusaXlsAgImDYvXgoVx6HbAfbHMyEmfEP/VZ2x6OwkzlGtFJqD27bBNwuoEsb
 OMpZfqJu19aAlwFpnxjVwXAlnRVtM68de+LYBAP+T5NawLA5catpC83xunTQ33wDu3f1akGwJ7x
 541v0Vzkp6EW+4BwK5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX1ZeaM60bUPy2
 0AEZxMclfnGtbRdicL3uk01+gy5Yq9KaLqp5kYDaIfPthW5aSO4QFn4QpYeGuln/MEcRQwdsF5L
 oPA/tSOLxXd50i1rJiegWpOF36BjB5M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210160

On 9/21/26 12:46 PM, David Heidelberg via B4 Relay wrote:
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
> index 2281007bdd459..f452d328997ad 100644
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
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x2))

Ideally n would be wrapped in its own parentheses (doesn't
checkpatch warn against that?)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
