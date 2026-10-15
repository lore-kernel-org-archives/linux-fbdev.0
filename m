Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1564D09EC
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057503; cv=none; b=CjiKoy1OtPAYVE03CQVrnnS0lTwiRK6i+HdkEabt0/IW2BQZMnRPhk+F+5fBhProugQZDlSNBvx7lHtAczr0Hk58UyARJDslcIG4MRVOM5RnuHgbWYPJkrcSolnUgntZ3jeWnJZvhE9lgzlHQ6+uG2xIahBFn0tzF1svX72wh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057503; c=relaxed/simple;
	bh=qtRguwZ4mlDCaVkmB0miTkMjt/Pa0fU+Vx0oFLYuu7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCWRJY1B9oodqzlXJ7uZ6Rz2n1PhUhoUlonRgQtdmmU0OYuLsB2Q2YYuVqDpEZ2GVLvf2nByBn/wXMkp3po6PRRgBCzl8tfRSnoywUAI01pZBFOSvJsIM3i/eO6wcytvnbRhK2J7ax+MneeYOgdRc6bsULpTMA1DAGPAY+KG7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gMpA6lx+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QHcsm1YC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMpA6lx+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QHcsm1YC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F6pBF42121583
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h+FgW93lIZWkl4JuJ0zk+Xr8
	VIgEcu5OQYc43p0CbhE=; b=gMpA6lx+13WJeyGV6JAdEeHHZRlhyfCnTSgbygGy
	E7mWXkhSxHSeaC5OS6wjiSmN2WJcUNy0Whi9dRNs92KmXQyuvpNFFlnBaK74ToLu
	6mZfMZ1scobI7uOLGI0hOkrJKxUGFUyMyGlbZk3B5lSwPr537MDbPxJAZjZah18y
	xYv8QJWXuIUZZaAnaDid8GGVoVERbXGF2e2iD2lukpEmJwleqBS6Sp0Vm1kEgS+G
	BSdxXIzlM6NWRLuJKfmTDCA2nAYCBXuMeALqVw2bMVcrbP30drh8WYqOoiLW37k8
	3eueEP/a0HH4PW1Ohmekrd4Wm3+4k9RRgQiX8BjeYGHY5Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn23kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 09:45:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so379743285a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792057500; x=1792662300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h+FgW93lIZWkl4JuJ0zk+Xr8VIgEcu5OQYc43p0CbhE=;
        b=QHcsm1YCZQB6xOlWFQcIhF8l04L2fCtFA8g3aetCvvkQaRzpcHwTo6IFbmKb5SqMJ6
         eWN52FdxVdkAycgmhK4/dODtVuGEb7MfDVdF7lXSFdGslgE1TxuSn4FjiEdabVgDonIc
         HjWlqigyavcePBWtYN9TZyxygbDj3q2/thg+2W1FxQgVBC346uKwm1pWMDs1F4ZgafQ/
         rwUB9+Ag6MmyD+E6P/wzLUFYj+8R6jKMRz5NO6L+cJsOUtjbIvq8sQdudoczSAmkAl1D
         7AgY6g8C6IKPi4RUJ+8t0p1BE8sPL5mdTaVL46y3II1h+wPiaJhXcpzxK6o3LDzDRXsU
         geRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057500; x=1792662300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+FgW93lIZWkl4JuJ0zk+Xr8VIgEcu5OQYc43p0CbhE=;
        b=pxkVAMikthe2UmZgmtcnLqs0hsJDKfaCqrpywgLV8ISv+Ip+I4F1++MtsIQ+EGaHP6
         JLB4wKH+BkYEEIRkooCbmU2g/NkLYa9mBV42pkUtgZ7lT37zlZtgnczmUTIdhErUxvcn
         rg5tBbFMIkWr3MFXSXj/4Qah/CBQgiTfKFb9cw2umJuSBTb9HXCm4/mgeXVQWcEIudfc
         pQ6f5YNlSO4bcjre0D9lCGPrOPO3PKAhjW5Z0NWuG6+PT6xEpr2JbRp7mebmBdJ43aD5
         j5Tk8TdYOdvLZdaAJ61cfcrX8sfXqjQuGmsJhm9YaUEaHQ9ursI0dXp36vUfiW27h4OJ
         ZKQg==
X-Forwarded-Encrypted: i=1; AKwUvBzis6w+af+GKu+ocv7lGSoxJgbgzg2jy7BJQX+LR9g3fDmpaeYGb9/OXEnLcmdSU9ipbXAynv/8CC+IkA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIoKiysvBVoYfspS+5LIbGPxU/D+qYQ2+JyuNSyLYv0Hf2wp4na
	c/kX6txxUSqR5+30WIiNcu2jja0kugySg7vvb61Zt2DQobWS2INja8a7BktLM/CSR6eTPB943kt
	G1Z3sHrQDKwg/+gtI3RSnrEHS1huADNeQfblEEgYB6OMW/nz90BE7lFSF5A2gU6TVuw==
X-Gm-Gg: AYBFou12wZhJUJLKZTJwljgGcjGsRe1p3RSdx145ynWcbrKIWAoXuagZZF/wFsGVduW
	VuiqOa3T3HSXhsFEh/1UlTvC/N2v67Lgw6Ew5mbmjyEirDLrVdEqpVvhTQVakugIP5z5dDX3Og/
	hklAk/kKtITr3+moXFQgYmYzgB2yfc707+51lffHWS4fYg/2td9tuODCSJzhcNt0SizpFXQRRUm
	tj7dDPbPklHb/F8+ywCJkj1ZhUdAYWxCByKwKxIEBfw/qNNYiVYEcbpKbITQJxjSAcR+435T5ly
	qWLHH0jK/VRzpqrEzmMsFL6ILpaqZMjvShnmHAtsO7DJuhIUqqTJU2H6YcwDKBw7R3hiugOU+Hf
	pO7GY2AgMG+lPUD82noYjpJ7qRsK1Mw5EpHAjbbsWaV/qnKxHFlL+ih1eitUbxF95T7B/TpQQst
	RIYxTALR+feIHB
X-Received: by 2002:a05:620a:4613:b0:93c:ab5e:2314 with SMTP id af79cd13be357-93eb95e3828mr2851432085a.7.1792057500181;
        Thu, 15 Oct 2026 02:45:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:93c:ab5e:2314 with SMTP id af79cd13be357-93eb95e3828mr2851429185a.7.1792057499630;
        Thu, 15 Oct 2026 02:44:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab1169d43fsm796131fa.23.2026.10.15.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:44:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:44:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH 1/9] backlight: qcom-wled: fix unbalanced OVP interrupt
 enable
Message-ID: <6x7y43ldn6kjxowm562icamjaajnxlgarzbelqg4wkgvf5vbbo@x4t3mu6f44wr>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-1-5c14928cef29@oss.qualcomm.com>
 <eda50ac2-bd4d-4151-b041-7f9fd56d9fe3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda50ac2-bd4d-4151-b041-7f9fd56d9fe3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfX4yKtp4Aszrm3
 E8Y1OBATrDtz3b2zm+67ZUtqmCEnpLdl3+cCHDLMT8itStKjHjvJLBuF3JEGvB0x0Yy9t5XUfAw
 9wdwEahzhAqqWwvdDODea3mmYUQz1eVroYGHKRU/O1iQPZzsmSsCq1I4JQF/vsPpIPtAlo/6LDB
 g3FT2LDtYVD5tusY/n1RIce4FocLZQJCZRQMR9UcPkKi2Y/MueATCkQP/TNQCO2/7StWVcGXZfX
 kxvPkQIku4PDytBAtjx0GlNZmH5LmtTENOgba1hShJY9zizRAL0q7jyEjB30hBih9KIbN+zCwxw
 owpDHIdMtUh6E0h2WoqSHS/cAneEn+u/0gRZInZpAYmQ8hsHrTib1w3/rbEakH5F3tVNc5fpUz8
 XjZ9ewgRL08grobBIEAX4EdvRtZP6IVa1RtZFdFzAATpUvL42VHXZYMbq/PM9hHLSP0SPgI4TcM
 6fYjm+P6X6YDUsMd/4w==
X-Proofpoint-GUID: hEUoDbGLgAtaTh_Gux72X9CmpEx4tCfG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOCBTYWx0ZWRfX0VL2yvorAP5G
 ONzM6QEyM0kIU0/W1FE/HkQfRbbhBscur2B97Uo8bZzUybVVgfCDtrOJf1rvlJ18O9dE4B2K4sR
 05GDwc7v+1lHlV5pnuTdL01GxFGQ6jc=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad0a09c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=DzZZqAc8IDjE5QScHtAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: hEUoDbGLgAtaTh_Gux72X9CmpEx4tCfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150038

On Thu, Oct 15, 2026 at 11:11:58AM +0200, Konrad Dybcio wrote:
> On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> > If the bootloader leaves the WLED module enabled, the OVP interrupt is
> > left enabled at probe time. The first brightness update then schedules
> > wled_ovp_work(), which enables the interrupt for a second time and
> > triggers the "Unbalanced enable for IRQ" warning.
> > 
> > Track whether the driver has disabled the interrupt and only enable it
> > back in that case.
> > 
> > Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> This was merged yesterday:
> 
> https://lore.kernel.org/lkml/20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz/

Nice!

-- 
With best wishes
Dmitry
