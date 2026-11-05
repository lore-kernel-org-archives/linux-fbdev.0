Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866436;
	b=xJXinsT3Xt9aghqyMzeptaYcnCEYnA6lvwSTclWNKebCC6hdbSUbfN42MtU58MH4dbkD
	 a8a8nZf+2x3kLiH1dBx8kkrNj0z3K08YBudvWQqLhjruK/SB069ZHViykajrswedM2dQ9
	 rzBzizq+TjcegS9/NJEA6BYNTvuynmyPqtNLwaFmkpHC5uVKJkOAPM6GTiWI6xU01nZbE
	 CIOra2kNlpVfBw+ZjB9VAlEVRNs6COwxPfEssFIuQWy+yvtuRaDoKrvhRKrRvD/28Ivf1
	 eb6MK2y2589YkL0hBj3akniGjljMw9r8wKIV1JjuVHdAaB0/qBIF0AntxLQNjB8NWFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866436;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
	b=Ds7G0eeXT+yIOFClmDBEnq2piAKu5hMRctu/40er/v3e4ZYRU07WiQzd3ZeCi78KQxpr
	 0OwSwIGq9I3QAM+wCc91Qtk1nWhmgsxs+FyJIuc2Tjm/+srp4AefChvINOb5jiCUsyuHO
	 JyM8OzrpNXNMOyszsknASB8AWC9mdmKuXvptKEz/vP4wbeiR2HH37MG+G0nYb5Fgi1Ah+
	 3mxaAtnTKIEq8PTJDtKm9roWb6vket8O0Ia1hijmViEhgyShJ9VXkS2WW2LGW6VJVA+x9
	 6GFE+A+FPaRNwsSu8ti/jb9oz6zqWKrmBTyqY5aG2uxVyIzIkkWuEBzUae0fo8/G5RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zsj4yhUx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NCiP47kF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EF606A32D
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 08:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428EF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zsj4yhUx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NCiP47kF
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UK4M1018043
	for <linux-fbdev@vger.kernel.org>; Thu, 5 Nov 2026 08:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=; b=Zsj4yhUx3fB/7g43
	z5tJ9j1Dzf287bjQpuykmLSzBhhTUd+JO/SkwgbnukQ0jnwK39P5Cal5up5XDRDN
	VDyGL/IW+17MiJvu5RzUND4cEPuMDaXcPjYBhFFz/dx0bpWY3p8rkPFpb7u6WvyE
	Yf0DrV5WcabBL2O783wpDsKfdY1JFhxbjc+4KhHbCg91ihfQlHP6heqbekB9Sewm
	bdWTk6yUAkKDqV2MuX7rbYZPTSFrZH7qBOn3IVjRtu/12/wCzDP05E1rehyogCGt
	7D6N/6Li8wzFjbEcNOnBjQ6+VSgvntwg+UJC5UEy2FTO2H+pmbvBbR3Utv9lCo7E
	d/+qlw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bnm006-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 08:13:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9178ba8eb30so2576186d6.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 00:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866434; x=1794471234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
        b=NCiP47kFHd2kcmF2wOTQ0+GW5EXh542X7cgv3tKjvJNmfj+tgqdfhlVUq9VOI5pMZH
         j5mTXh6P6nNA6LgOWMht7icM+pp+5A6cXBCBfCQfiAxqikGPI+k/tPK9gN3TxNBZWOwI
         m1s8uEb1bDWiD1LoZIqdOxLS27T9iUVZKrNwMTKg/Gp5hlqe6OkeiVkpojotp9WL5Pfd
         KiEeDpR2t9rn7rj3UwEPhm6evOKE0WRgJWNhA0Fi9DoTywbKUkoVtiUJnD4lCBplpEeq
         o7vKpEX0ZPyPZVNTUKoy5GkPrHgYMu/u5I1Zkr/RaTcYm+Gif+ELC3C03bLof6GeinqU
         W0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866434; x=1794471234;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
        b=IIMxImpQEXk5aSMR2OQv2jZYnq231RDgunuhIcy0I5/JiT9zmZYzF1EDjodZwYr0nP
         9xZPoXjANwuCT6bkUyJU5/57sbip8XwMnYqCEKVdOrWXSl6N5ZEJ8RP0DLnqjxmR91b/
         i9ZSSY0COq0M275zXOpqdYup0qpqF695XMMiy5hfV0/DCEAxAhxm4xv2R4YzkDJMXRFQ
         BnoP6I2n4ql7DhFMdE5s0kCHMtXPS7PgFohXk1euvWwNwyRz938GR8cZRD2wIV/0cNTQ
         AGpFttNSWErnFfpsFT1qpS3p4XS9kU6Avzec5ow7Fpi2bN/uRKGP90wWwK78ZoN20bvQ
         cuuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZ65fcMF+uGmAucA4cx94idCs+IoYzGd8zDTtDyOOexR/0URPclHUPGIA0btKV1wgqIgO2OSgRRBXgig==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OWmW8CQllR291OV98eyr8/QjDAl89Tm3V9to5425HGuWmZyoU
	r+iPeVzzo7DGYTmVgXjdbayZQVLRuKUuEqgLbmurgGbBoQl1CB3eh8PEiKGrncgJimbp/0l8nAk
	19XrBLMhWULHhc+HUvkz38EDrjRhh9UKAPY9IG173hgFM9IECaEcGLY5FW2trngYEIg==
X-Gm-Gg: AYBFou2e0seX/WyjZC3Xd5RZyqm2Vikns+SCiu90Hrxx1ihe09vLPUD+wMx8vPMeO15
	OaIkzDBPT07c57HUVq+OWmbrruWD5oCzwHIhDgQefP5Rl9CHbofHIjMhFV+ceg2Er9sJxtMsGhX
	G7cYq2p3KRmLlK9KCwgFJfZEHI9D9NvYUAbj+hXugbIufMuWQKzXYGgVYS9C9m8EpsM0h6Dtsda
	JsLc/gFn6ZwC/EL9xK5bi2lvZ1X7DlnjxEvP2KseD81nZ7PokCOSp2gTNWIZTRwH6CEoRwwPuS8
	cNitX9lCDCC9NjraaREbq4uJbmT4Hm0Mwr/Kz6EKPOTXEiCVShp5wz6naxhlkCP2ve9sgTe4auW
	X4q0kgIS4vpZyvQKE7ebC3+lLCQ7ZegzH9WFBisSPKRM2xAP69BH+Mv/Yu/9QKObWlTt3
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id 6a1803df08f44-91ca4b23661mr390679776d6.4.1793866434393;
        Thu, 05 Nov 2026 00:13:54 -0800 (PST)
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id 6a1803df08f44-91ca4b23661mr390679386d6.4.1793866433953;
        Thu, 05 Nov 2026 00:13:53 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e42479dsm150842066b.17.2026.11.05.00.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:13:52 -0800 (PST)
Message-ID: <50bb3200-3110-4739-8a15-173bdfb8c220@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:13:50 +0100
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
Subject: Re: [PATCH 4/6] backlight: qcom-wled: Manage teardown via devres and
 remove wled_remove()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Kiran Gunda
 <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-5-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-5-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX9JpGO8OQrYP7
 isj7j9R27q/8oZV+jTE4wumXfdXv61Yd7pKEtIv2FyvIoFlYShpdso/ZI1MNvt2HviRVbb01Ki3
 +x9f6qW8ToNPb7UhDw0eYPky3Dk71Nfb7AuF94xgIqBqZI11lfKE2+kZiaDlO3L9n7bSL5wvoa1
 BKHpVJ54Nv6RX7/3S2OVzXlA2Lr5malG5qUXf8NFlu+/oIQ0lJQK5hSplYyKhdnBS4EZyfpwB1a
 XCnSt3czPV34TPHd1IblvhULts5synuNzdmN+2VNfNV6foACeZLVASDwbQslZOuXdJnhn/H0C3g
 l2pTtdEyzF5oe7HEdczvFR7Z7z5HO6SNWEpHRHOxBgLtamKq8eP8C2gGnoWxrTBDwjvG+GJyyMn
 AuihWSuf0vjBSg3du/zkxVgJ6F5OCWyYMPhhY0E3WXtBq0bikJM/6U3EuJzpjsbVUI5Xrs3fMNU
 +6qk1yH8kJ5XWS6syPA==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aec3ac3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qHjM3Cc90Y4xjM8bFJQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: ZPoJVbeuhmF72_NZN-_19L5PJJZit89b
X-Proofpoint-GUID: ZPoJVbeuhmF72_NZN-_19L5PJJZit89b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX4AJY+9WTniRh
 ziWThX97Gq9ejQnD7BV8TpWrCqsxnJev6W2eYKWk0IzzdL/i7LS12uCuOqfaVGJWV6roukWXPWG
 YhZl61Wy0utWPnfXvBC6q33gMEzWH0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032

On 11/4/26 7:39 PM, Lee Jones wrote:
> wled_remove() currently runs before devres tears down the backlight
> device and threaded interrupts, resulting in two teardown bugs:
> 
> 1. mutex_destroy(&wled->lock) and cancel_delayed_work_sync(&wled->ovp_work)
>    execute while the backlight device registered via
>    devm_backlight_device_register() and the short interrupt requested
>    via devm_request_threaded_irq() are still active.  A concurrent sysfs
>    brightness update or short interrupt during unbind can acquire the
>    destroyed mutex and re-schedule wled->ovp_work before devres frees
>    the wled structure.
> 
> 2. disable_irq(wled->short_irq) and disable_irq(wled->ovp_irq) are
>    called unconditionally even when the optional "short" or "ovp"
>    interrupts are absent from the Device Tree (-ENXIO) or unused (0 on
>    WLED3), passing invalid IRQ numbers to disable_irq(), despite both
>    interrupts already being managed by devm_request_threaded_irq().
> 
> Initialise wled->lock with devm_mutex_init() and remove wled_remove()
> so that devres tears down the backlight device, short interrupt,
> delayed work, OVP interrupt, mutex, and driver data in reverse
> registration order.
> 
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-51cd5e35-3cae-4e4c-986b-7261263507cd
> Closes: https://sashiko.dev/#/bug/linux-44e5ed80-c35c-4786-8bf8-9ee955967d0b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
