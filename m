Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866498;
	b=hcYuwcgwC+nokR+q8GiWvCMs+xKGk5GXYpgJ+j7sruGH3aAoaIVSXnUuStbLwNwtWvnl
	 rkpXKjDGDfOqEz9JX0Z28vir5dkLe8c8lJh/BOQPonbkAkqALdNHnYEILOGf/6CPvm636
	 8KnhgcZGN52M4rQm55w2ivjKD7gmupkCSvSKECZZP9ynAAbXZ2B8xFIUV/vawg6IZ0Uq/
	 YODZqXHcRJpSBaQ8NAqkmCCs6AIQeNEFIhZDHx4kYwVXe8KUC8oBcqLN9pTHDh9aKLs7f
	 O1YF7+hwavdimW6hkUXao+vHefnx8TxWsPBdWCFOWQmTt6OWjDV5BpUMZBqJHwFBWVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866498;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
	b=VDR6/mDIuvQJSDFSGT2IiQdGAkpL0fY3Yj8AUZs/WQyfAkq1mLtFCu/jj9ICTQOAWKM3
	 9SYx5gTlv4N3QQSJkcNUvnG5ehnUSoZ61i1vBY96OYctM3IDymXJKuTyv4To+NJmqMCaB
	 LOvo0+1/EjphGK6zQWhGNSHwgHlyy4Dy6WsE4sUswis+ewT7BUDhg2VNryOv1x4qMrOKA
	 hCOkutKIVqUTfbjJkFDeICpwIL/OCx1his73ZaCbx7ia+oVmG1+c+EsmICOHzhmJLBnhZ
	 ujBIaoZvNSW9NqQhusYiB1FrYA7mTPckJTeEinKqYDPlyWQzs2g30aNeaccmcKaA3KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j77L8QPK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R1FBryIY;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD6606A32E
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 08:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDD6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j77L8QPK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R1FBryIY
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UKYV1018041
	for <linux-fbdev@vger.kernel.org>; Thu, 5 Nov 2026 08:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=; b=j77L8QPKWZBQ+jZ1
	K8Btva8ICOlPOodpHLv4RKpgwyePhZRn+zZizN9rDvlunq533kw5NK+baUNrpaTw
	XK2xXF/FJfDqIS/uHxgblKfJQyKenikPMofnghGau4ED6zfHd+w1vLAlbZPA+tpn
	KVQiLJAyrsnOZaqh5jfgjxAW8pRJ60UcAnuBnAaIeDiyynLO4/VT4aGSxQxZ2hRU
	8KGehbPJU8lnW6XuOKmsmknMr/eq2BdVUbsvCuEuFBCMy8pPw+J3TnnO5uEcIV8o
	pp+v5LicooMtD5U3luCR06m7sdbaur9psqVgs0Vdhd6OiTt45gaFSZbeqVPB3rcx
	PbkHvg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bnm053-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 08:14:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c8f9f6b49so3880716d6.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 00:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866497; x=1794471297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
        b=R1FBryIYs0ICPItE8MiJatJT92Zw0SuQATdhTmE0LbBphFdwCBSue1twZIev6yKyLL
         AW+uQMleTJHTo2n0DdEk1UIftx07tR5Fm73ORe4Bdob9nD+fGUfjX9QZRSZlHoURa4D6
         ZzhoeyHlKnRq8KxbFgYCsrssI4hMQyt0Ie3hzdCehyAcSDexBTReEhZxUTECXnNz4okL
         1cYZXNxxH5F5b3CFx/AMQn3coaaS5YJHjLD0K2Zl+wP900M41vJ2C9CagforW927K2ZN
         d7JTcWazVyicV/nDGdXEeVcvxGfdnuPlE0mpi5LhhSKmeNfRkdsVitkHLbKAocBrQe/m
         oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866497; x=1794471297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
        b=RamSuSxIG63qpBNNd8DbM1jeq4LQmt8ROCktqbnzhiHpZ4HpJdXzJ/zPEF2mDAZkUn
         osc1Qdot/RTdg+509XlZ0RCu8VI2dDVhYJ0pIS+GG2ljZnc929yQM7B5fUghokz6OSJ+
         UX0jpKWrgil3kOtcVuVNBYs91tfLP07gX7mIxv1nAN9FsalwpoDdF+p/z1JqkGXY5zFx
         ndiZ66YDlmWgg5tymwYUnyAXbJJz65XVuk7760mLLoio51K2tMTzwv364jhhn3/lxGUx
         Pk8S1VMzbgbz2J72wy4pK+M96kvSQeSD/A9o5REa9FrzqmkCJ/umag6O56kHTskwUEsZ
         OfLw==
X-Forwarded-Encrypted: i=1; AKwUvBwhy1LNanxjfSWyf7G0wh/sf6PDRQOB+YOr5R0QeaUEI+rkx0uxrekNUwbOHj8X2zSJhdyS7IDT6wO1oA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ijE/x4zAS6xsjq0T9Bbmb9V67NsENkIZb+pmZT7kWlKvvJ7fQ
	izuInySqkxn7JPHmEGmaXtbWD0EvbgxhAb9G4e+BGSRtHENJ77106JcfJN591jqHgQoJFZVuaoZ
	BnxXfIiBOze58PpwDXYl18MUwY9YCmc2XW9HcOzhAmVZ7egCiJU3IqwZpz1tluGt57Q==
X-Gm-Gg: AYBFou15ku+kW98Wa4rqys5mnVdyVy2pGFTWP49dYoq7sbomjCFGU1mYA2MiuAn9cX7
	/yC5AVFWYOeO83MOtH/WKT7JPEwZx35lN6qTwQx4zlMnXww+2UX5AI17crQq9vfjcZr+kHukFm1
	5FyUjNLXS7zI1+UuHxWTVcNSrVlgw9+kU0HELolzzXCXoTtx6CGtQbPU+d8pIBQCn7LX3RwK3e0
	VDNGueh7hBUJAbZIs0SauW0IdzISlLNgTruE/49Grho16h51tO1lyNrY+doobH3C1VYmFA6oL6o
	7a80mSphWJBWuFJNq1nYGhnKpxMhKm4mFjX0vq/BCC9g0lWfw7JcNKbJzJTLNM1CdDdOrhAfkca
	pZkaeqyaz/gDvDu/KM9k5vxvhegm3rXdpOcrwi8cpkHx25cSpC2O4pAyAb5m3ovDxrMy+
X-Received: by 2002:a05:6214:5913:b0:91e:94a2:f994 with SMTP id 6a1803df08f44-91e94a312bemr42644946d6.1.1793866496546;
        Thu, 05 Nov 2026 00:14:56 -0800 (PST)
X-Received: by 2002:a05:6214:5913:b0:91e:94a2:f994 with SMTP id 6a1803df08f44-91e94a312bemr42644466d6.1.1793866495886;
        Thu, 05 Nov 2026 00:14:55 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e44650bsm149681966b.43.2026.11.05.00.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:14:54 -0800 (PST)
Message-ID: <54b22ec7-f763-4f89-a711-c6c6796550cf@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:14:52 +0100
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
Subject: Re: [PATCH 5/6] backlight: qcom-wled: Check for auto-detection
 callback in wled_ovp_irq_handler()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-6-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-6-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX5Jj3qBF5Lh9b
 dIFDScc5pVf2HmhdgZnG6f6qzUc46el/ld3OoknqaFunRtGPzRYxUDPQ1QPa3Si+xlpDfFZ5trl
 Wxnm9y883YE8B2JJqyfu+9YAbVRn1NRH1y/EFVeVgZGRZJ7Fln0PW7zqudH9BZE4TJb3qyNf7dE
 5b20UlLD+/8NBKp704yxkjDNRX44QuVI1aqJ7EEBgvAaATzpeuuRUNOmlzju0gNtl0BIIDPJwDc
 MAwpslzEzx6X6/VfJshYL8/DLFTsKnTjeuTJpFt0dSPJIX6Zj3yVTk+6OP5TY9fzGlldJGnZKim
 /zqN3IIzMNQVoLnXGlDoLDncjmToBoMmvSb52msVNdWlsxtPyF6nn66U/2FZAuxCBPn3z3u7luN
 srBAA43rRMmycGv2zY+Uzs5s5CQyye66+rdJR7VocQ8yjHk038n+DxMA5GjMH3yLvx4oiNVb2S8
 jLatqXkLKp64kGUisJw==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aec3b01 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EwSOXpY8fmkhG1aJMgAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: _drYYNHdxJcV6cxxo9mRzIfsvheyzASw
X-Proofpoint-GUID: _drYYNHdxJcV6cxxo9mRzIfsvheyzASw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX5Ovns64avRHw
 cx4JCXDBFrP9x1cblQOIOhvw5Zqww7F9uA65g/8oR4P0+bPFUv37doHlG1XL4789m/ZoHXFapz9
 RkvWs8kjlL5dVdnqGKhwv8TLPm6d2cg=
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
> The wled_auto_detection_required callback is only populated for WLED4
> and WLED5 hardware, remaining NULL on WLED3 (where automatic string
> detection is not supported).
> 
> However, wled_configure_ovp_irq() still registers wled_ovp_irq_handler()
> on WLED3 when an "ovp" interrupt is present in the Device Tree.  If an
> OVP fault interrupt fires on WLED3, wled_ovp_irq_handler()
> unconditionally invokes wled->wled_auto_detection_required(), causing a
> NULL pointer dereference.
> 
> Verify that wled->wled_auto_detection_required is non-NULL before
> invoking it in wled_ovp_irq_handler().
> 
> Fixes: f16899a6a7d4 ("backlight: qcom-wled: Add callback functions")
> Closes: https://sashiko.dev/#/bug/linux-d3eba287-2af9-43fb-851f-78ab3df0f35b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
