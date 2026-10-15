Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0E44606D
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055642; cv=none; b=cVvCjF3hb+dRf8ZXu1OrBm19TFA0chOUhX5ZIc8qzAhEBnjzAc/cJg2gd4mCT7EXW0ykYsvzneYeNFlm+KEWLKMFs3ukzP+1ch2+R/DR1HayIqFpRLMQ/QhG6P4vRnaDo/UkUPvV5u0TL2XF4xQobAMXvt877Z2CEoTdCecL1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055642; c=relaxed/simple;
	bh=qphykZeRxA3Dm/sahKxkEFbK8FA+HtS1KvN3pqv/19E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnXARe/6U5GeGMfFD3py/boQLZc12s0ZcgEWCWAlOWsJidnWc8r8mJKiSJFbAT0bU2sPiZJGei4suh1RVBibgXjaKn84AshHJDhlqR0EKYqmV8qP6F3SjhWlVApEyBTlyEoyPNaRky24X3sQ1Az7kt42Egxif8vZtZin1c04LFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b209s6Je; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z65dgulu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b209s6Je";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z65dgulu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3xddC2738735
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VRZJ39RIeVlC9MlaNvNvmqPLISdXkSaEEscPGaGxyaE=; b=b209s6JerXmXYSXQ
	3HXDqVZvh0not3UsLCYTlKutDsK5OE6QGtKdw4cO3ckd9JvVioOxU4kwAOralrPK
	Hn2dNFyhN3yAGLTjVy7cbo8tG7xF0aCPkb/CDsSz1lxmJNng5qEPgwBjA6cIdp4U
	hIR0ir+rg7pqungrNDR35VelJXd3KUGVlUUHpXOk/I+gv+Y59ioVabLUkwa410NS
	yKdGzAXuoC4R7Sj9n2mfzk6a/8YZnhGR7hJCYlxpJomk954semw8leIfp5dqaB9R
	Hq7TMsTYurNT0aBtYkwNJsgwoi6rIa3dE2BvHPv+BUsjO5KyuKwVYL7jcH29Houi
	cQI4tg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds96th-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:13:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5338d5d0509so11029621cf.2
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792055637; x=1792660437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRZJ39RIeVlC9MlaNvNvmqPLISdXkSaEEscPGaGxyaE=;
        b=Z65dguluclSlbCFGSNmAoDPBsH87hg8srD0XB6aepISNu8eEvi6//8QEJTVqj0Wl3O
         83rAcPt9DXPC8CD1767K4DHTiDUEteqW3hnVklXEzJVSik3jb0MGbgK8AXAOz+6vZ8nQ
         ueLalhWqCL43jGYnMF8lWE+5yLwQrwIkyahE+CfkQ1bX2kzjjinMYtnzF0N6dfP7j9dU
         oAOo783e+2GOAtyDCtusFparb2ftge9UIqVk7HtEu0Iu5Iziea3KpsFBVIeP6s9ts54f
         FA6nyoGpUlBKzjNsnZ9bJDQmgDccLHbXWHYfnEyiCZ2RUE/YCCfaSaYeypqkSQ9nHgcL
         5jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055637; x=1792660437;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRZJ39RIeVlC9MlaNvNvmqPLISdXkSaEEscPGaGxyaE=;
        b=bPEvgR6RUK+bfz2cBl8xoXnHwL9Wqme9kJl2uDcMTVajbmtpfbsBz0SWLSlQuU9Ns9
         rMcxc+OWAiKfgQu+wHYdtAT7lXwhuDAYMpOfFdQDVIjomOyqa4bep9k7dHf0knA7zgnu
         WDtN/F/ytXTa1YovnkSBG1CNU2u4p0VIGxO2eOXc5nP0pZQl1EXasbtF1m+Rp9rya21r
         Q+zXMX6BwOs98CQXLA3a3vU5JjZfA3Y8Ayn2TMIeFsvi+SgRP6L5P7LvV8/ScILxcFS2
         fgurRcgFbdC8HwOCiBUE9ca8w3pV+vaqbiXZvC+sRBPJYfLvpPL27yFtuvgeruL9A+Bs
         6z1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzilgoV7RRsFHR1LI4hWVX1C+8or1bbw6GtkbX9S92q9aG6kfPPvx/Z4aukKxeRgAn+0FWshwPjdQqkgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI7l5g0Rqb5l6TAgBq3MDga0WrZM5aRRqk7kGJLP6GKSyeIjCx+
	FnvGVkgG9q/B/KRF1NK9UOW3AY/+Prj/TKbeyIIJMExW80q8JMT95p0NjqQdG9eexAUom7FIS1Q
	SSiTNZUc/fBGCR/Oj09FJmF2aa6QvaEBoz5wwEuIskVMPFBxIz1rg9KRBZHQnnisZXQ==
X-Gm-Gg: AYBFou0X8v2IHAHQEn2VJokJV2nDwYFSr0NLTMJpOtTwfdpsoD6z6Wp6zC0KUyZmrpt
	0S6P/Kwp64ewtwFdtWGe0WdkT+GFW2d6yoh05E3apOICrG26LzPMJDJX7hEsgySpedWacXXo+CA
	H5247bNFLPWVqGfWgsC1DFvsWhKFluEHxpmGGOLSQ3/5yqgxSATW9wC1WFa+laAXh5hdpOM+y2m
	8lbmhsvejL5mMZilG9C/aHhkn0enJRTb+NfxAhrnX0XEC8NM4AbpfU1j0wk1/gW1xJcvml+2xSi
	sUzleeIyWpioO1J3EZfHJnPQ8HUSqjn2vza/13Me1I3bSgnz2+9tj7ZX+yWNjHQhwPjy1m9V7PT
	uYHZ7wl4cQsxLqCTVnSWSLg==
X-Received: by 2002:a05:622a:4c7:b0:531:2133:cc7b with SMTP id d75a77b69052e-5359f05276amr354077391cf.0.1792055637389;
        Thu, 15 Oct 2026 02:13:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4c7:b0:531:2133:cc7b with SMTP id d75a77b69052e-5359f05276amr354076771cf.0.1792055636583;
        Thu, 15 Oct 2026 02:13:56 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3f0071777dsm87295266b.14.2026.10.15.02.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:13:55 -0700 (PDT)
Message-ID: <feb492d2-ec12-4077-9d5d-f1819586a41e@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:13:52 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] backlight: qcom-wled: fix string detection brightness
 on WLED5
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
 <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jVt6MRRVWGZ6BrECWWTllfpXLkivYzHo
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad09956 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9VxvTDaDK-J1xIkbkncA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfXzUfOrNWVLZtQ
 z0JsiD3aayxK2WyKJyGZ1ONg+FeslOKOE8ZODBuWzevympk/YbXHcy0jFkzXvNqbGDiXqv+4XrH
 dyZNgvJ2fNHK1wQSxtsMVvITXAf8UXc7FH/gxZawu6Hxfq+gzzvaXGULzkx8oQL/r1xtZzq7CkD
 edV+mjoaMnPOvzs5NKOXSsrWz3KPr39tRBPiuoSDNsOrpaAdyb6SPl2OrnPIJY8jZxA6HEVktBO
 zX7y3+5D0U+k2CPpqvUY+e3IbGIP39zojUCIq5rXOBlqPw18ElTHjDtbDDa8RFCEnwieryIkCDM
 Rv2om/5sVs63lQ/4cNBk9KfGvyh/XqKnS+jY4ZBaiAaGZXMM7q1HiwpsUArRUiua2cabGJzqSpu
 WlfFL5BaecOauYG2ACkkWx5iKwPkI8mJqnPUMaga2jvmLBcbq7j8SldMjmzs3F9UeRG6uRDig1j
 FHqhbZr5IUrs7MYTGyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX59wyvEchXj6s
 4FStUeQ6Azeb19MQeLIGO71beVSz2SWq0jrmnPV0flj6UJGc6AMGtzVLqieC8zrkqg7jk4ENT1b
 F4f2x1oAip+rD3CVI/ndfj6O0Syf1BM=
X-Proofpoint-GUID: jVt6MRRVWGZ6BrECWWTllfpXLkivYzHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150036

On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> The string detection sets the test brightness through
> wled4_set_brightness(). On WLED5 that writes to unrelated registers and
> the detection runs with whatever brightness has been programmed before.
> 
> Use the per-version callback and latch the new value on WLED5.
> 
> Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
