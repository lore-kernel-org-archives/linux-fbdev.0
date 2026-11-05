Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866305;
	b=O4l17aEVSX7vBWaNmdvWNgg2jVVRv6q9l7DRoBvNMkznhinrg8vfI303NKy4CGchYBeo
	 wN2Q98NqFCw1bavE3KofY/FnhZuASkvaKgLCEHJksWwYbCMHtlRSzs4KElMl0CscelMvq
	 nf4ydwvH3eyZDts6GBWzVt410UtS/IFVQpJ2ziTSQOdeInD2GfNfGqBmg1LHXRkFJ01/w
	 QvQDg9xBXLuFcQa0EQQ6mcD3G2JhoYW21ct7pks5LrxWWMKNMCEeWwkuYNmeGppFco9IB
	 RW+40ISqFQ5WANYnk5KqWWhaHc5DCzyRWApC3rl5CLiTWZ/zNuvxJTqeT6wlo7yUyww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866305;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
	b=QEyZig3OjhvGYOy2p/tMft9AX4gdXwaqT4mmFKpW9+gq1EPwYs/2LzafbZRMPBT0PpcX
	 5V/SrRhG9JZk+6oAn2psw5jrpRfKD9oDWcn+cqgzSaQIEin03adBIYZG/X0nGnpPyd2Ht
	 9DKjxM7cb7JFi1BCt2Nnd7y9q0N7fx3sMhQUQ1DoGzQW+M+FnZeXWaP8l/1E8l66xTMYp
	 QXEEtrWF06StPj6VTEKDXxmRH0Y3rjHh6UyfS5SFng7UeYlncC2UrvcnWOMeBwp+FmmQe
	 n1pYbDmXqvN1qlaIYESly8i1h3dvdO1iUxOvyPsmU61p0X7RdG0brue5QuOqZkz+j5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8LwHb4Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJfYmTmE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE06F606A31B
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 08:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE06F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8LwHb4Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cJfYmTmE
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56Tocc3223016
	for <linux-fbdev@vger.kernel.org>; Thu, 5 Nov 2026 08:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=; b=a8LwHb4ZHdGn4MsJ
	20ov9kOlvbDvIQg0LABhso9DtRcQp9puWNQq18Ru1K6N0sJEiArvwPTGJaFrRozj
	khU8WPF049wZiIAsEJj/hAIT39GPXKalNdUrp1/EeOsaj9peDHIVkEVprYWY9drA
	l3z+XTvUcKqSsq3x8upVQPSQtbooBJta092cmY47+kBicyWl1KAOMtAxSAiW7Bl5
	PwoWNjVqm4tUPYx4yPpBf4Wlkwe6J5dEOFBf8Yy6BfF3T5W5sYlNcFvm7P6Ke2Sr
	5DvkxPkb2gVR1XA1seH38HhLXvDcReeBJq0r/hRYFWt1iTHaz/3Idcf8mNomwj8U
	SoYuZw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43h0gt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 08:11:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91e751af52bso3723916d6.2
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866303; x=1794471103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
        b=cJfYmTmEF0pCxy+r41jz/0v/qRBS587sP+w9/rlgJlfc6L3MwP5XdKeRFbZvUO/LDE
         ThdRVHeFJeaC2TkDd9r+Ws0abl6ivqFMD6vrCxvx64/YWGmXez/THI6YtUL2YXmdP3kt
         BpmVbWnYafyMWlsWuDcgxBWn2xjCehowwNEuNnQUMcuTAzXtEQTTgO5z8uNqdTj8cYko
         eIed/SYJFHHE+WParcaxxwVNUCOEXJZ7PybxOvdhwCgaQNr1SKXVJoIhgYOIPePRO++h
         tRNwmQb7dZkeAhnKqEV5dN8Xo37nxsHTkLaQwjg0M1w5yQb37lA1M8+a/hTHYKAdTb/7
         riIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866303; x=1794471103;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
        b=Zh6VAjWPa8P3v8V4Q/9Qyh17oBBQGg/RV6y3jpD3kZ63AkjBwTN3TBnOLrhKjGXMpJ
         fibPUvGkciIzouJnfvUdQQUp3w+aQ8Js2Qr0LX4EXcN/46tvXmuO/29IgE8KHPMXmNXE
         k4PfjPlpD6dlC8JD1IDNX36y7P1PuDAujhGOMvUp1azCD4ESX2XTBnFt9rTBXMpiyl4h
         Z/WJJFr29EygaTPa2p9QP53ofoafrbOpattkJYtssXc+W1ID5iNeCfJHNoKz/DN5VVCW
         21TBx8mf2hoBM0Aa+2xNYZC8m8ie7WL45p1xUALQHg/G8IFckSDByoFoakqKo0j0Iz9h
         lA0A==
X-Forwarded-Encrypted: i=1; AKwUvBzhMmvIp0IKHm2Y/bLK0w01IFhOXtUuKdVhZXTO6k9rLY9VvS4jkgn5sc0PFVYY6/ef10RrmoOyWBIAsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9i8YonmPl9yFqcBy7qIkorBqotOHVzFmz3sFKZssApEX3e4dqb
	qfKMLkBw/LODwy0pNxjZOjZ6rd1cMt/B/bTlrWFPPFWYmPEl2YXnYQWFMT4Xeh2QRtsLRG3+Nj5
	rAiqImR4EBuIJ/NiEdnIEVz+fqR4FYSlhfj7FQAy9wYlWtp7azkcJc0N2SMV0tcZcfRcl3e6/sw
	==
X-Gm-Gg: AYBFou3Mf0NYegoSFJ/OsmdlMXDPgwt/wcaYDDYpgli8jgD4iKmA+k1w4AdmBLGWY/r
	wcaRsltsdqF7SHi85Oy9IfjEOqsrVVl9SM5vWOD6LtAM7O7jCvPvIKoSsjqmLdVosLr0CO0cSFu
	lITBDkbixq5mNttPsf7YPj+QSk6VC3tJjfww1VIMz9v5S/RDUGIobtqxw6TGZUezXszTNvFpXGw
	uTakHNdt7FTIwo2r9e29zafL6wRNe4DNLKPWCibQw3cnzeU5lrSDKtAqmq6c2FQ/ekhFLQORTeL
	hs0ownuQVa9163wGHX/cJGaelDHKPyxDTQ9JZ1nixvZ21zyZUkmscPWaoupBeCPYOENM7ihBc6k
	vvfxowQmkcUgXaozmxezlQJQB+KAz3+c4sX2cuAug92Wbm5RkaFjFyYgXiYcLTt2infIf
X-Received: by 2002:a05:6214:20ac:b0:91c:7831:f4af with SMTP id 6a1803df08f44-91ca4b63f0dmr405782966d6.4.1793866303136;
        Thu, 05 Nov 2026 00:11:43 -0800 (PST)
X-Received: by 2002:a05:6214:20ac:b0:91c:7831:f4af with SMTP id 6a1803df08f44-91ca4b63f0dmr405782466d6.4.1793866302702;
        Thu, 05 Nov 2026 00:11:42 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e4a49fasm146003566b.82.2026.11.05.00.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:11:41 -0800 (PST)
Message-ID: <cd587c31-9e78-4957-aa41-53d568547654@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:11:39 +0100
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
Subject: Re: [PATCH 3/6] backlight: qcom-wled: Cancel delayed work on probe
 failure
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-4-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-4-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yj8KcB4YnkmOED7DkV3Jgmb2yxDrrdR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX3eyzrEqimjWe
 EDWAIGYNiMz4K1hGfvjuYiuKkGL6cbbOXhwCdw2YQXqfQJ7B1/oKzzrBMAf0BMXhNppfeO6Csg1
 vKMD+VY/4EM7Z8dAawGBehFk3qGQrRBbnHzaqUxfLjD+uU4KBaGOiuBkiDNE0CiA1GvfIgdlzaT
 U9U3JZZYu/aVsF2aeH8QQR+MKLkrvEwPEKU+qzIhIL1SJEITude3f+TZzthpqPG5bPhKV1oy1+E
 EPcjzutxvktVEf8HT/YfrOY6yT9NKiz/XrRFHnnJHNVquorVtf2Gtiapoxp90CptvAQ6tp0UwjF
 zolOBOtmvuEnH9DQXkOfBQKjnmIbSFTTjz17zfYmaSKqzon4tOv2/TNXAThueBmMilSZMD8Kaqm
 NBtwpp0f4vc1mo6QoVqYsKJLH+QRQK2WPii7MtHMGLxQKdt/zeVO1bOafMLLVRXH5noyl5xcAvz
 16WbD+zdfTT+9txojgg==
X-Proofpoint-GUID: yj8KcB4YnkmOED7DkV3Jgmb2yxDrrdR2
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec3a40 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bK3wT2hOXHs123jOQ6gA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX8j9glelReKOP
 P5tQhVvwnwFbFNNBTWT9dYm4S4xnbwLltNfB0T1jawsBBTAHJl8AqTxLyNzCplNDfdPdWMCWTQd
 jqhlb9esLJxpIdF92MIatLf2B8o3R8o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032

On 11/4/26 7:39 PM, Lee Jones wrote:
> If a short interrupt fires after wled_configure_short_irq() has
> registered the interrupt handler, wled_short_irq_handler() calls
> wled_module_enable(), which schedules wled->ovp_work.
> 
> If wled_probe() subsequently fails during
> devm_backlight_device_register(), devres frees the wled structure while
> wled->ovp_work remains pending, leading to a use-after-free when
> wled_ovp_work() executes.
> 
> Configure the OVP interrupt first, then initialise wled->ovp_work via
> devm_delayed_work_autocancel() before requesting the short interrupt.
> This ensures that on teardown devres frees the short interrupt first,
> cancels any pending wled->ovp_work while wled->ovp_irq is still valid,
> and finally frees the OVP interrupt and wled structure.
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-ca2e48a2-f511-44b8-a7d4-866f360bf107
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
