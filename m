Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD64E06E3
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410452; cv=none; b=SbyLnxIbe0Hj0cn4bGD0HtxmiilVp5Of3N+MdzPW2cEh+wAXr2oc2/TWLfSoTPgUoMVfyu3R9xgVAnm5S0/qXTOZ4fTRr8oSeSPsT89nFIr4WIJiSgZO4U1XTxH301wheF2CrYJ9+psax9h+rqyfHnYcRFLS5pXiZS9YV8ErAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410452; c=relaxed/simple;
	bh=gOZDEHU3naOYoLL7egqr62uzt91zc5Wleb/4QbrTMNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7JyubdcmsRHYcPdGJdS34edMvVdN4NFa7O6kP//kOHVXAkvSuG7NqS29H9mnvsP11+UNMHlVA+P2NT+MgU9nhAnzuWSXm8rPqEwMo+7CdxrFfdQ1wr8rYmDrlX16KSANzb3WfzZGv6NlVmhKlRjojjCPzHE0Jxqm/DqVG6j/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fds1VCWq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d9QUHdS9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fds1VCWq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d9QUHdS9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OrqT1665586
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mSnBA2Qem/ruoTNLx5exIMDknp1eEWtUaIxZflIr15I=; b=fds1VCWq9ZZiUZoA
	34xGZhm7jCAyiKBN4O9xLOvroe9NE+XfBXSaQtlVn7+U+h7ZGkyDxPR0W4CwTlL0
	7BrYcJ5xwrb//skXLb+ynXhly30joO1fh8LdGd3TFO2hpX4ycpFsROyN6zrJeXd+
	fzpiusdg+iBzjJSk3sLr1IC5Rpcde21f31a5AOG5ahhHvqp529wlY/EdXgbGRAnw
	u4BOdKijcEEbpWBwXsy48L2JCPitLnBA5ZQmfT/jjEWy2yYN9n0e2z0R+SgQCvsR
	z4i8/3t73LZ3NCx9tBEwCD012L29DaHnbCZ1UkNOhkxAi38fIe/uJymYzdjiZKtD
	5FoL6w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0w83-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ea6b66e53so35281785a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792410449; x=1793015249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSnBA2Qem/ruoTNLx5exIMDknp1eEWtUaIxZflIr15I=;
        b=d9QUHdS9aAz2A6D/9MHj7uEDndMVrQujcJHaL/0tUkbyjILUWsPVDVWUIeBG6bhEU6
         iPR9T2fdcFITQzXLafuiHOWEYgf9ZlQtlNkLGadi57zf0UBH4y4bI0twFY6c/G6UAmjH
         N2WMH6rEqLIuFw71Wq76sAqVD4WmOyNXWJbIdLtrNtDkQLGxMLiksz4ATk42+v8TM/0Y
         JUCi2yd1e2IfGqR6O+DC8U7weX3tBwXlHAIMa2fPnGn3uvgAd/au2ymztkkvhaMGr2vK
         6yKQWJr6G5MGl7gOzZzpfYZwhIp+c2UQg0fQt8VU/5H7Rh2K8JaklwYpUv8L+SRXKXQm
         5jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410449; x=1793015249;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSnBA2Qem/ruoTNLx5exIMDknp1eEWtUaIxZflIr15I=;
        b=s+sobR1G66DOCckmJPYWcYLr6jhZIWh/tHrEgq2o2Ba0sur6Fyj49oku2GkhoJinIa
         /znm1YbLJR5a57NpcKcoJsAEEnmhErGzMnndtVaEwqEOmBcWH1ISSZpe3ug9R4UV0VIl
         emhi73xB6fY8XFPuQqDJsT4tT8Lq6ODEFkdzVtgyAylp4CYTswO2W7TFhMFlaxLjGTRd
         DO+1cJ93U523SozyO2KLtK4hTN1JNB0J2zNghmjMowpMg+55dBOn9GWBXhrzpJKwLoiu
         mgLmvhPUtRmMpLi+6Qsr7Hjhz/NNjv869dQyxiDOOwJ1oCqD/kb90KervUjF8H90BPiL
         T0gg==
X-Forwarded-Encrypted: i=1; AKwUvBxjw4PeqERMNJ4nonJX5NSzRugBTUGclKk8b3cn5fDeZQNSJWS2qmKlKHKsMnBcbah9F4EQga3K9d0ghg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ5CaX/7/DIs3r1N9CTfbes3KSKxxqkiParHTivtKnA8Idzg00
	Sx4eiLwf8796DTCYXuYaOHtm3/oW0wHw5bJrRM3+D2petQG1kWl3B5fs40P40WfZNLnvA8gGo8H
	ibATWpr9ZgM8YZh+YCChxg8A6F3c3XbfL+SvgIhDQM+8cvQTkGB3L1YkCFTJusW1vPQ==
X-Gm-Gg: AYBFou0puWepnWpKo+xsmTcaFfYeubhhphzxXTdCWp6kbBikoESTjGKPrcHx+POSsiA
	fORBVFIb+oy4OLEYGv0058hvH9CFtq3jMYWkWpCALW3jOH0/w2+qwCJZMQFk128nRIKFJ/14z0D
	ftHHCqBZouORp0A7WQTy8yKok3w1G46Wrvr068jJQczli6a7J2U1e+aaM5YiA0cupWdlFCdB9xD
	2PvyzPZ/9yZSz6NpiQtsOm9zlCtlz54NiUYOkvWhpCTB/aXu/OiCmclNdYwSqZrJBhXID/Cs+wV
	rJnAf02RId7V15SMjubam8JcyHOsLHzsX5+ql3s4G0n5ld6ukkKeqKp7zR5yEPfC/3uLovEnEoV
	kaNdTByZfZCaKcvw8bzlFXg==
X-Received: by 2002:a05:620a:701c:b0:939:8148:1e3d with SMTP id af79cd13be357-93f29bbec19mr1384649085a.2.1792410449160;
        Mon, 19 Oct 2026 04:47:29 -0700 (PDT)
X-Received: by 2002:a05:620a:701c:b0:939:8148:1e3d with SMTP id af79cd13be357-93f29bbec19mr1384644385a.2.1792410448717;
        Mon, 19 Oct 2026 04:47:28 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919bde60sm338607366b.60.2026.10.19.04.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 04:47:27 -0700 (PDT)
Message-ID: <fda445f3-8d61-42e4-bc49-c4d5715254cf@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8150-hdk: add display card
 overlay
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
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX7EmGWgnwhqB7
 ++cBpJFsHXxvdweaWnPzTsLbUryXz6UZXekTTS5G0eO11pjdrJ0rczHbsqT3Vg9xawQysQpFtDC
 Ag+8FuuiWCfm/dtzJHmY8SEsWSf3efo=
X-Proofpoint-ORIG-GUID: EUZ0NyAUSLuWM-GI_HTBan4YUtGB_iAf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX+zLyxZZcFZ5G
 pw/+5WSc+TgCKv+nXJf6AaqsbU8e+eUFOiEYDO1Aw1T1SRbgh+iLNB+w9xs0uEdurfJFSH9M8Dv
 5IbiCRpsICFY8QcquKDUajny7r+DCoEuX4UMPfhRbzK3TQKUmBErMJdtMcLKpGrZRAh6TvvYk3e
 z8fn3azb+B/vSXT/j3+5wqXYZjcRl6suistZCVrMwQ4hlj6Nnq5w9AddvMmfc02LPvj1wYMXpe1
 thU7FptOsD4Aex7u2hEboEMAmCgvs2cmVjGgqEAirTUJKB6of4uEUf6QqkAbxMVKj09nhgdLwD9
 gTa6GMrmDnQuhnQoFMb/sBKmWdR/9zY8U1I49vKqvX88MOmjY1XvY+Yt8fAOOxFSONhsdycLt64
 5lzTxnQvwQUttJNOk6iFeA5A+a9H69TAa9h5J2kjFWqSeo239DUDSNReXSyXRbbTbwM5XP3dJgq
 lNkLqklKJJeE9w3wHpA==
X-Proofpoint-GUID: EUZ0NyAUSLuWM-GI_HTBan4YUtGB_iAf
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad60352 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=oyhz4BWCyAMKXFkMYugA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190046

On 10/19/26 1:25 PM, Dmitry Baryshkov wrote:
> The SM8150 HDK can be fitted with a display card carrying a Truly
> NT36850 WQHD dual-DSI panel. It uses the PM8150L WLED for the backlight
> and LCDB for the bias rails, and it is mutually exclusive with the
> on-board LT9611 HDMI bridge.
> 
> Only two of the three WLED strings are connected on the card: the
> backlight stays dark and the boost runs into the overvoltage limit if
> only the third string is driven.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
