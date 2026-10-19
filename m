Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8F49BB65
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406949; cv=none; b=tVw8NDbuG+tXgSQlvQm+/3mBEB3oS+IhRNfNr3mypSP0JOSyPccxrLq8+B4RTLxqBVRfOf+eydtQIMvZw2TO6VXKR1zruMthb59PGzSTQbqxnr9FfEU3S1IrtfvpaYqJeNQNGTjQZaBOgiGemLC1dy4OK45L5ndoztV0rsQajCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406949; c=relaxed/simple;
	bh=7CJ1vwF/ABQg3/G0LKwIOetPBmMUxmnh4sqqhvOCoFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB1/wllhnDvoInyM7jHO80njaSIqp9XKXhtLdINYQsji//RUEv42UA5iCOrATu4rc7OfrpI9Z02iTxuiDh7E7+39Aeomfeev2ItnSuLT7rlaSW5foILrq9PjuxmNNFYHL07CQhK470d05K8oe4hS44+2zW/xtyAgKaOeqi+6+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5dBz8xo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2wsDMJB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5dBz8xo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2wsDMJB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P22l3306589
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 10:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mT9pGEhM9TkqrI8yQKVArxrG
	5zf0RJAxHkhCNo1DWs4=; b=P5dBz8xoR8WUxR52X9YxaQYtq++PKHRxlqwDK2Dy
	3vsR48sPuO1nAfhnx4qSWDNzmYyZU6diBohgUqxRgJjm6CcclvKyJinHGswJkFx3
	uKwgSve1CyXmCrRKrmH41ur9AJG7f5b0vIpvpXFE52uOU0VnbA8vchXkbust52kD
	OWpqrYBUUDhQKo9GrZa3XVMgrfskbRBiBpTYf/+HgoYdpf9WA4P9yQnoA/QPY6Yx
	GJchCZT9cVREOxiVxq12Rqdbrx36H2O149PnM7arxVJ+LsMnwYPx+WcT2/+Hz2HI
	xgMC9Re/CC95q4CwDraDyOkevfl6RMbnBs9ZKxWgMl2/VQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47gp9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 10:48:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ca9b53afaso700246485a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792406936; x=1793011736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mT9pGEhM9TkqrI8yQKVArxrG5zf0RJAxHkhCNo1DWs4=;
        b=K2wsDMJBcfBiLqIAlNMI3eQwO29GQe1FqqS0uR5x0Yo05Mv4JgJT9fRUlzNMGDsTrt
         IKWohp5BtZQ2kKWjB6fMNgblIFJCEDG5GGN2ZCJh6T4D4aZqw7FCsUF66lpcv2lALc66
         dFwglSyx1HjbDnlMyuCuHWLd4XPhIudjlK+nWFBB0wzPb2ogFce6AIOs0hLiSOUzTfyS
         +ngjhoTLNt4CfEY6j91FYv5wtb0eadMWVEYnGPhlyWtoG9JUa2q2cvIeEoJdTHlAkBDq
         8BkIoXDqF6mf1NlDMsCzHkqNEGbtAesQOP8ZSqP3Gmf6CqBNa1cwvl74v0rzL0GD9nhK
         p3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792406936; x=1793011736;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mT9pGEhM9TkqrI8yQKVArxrG5zf0RJAxHkhCNo1DWs4=;
        b=Eo7nUjlN/NbQDk5cIN4ufYlJcj35o8BAMI83ELtDBNl82QUod2ADfWpY9g/Njy+9fK
         kEkwxYbPAPxFBzDs17VLwY/hKzbGYRxHarHC29j8Q/N0uhzcRHIpYD5F4R76uz5fs36g
         0ZEqcdyldhLdJdtTG4WDUa+CFMkm3jqgANsui03bpCjRSZ7lsDePs7qC7TeXDJHiH5Ym
         mEuYfH6h0uZrmhr1V+Fb73fZ1xhusqoCi5L5PzgWtuJle/CgbqaXdh5TqsL0C4U4FmBE
         p+GxQVDDto1vfKalsz0PmcvbSst5KfzQC6pfh+LVkb9YwrpmxdhaVNjrwcfJ48qIDzPA
         xHMw==
X-Forwarded-Encrypted: i=1; AKwUvBwkW18PkWllhmgd7PdvVweXbB96j56wpoYqapfLxFqYZrGYcaR7FODNpu976nwqvQ1yEc/4d4JpfK09AQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLF0UcxWeju/l4s3/zPBf049ogOm5t8R4K9ZeCQ4JLrNITW3Bu1
	OV3rzJUWi/Q7QmvV4irrgcOWLgcOY/TLkL/eI4Hd/zvtjoo77w0cd2ZCgTCNvEpAZ2OcKs5TNeF
	E1n//kzqUd4JQX5ttCthu/3rIhIw4F5cPn9iCFSWUpJ56esoicYOsj+9D7nUO9/i6XA==
X-Gm-Gg: AYBFou2dWyQpkJ4KNkuA0VtBTYx5YIBr4Thh6OA64SKlmGLqpYcnXLZi2YEl1HExhG2
	T/eoWg3W8Spr0ymQr+6Ddm/Ql6dtUuD3K4pu1ODAfokf5tSUJEBSXJqIMKQ7GSju75u/PrFYgtz
	rqWPEy1m/GQPvSs/XiheSwPYB5LmveLnzmufxEwYrJLESrKIaB2ZQcXt4ezCi8tJ471dwaBP+Lo
	RNn9kYa5bF9LpVET+GtFV396VfamG3ZZYkRzGG+YYleSy6DYYfbDG9UNjxoyYmoZLHMuaU/ZM6M
	J9NTZdncrbY6xsinO1wkMxek6wUAB97vjbR22QIEnOpy3zhPughYUqouSqMF54P3e+Jp60cG3cw
	B35M5Yn26zlFrYeIwv+/CabDLGOgQDM9THzinBYJjWPV7GA041GtYrueh96tiGHXrr7izSlDVn9
	Of+Q1Kqwoj4UIO
X-Received: by 2002:a05:620a:2609:b0:93f:2938:48ba with SMTP id af79cd13be357-93f29d9616dmr1189023385a.55.1792406935884;
        Mon, 19 Oct 2026 03:48:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2609:b0:93f:2938:48ba with SMTP id af79cd13be357-93f29d9616dmr1189020585a.55.1792406935510;
        Mon, 19 Oct 2026 03:48:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a434a7esm1888152e87.37.2026.10.19.03.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:48:54 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:48:52 +0300
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
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
Message-ID: <cteiu5owhinqz53oxcfywioew3kh62c2jbcej2etobfx7awabp@regtmdoqc34b>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
 <ddbb547a-f59f-4ad2-8c99-4436bdae84c7@oss.qualcomm.com>
 <36e8a372-3a4b-4466-831a-2445313dae51@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e8a372-3a4b-4466-831a-2445313dae51@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ERMrTDz4Iy08_AB05YeT3ar1Iw0Dfzco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX3E4M766z4ZZ1
 LNWrLe7FlgLwyrTL2ugCQiY3aZiWx7Ncmtf/uRlR/ecKqpTtsaPEnz2rOCT8GbUpSKeg4sQ2YKL
 8AzBO1ERVZpeJaIda4lsXhj8siJ11sxJJGcL+15M35dxMIDZZWBjGOh+qVmSkAoE4BSp38cdBS0
 g7PA9QPFTVQNSulNuhYOBlUaH/cAgx9yIqikCm/SMIcDl1I4vxA3tcT1G5z19i9Q7aCupYVRKge
 YYoIoKvxcmyZCjA/vBkFNfCCORD9sQ6PoyM1C5Do7OkobvzgooeV06SLM243/ypKkqPIVHfRy27
 3NPz5KcuJzp+ibFVSgZLJpeDaNXm3Qt52nkG2qBX2+rnry2btP0Mfz9NelmlPNtNN8P/aJSl8VN
 A4Txs9O5HM2PsbtBxsl8c0k8Thzy7L7yVn7ooWafr+/XbCLg633d9+Sv/Ko4lomqr1+4QSXzsJh
 9xpxcT0Xx5iARqPJCjg==
X-Proofpoint-GUID: ERMrTDz4Iy08_AB05YeT3ar1Iw0Dfzco
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX3mRbwcwWAM9a
 O67CVnHADDbnveOxd0mNDlfzVgaV0tJ5b264/aojNuAJVfGd+48cZuDu3Rh8J0NJ50evr64tvcO
 v+1ZDdUX4LvFz5qULiTdUOTNYC5l/+A=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad5f598 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ciNfSeS1p6VPI-OA_NsA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190042

On Thu, Oct 15, 2026 at 11:11:08AM +0200, Konrad Dybcio wrote:
> On 10/15/26 11:10 AM, Konrad Dybcio wrote:
> > On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> >> The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
> >> the wrong address the mux driver fails to probe, the Type-C controller
> >> and the DisplayPort controller keep waiting for it and the display
> >> subsystem never binds.
> >>
> >> Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
> >> Assisted-by: LLM
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> ---
> > 
> > Hm, there's an ADDR pin on the FSA. I wonder if the previous guy had
> > an earlier revision of the board which routed that differently or
> > something.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> oh wait.. the previous guy (author of the Fixes commit is you.. :D

Yes...

-- 
With best wishes
Dmitry
