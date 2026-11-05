Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866960;
	b=m7uCF7M35LqVNZvmy4SBipoJj0ZrQzxp49ppronfPPysxMu6DyCkEtBvisfg/A8gotLW
	 mijjx9lnJxnEVwhAqge5T5q0f5UNaHoZxUnJ3re8sdk7urFtSofWqXt6AO6YZwKc8LJeJ
	 hA12QXDlE+0Oh73pkGb1LS+BzmRXzH3XROfyUxbDpB0msiJzhYmEssGDBNl8zTr2UVzQ+
	 aO7nh5boiX7Ee4v1QDQ8IIOn6jkIdGYs27e2b2pkNMo4sHLxx5s5UVIaWMzPmnWv6+2Hf
	 enxHNQP0D7v2Ea8HrZEGp34RFFtvEcVSNdFxyAh3aOAxOYcbk5G5ZHPqxlZLz+P8/UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866960;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
	b=pmAfXp8p2Q0dT5ECJ9j0n8jujS6ak2P9Rd6XrwWRnF68q0VoRLiWpzRITTkKPDnVTMU0
	 ggZhheP4o3z7LIFVyEeFtyk7/qiHSuNC/eYPpZW4xysfTz3dPGqekOF5aN6IX3PaS5cKC
	 ojOypvNzJ9QT9NlkF1CE+1F/u4yb6MHd41wovxJNL/0pTRPDv1D9pOwxgYmUrQtcuGwre
	 8f6oc3CxshkP81LrsUPFei2as8ug17DVVqRs9pWafYgDVRDhaT6maCEG3lUHR0XJSMaf6
	 OYOBRsV63S6FpSRVAHg4DZvkSHbNUenqbhg3Bbk1++XpOt5PsMSYLwfIhz4Y47lkz/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=memcz5aT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YOJ7WMtd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BD606A31B
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 08:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A16BD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=memcz5aT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YOJ7WMtd
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56USq8942456
	for <linux-fbdev@vger.kernel.org>; Thu, 5 Nov 2026 08:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=; b=memcz5aTefo4KGOZ
	rgWnJ/uabi3neKbmngooBNvd7gHrIpsZOx1v8gPp01TSx/0fhIHBJqOv+lwgFfCG
	47mYl3Tw62xnSS9XD1oqDXhK5a/cCwCK/aVh3WfzN4HGy183y1iKNnw34xGH7CNM
	4w8Z96I4V1sjRr/VMEsm3PlWdHTFJ0E+2oc1RrYHWy+IF57bJtBK8XPAutXx1Gnr
	5SnOA9FmmYdNboeTIRW1b2MUIOABLurLebyBAgssvIq6xdd4XnkDpyqgfFtQCrlj
	MgZaKBrrCyBTdr6m9HNGLaIGAfiZOPg0BL/B22YQa/XLqzoZV5RttPlEF0V78/Wo
	+SaTBA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bj3yc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 08:22:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91bf35c4c78so2618436d6.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 00:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866958; x=1794471758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
        b=YOJ7WMtdQz0aIapT4F9RwpJ2i+ZE3XgX5li2D8OAA3ZdxMkOyrB23muMp/CaD6usN7
         fJP5JAMRjY0aFPc1hNf8n+yLXnPuEbHWd9meh9NQjFtJFw1wS+bK5ljm2OBd4xKND3zR
         uheh6pWUqEny6VHsU+U1Ye5NgpqgpGKRKgIvy1e0JMzA4cRH83XKidvXwWT4igX6QiRS
         BSwYIozmcmtbIVoaUNi0JIHwfr4NGdoYFYnPsdsNbGEhd8wqecVz5ORdfVCd0es0D0lO
         8HaLGcYOIgZIpuO6X3bxxs8QywZU5YItmgNUEUc7iaLP/JusFA1bdqLTE5/AGO9wfcEn
         /aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866958; x=1794471758;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
        b=P9/lUUZytknVtevyIG6mEJU6k9miBMQ0N1t57tfdold+FHfDbGo7oW8Q7qXJ3q39KE
         UTdOrCVJU5E84UHNgzlQjbm7PZLxLYLoWJpTQ7Pv0UrP0u91FdKsMGLKoj9RUtn8dVPS
         LpjmlGRysxjQZ6DxzWf541Wlicq/uc27yi8GQPG2/yRGyI6/wZO0svKebI37rd+2zvwg
         t5Aef/up8+9esVB0HKBjj0GO2vVdIKaTIHx/KzpjmvlvJsRS/cCprZkt++Tjx+xfiwtQ
         BPg3bfGPELwyKMxV/EKlfiDDIuVMHmadCpH4AbfT5uSJjQmjR9aXvFP5lIIpgp3iIsI1
         WS7Q==
X-Forwarded-Encrypted: i=1; AKwUvByP0zLa1nxoGzTbhA9+qEjLisueMpUIGVBAxvSZbrP5H2+HCaD/W465pjAqwUIpg6FHo03rNVnm8gRKLw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8JUPMA0o1+DTRssj7nSTP6PT/FaWCsJzf0vrwEqIHmdMw0QC+2
	lVwIfX5PIsNCL9DZZeJI+3GmhK/uZg6KiIWaRjc5BqMILTvpSWVWNdGF/KtwsHFqd6MQGqfGU3h
	fvUq0cPJch5pzZVbgbcAN9iTdYtfrKi6ydB1qiDdi6s6Th/3Pzxeu6V2G/QBHkaSsnA==
X-Gm-Gg: AYBFou1qGcdyxIvwYOX1yr7DxPtGFcYVU8ADgsWSQ5MpL4J8KcGi3ReW6RP0M24IslR
	PfWDmSifqv170BQ2bgUv7itiIcPk8hz0m46GGNFEYudC6G1Dg3CRbEGAlpWGOoV876eI5mwF9Ax
	tCddFBCqmGS/MBhI3YBvN/Itx8Hm845oDh1srj4f2Gr51OonxIcYGYq4eMoQ/+kY8CZG9kq6B6E
	08zoWWtQ4fdSNAYplhqHgutvAg5SL3ZMSPlcCjNgi756TuyXRfDR2vqNv7e9p6dmkOK4zQ3fO/b
	G53B57ALjBDhb6glY27X3zz7rG/GBOv9JQFH/N3MS2RbdsslznZ28cuukiS/xEgmBasvygx4S+q
	cJw3P4K9VkJ8P8CNnghenqKSPp/ZuKdjzk1AS1YtBOp0EqJMvnxjS8sg83z+qS33BmtkD
X-Received: by 2002:a05:6214:5284:b0:914:521e:7da5 with SMTP id 6a1803df08f44-91ca49e1e07mr371652836d6.1.1793866957692;
        Thu, 05 Nov 2026 00:22:37 -0800 (PST)
X-Received: by 2002:a05:6214:5284:b0:914:521e:7da5 with SMTP id 6a1803df08f44-91ca49e1e07mr371652436d6.1.1793866957143;
        Thu, 05 Nov 2026 00:22:37 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b57e26b0ffsm438510a12.32.2026.11.05.00.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:22:35 -0800 (PST)
Message-ID: <2711cffc-81b0-4078-b3a4-decad4969e33@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:22:32 +0100
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] backlight: qcom-wled: Avoid AB-BA deadlock in
 wled_module_enable()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-7-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-7-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX0/MEuyNVbcFT
 kZG7pHy7lafJ/g96ZjgfrSWm4njPMNt/kuJ+wwMKLU8EllsF8s6PDjMjw3xq2WKZ+1uP8kNaSTj
 cR4a9EPMcJL51kyixNQJgkRVIKFYoLkHJfViMEmN+QbZ7jYbxgcoaOfJnvVctaR51HpOqEpdYe8
 5XCCWOtsbN02ycHUSkCAjLAoO0W/l6yVV8H8vPiwsLPEW+ruM3WMxdAxit8fqyQTfTo/O/IGUIE
 /47bWF00qLjhJgeDNsIL3hr46ujeArlkJYTxeY5dML+49I/UAzCmBuTf3WrN2AlUaVzTCVZSv2T
 PLL36OgzRlvhMC7MYzBl/hUEhtG5GrB7fsh+M6jDHvgA/++APCpKU6WzqNzh76+rdv0qfTevYKd
 UuaB7yAe0Omh1IkDjVj4iO4VdRFLp2pBxhiK08khSubOjVdGP6teNsR937WUbbtLJYggSFzd578
 Z/y63fMq8/hHTGkO09Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX1Hwqc46cWL8Q
 IDr1BX9w9AlXw8dx3XRnW5NXVIe9hGdrg++vP3hfU38KvVOJtHb0C4s/PbBbv36rxnxOcPnqit3
 nvOFArTckqSHbOe6BCI8sUXCVyHGz50=
X-Proofpoint-ORIG-GUID: Uflao7nj-tRKVVpV8H1biQWWNKZXJBkp
X-Proofpoint-GUID: Uflao7nj-tRKVVpV8H1biQWWNKZXJBkp
X-Authority-Analysis: v=2.4 cv=N/u8hG9B c=1 sm=1 tr=0 ts=6aec3cce cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cyDCuRFuYf_2H7WJZrMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050033

On 11/4/26 7:39 PM, Lee Jones wrote:
> When disabling the WLED module (for example from wled_update_status() or
> wled_short_irq_handler()), the caller holds wled->lock and invokes
> wled_module_enable(wled, false), which calls disable_irq(wled->ovp_irq)
> and blocks waiting for any executing OVP threaded interrupt handler to
> complete.
> 
> If wled_ovp_irq_handler() is concurrently executing, it attempts to
> acquire wled->lock before running wled_auto_string_detection(),
> resulting in an AB-BA deadlock between wled->lock and IRQ completion.
> 
> Use disable_irq_nosync() instead of disable_irq() in
> wled_module_enable() so that the OVP interrupt is masked without
> synchronously waiting for the threaded handler while holding wled->lock.
> Because wled_ovp_irq_handler() may already be waiting on wled->lock when
> the module is disabled, verify under wled->lock that the module is still
> enabled and not disabled by a short before running
> wled_auto_string_detection().
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-3afa151c-7b8f-432c-8f85-8c43a83b964a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
