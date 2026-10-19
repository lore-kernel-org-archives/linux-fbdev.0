Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2784DA9BF
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410480; cv=none; b=g1rT2PNckNq69ro2lSVLyRiGvNdrmqh2Ji/u/lpzLQWX7MD29xz2Gmi4EZaHU1Ihz8H8vJ7yyzg4MgHEIMCcW8chtPuTAjLYPyvOT9hdqPGB+WYjkjKuGLfwrYHR1C76YgJDpSnw7p79kCjWoVew2lO3aButu+Zowag2Xive63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410480; c=relaxed/simple;
	bh=ms7BSnd3FiMoukV9tW0CfbTy8rz5XbhFMM302rjGkho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5IkgJ3linQSzCboVZg4nyPEMDh+drqWIaWfjP4oD+Se1/t1ovUZqJyr18USTfgCbrTxYbb6F6ccHwUI2SoLBoELmZhHYFNeNQW8YYXzCXTWKcBJsQhFHJR9uupUTLdj1ZPYh0QT/sK3UFwuhVrF0kgnoJcn/n+vIfY8Y5F4kqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W37H1eAG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FCkwKrzp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W37H1eAG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FCkwKrzp"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Oxke1168075
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6Fg2JmWjJmbabOk9C0BRHqS/
	QtSPnqgEVZrkMmJYDlQ=; b=W37H1eAGqJuNpHajgHfNvWiBmHRMonKvZ+Har/aL
	XREv3Dz90mOkK1LB21+Y21PbRwkrbIiHlz0a3I9YLhfyQqi4h/kVNGpM1OBy5FCZ
	02jz5GxndLoxSOTs7grLBVrxe746oBd3PdDnFwK4lNWWCT4kyE0h+yU5U/SF6oXD
	bsh5rq5UjRZ+DNPyvD5qCkx8wok7FQRh8jGsvxlXwipCBTHN+HjupqQZw0ulTZXL
	Z5FjKZ+85zw4OEGDe4R4AVZe7AqSofxRgsx/5rStd4/OyGF9y2NHGjtz2EybqEd5
	qU8k7Qzuzzb4lvS5cwzU9ppIsV8g8XPxkeemXUCdjyyiMw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf5c8vx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so461531885a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792410478; x=1793015278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Fg2JmWjJmbabOk9C0BRHqS/QtSPnqgEVZrkMmJYDlQ=;
        b=FCkwKrzpYhq96bfdDT3S0ICpH37bpWZgeeU70y0F2fzV+SCL2P+PpmnCLqMTEp1xiG
         owzud6rPjwKycY3vb2vYTXdPt5Jycqr4OUEGGKbL+MRLMC2VEHiCl63vvgOWu/6lH2xo
         ffLGRJEE8FdRRpJ466qM9kV+nlOjmYK2Ac/4HITUCaKGSj0sb+yNJ91+gEOykauY5Myk
         ARuQTjnQCwNLiGYMW81l8SO251Ex5VzYxap7kPzVVIy0T4f0WgblXg3lX3Md11MJFnPB
         uxb3mJkrmDnDjo+nXURw6zuEmezz9frIeOqmd2QzTDmlCFOb4kkNgf1ISa7NWcDlnX8H
         np2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410478; x=1793015278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Fg2JmWjJmbabOk9C0BRHqS/QtSPnqgEVZrkMmJYDlQ=;
        b=DK5KQLJ/Y/ibcPzwMg/fChl58IPzX6YlbayrrvN19tAr34ku7vZ+JDaN9Jfp9Uhz9b
         t/irAcrVFjF4b/6nzKt7Ru8kaCyBmFQ1KJgUCFcuxV3iCK9PYNpA5OjOpgE/2SMtm2CT
         rs1AuScNG8GDw4GqHxSPIOGk664eZckQDwoZn3qPFmXLm348jLaVkBjqR8fGe38uASPL
         BasMFLJdihSOwRu1oj9rOKD1/UlTrBuAA01PsXi0+X7fqcRHVw8Xv6onCsDySFWYgy33
         w2Hs7vDRf9+DuWdDqEnwCUScP7XnMPDkDYoEe+sgVUCATwzT3VGhdn7Nk7NbFEalg4Nt
         MZxA==
X-Forwarded-Encrypted: i=1; AKwUvBy0afq8ZvNh2qwTi4nXUKjByjLcGxSQF+FXs6TNwDhZqlfYcLx5LrMHjboSZ1BmiwJ+UMmJa0BnHIuEOQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIbtZN3M10sd/ufoCJALFT8UqLx1zJaXCojaUI1S0L0HNzm+AJb
	YZ2IJslHBRfmxZYVsE41T6Cle+qNO0MdjkNyvZlXLzbxnkeCT4RpQHGZljJ4Eno6D7HEpU/TcQZ
	B2tTHX/OGfPSgfaVxKgeQb7Do/NtaQ0W0qWOQkET6FBebrgXoDkbyQT8Cx4h27yX1dA==
X-Gm-Gg: AYBFou0muOqRwHM3JJB/URaRu0GelO4Wshk24A1rpBxJfM3vqO1/lKTdHzqtgupriBC
	IGDQxixtyI46+QEj2YKJ0h+vCbChnEXEuB6fN55u64aIjDJwT766Ky+Ge2FI8vjlyzLCByUXtiT
	8qIxqbaismK/2oDU7ZINY5aN3bx5IL2+YECeLu5/YjQlVe38/RA7htuhofpKX6Z+Y0lymIIpvLE
	NnwkCGRPn3EsmTVtGSGNESsh7q7hPYroGokKQN4bEmDK6c23RC69Q7wtHt209d/ihBYiXNEEXyF
	IEG8SrcgxuIvQy9kUiPRPAlRv03fkkk8D07PF7vKnKAUKHkju/GJkaNe1rINpxSxg14qq59NgyG
	88w6hEPnfRzvfzFOY
X-Received: by 2002:a05:620a:6f87:20b0:93f:2d10:ea49 with SMTP id af79cd13be357-93f2d10f8a8mr730720885a.45.1792410477696;
        Mon, 19 Oct 2026 04:47:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6f87:20b0:93f:2d10:ea49 with SMTP id af79cd13be357-93f2d10f8a8mr730716685a.45.1792410476993;
        Mon, 19 Oct 2026 04:47:56 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5ad06bsm23495798f8f.14.2026.10.19.04.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:47:56 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:47:54 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8150-hdk: add display card
 overlay
Message-ID: <zeuvurtobviw33jykidak63yf5kyo4y6api3bnctlvmxzgkfhq@bkxxhscma4st>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-sm8150-display-card-v2-8-86c05068efc5@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX1/jXTZ7IIqtd
 ePLXJp0Ei9CQv9cjBdn6N9WW1dVqFPa9fUC5boLwIKPPmUsCT25Prl0kYGLN9doe3XwxjiUQHZW
 V5A5cNlpE6wk6jV4iSc0hTojZKl45Ak=
X-Proofpoint-ORIG-GUID: f3yaq_gd2f_4LF1Wh14kUcJTulUzyEI-
X-Proofpoint-GUID: f3yaq_gd2f_4LF1Wh14kUcJTulUzyEI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX2csS2vgxYoIU
 cj9n6coSVnUNAeVWTlNn0+Ny39C68xojv6KOxfie7slo9mHutDB/8ylD5vfDmlSp1B6cA9C/g1r
 xQ1Vh6yKdlZ08h0CBvEtx2AwqagJ1zw63Xdj+hJdDvqXomW5ac7JT0G/dVLGU2Q2TO0xG8EfiPS
 zL8/w1sK+CGIsEIh1ZFP9L5Z8HNGRCqRV7yViU3J0d5aW5c5MEb0gTAHMPwTRQk08exfVKh5cTq
 FUTS2c8zK4SplLPgcOugAftHmUrokYeVBdxU+PY9Llx9LEd6oGguwMs4tZlwSVJqQyed6AxO7do
 Sylcc7tYHpBBf17nSgljiixxnUKguRTze8aPG8L8arPToioLkkpN8HGiTwagkfYDCD5fbohAYWi
 mIBNvyTjTlRPhDJaHGhZP0TyeacasWTAbvRG94eBgen5q55oiPJISnPvYB4aPjjHlkFTqxt30mc
 JxTbLc7N3nUEvagsqUg==
X-Authority-Analysis: v=2.4 cv=K6O3jCWI c=1 sm=1 tr=0 ts=6ad6036e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4ZraDTF-A1gCCZ4hMMYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190046

On 26-10-19 14:25:44, Dmitry Baryshkov wrote:
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

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
