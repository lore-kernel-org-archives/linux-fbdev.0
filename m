Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8844E05B
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410386; cv=none; b=dW9be3QfpN6gSNbFZiDyS8yC0B+Oy82VSwyTmQ16ICIBSmDRatdS3xKE24KunfP+rT52HPwDrhK7PK1cE7/malW0TJBMADFxnSWxUQgNrhstZMi03vXSV3oHmPCT1nYBfCNauhS6IjHnV3omajBL2MSyQaIPWU9N38qWX41bVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410386; c=relaxed/simple;
	bh=ewQoxyQLo/SIXE0r9ug8m4TnQqvVKS+4FgnH3/X1IRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsH8dH7rRoVejC2zPZpcPkUwiMWKMhkAGB/GemuYgS6nadeSGYQ8VEZSU7XJSwzXA60JfAgZLeuOtDHLenMG/sqyqWeTdTF+cSgT8wWY7mt5PVCshHO35rDQQVz+WkkziVCAwF78mU2+BWrGhN7fqLp/vmWm1JWQbIm1B5wyAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TEaqUc/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i85v3/+h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TEaqUc/A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i85v3/+h"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Oltr1348069
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hG197sZx3XRJAemskE7V+hMh
	trqkgeOsYb24Xht8LNk=; b=TEaqUc/AW2zv0dvvnpDGjbJ34/KQDGa49xWXOlC6
	yz/a6Xp6aX5v3p3UgpV+s4NNziLQicA+imw6XHDL5sTpGfxlnvUIPDyXYxy7GADV
	G7JscBXn6Mg6NOG3jb/vIszrSa4jEGMWEgItHiJU/ZlgycX/KT6j7cPKNqLwFO6I
	mrMjWB4dAWZoYrpSRN7NSgZ7Kc6IL9SC3Gr6nyRCe2Xv9AQfof4YdWucsVpurvpi
	/QvDTfMq5abkWg1dR4XwYEkJf8D5/jjMoMkvbeQ4qHhUXD5Fxy+kev39xWw6OTPP
	8MAqZgjbQ1GcywD+xKQjFwCyK222Xlnw7uAsbnQgqF2TkQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgvj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:46:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934956beec8so435236285a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792410383; x=1793015183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hG197sZx3XRJAemskE7V+hMhtrqkgeOsYb24Xht8LNk=;
        b=i85v3/+hl5YPgvLGvk7GpL03Lxz+8U3PNwW348k9UR16r9t3nd+u7fy3Q3QbisIkbk
         euCcB1JMFh4Ii+UkcMvrhcSI4ZNru4HwGZFlHhEdTqb9OgBuzutpTwi5+1thMNQQaFPg
         rNLz+UP25dR8nObWvFpwyJfVzCQWdHYQ8M7LIvYWvaZ8QPO9EyS4lP2GQLeLkB1t6v31
         oCiLneEy3vnlXAscCPcM6iMNCW4bkl0rHGfk8JphaQdHwFKla/OeMkpz2cW7CUPA12KI
         GwLiHc14+1Aj5ZjpaRi0D3dF15UKR8dAdlB9p6caymwJ1DfCRsIzVynFEs1/s+5E11/9
         /4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410383; x=1793015183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hG197sZx3XRJAemskE7V+hMhtrqkgeOsYb24Xht8LNk=;
        b=RhoCHtLoo+JuSpDzZ2JWBe/Z5f6yViDwREYZRuJUh+aL6SQomB/t8q1fXcA4rvwrtp
         Iheu+54KAlWcH+KG3qiz/XuPdL/XzqSixrv+XN2S5rrYFl9/DGbgVKYduYY5O1LeuUCI
         khqKQlvmsVaggbuYPWx8yrNUUamTMeYR4n6AeiJIHVnsrB8uGVSaQ2Xj0h2+9YuqsR2d
         6Z97C51hxmch2XKI8QYVdfh1V+ZH7MfuQxR0hvNBeR8j8BYk6Rqexs13rTNI2Ru/zDMh
         RLtqIn0vKj+x2SkXYVdmawnZUJUwRKFh3MY0bc98bKIjlrMDIGP5dsKrY0lGoZkW52JN
         DUmA==
X-Forwarded-Encrypted: i=1; AKwUvBxVKfNArCdew8GW4z8GzzN3NrP6TSbHNVWvMhWqvugyrgmanZAQ5gSTKfk6q/gmpj4eNxodTQqby6/IRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKOVul+AUO7TKYTbssI0kcETyL8WX2dqOhuAS5VbqfBO6gO4TMT
	gAMLxjZqs4vwsH+oOgcH4rJng/5MKIyOJkfuB4DT5lrKnLwx2da/L0o/xAU59RZshYgEEBHoyMF
	wngSKsFqFq9lhc8OZDZq0fjevaB5aPtsf7eOWS5+RVimyb6lj8/HWqmN566VyrL9xBg==
X-Gm-Gg: AYBFou31k0j1JBmAlLQ5w8TWD7AeUeweG8YQ4H4ennN2T2hqkqOo8Re2rLV4yidifh0
	mDmIFwHpIoNK1C+tmISGY7Qnf7z65WQZ+/eAvv7SBd3Z2UG5XkDc0jFB43VYOCdT8oL2ircaiTc
	pQR0RzkumlJ4hm7Zw/tWaas9iTiFGh2+ZVCdtW8KRgNFGMH80MjDoU6R2lOFZKUxO0Brm4+HhCT
	zZwFLczi7BTPErKFDCmSlb49yTJYr7zaTaX+5hAmeaOxLC8WFUT/wY8wD+npgZYVsPTlnZ4uflg
	FQpCVE2UbBXKlOlwqTh6Zd5WTfyYrXa/9rZsc++rzUKXQja/Oq4E1F5bRkRBbU9scaTzzh9qmLz
	TaMOaFqs18H8WQ9oK
X-Received: by 2002:a05:620a:2601:b0:93f:115:7338 with SMTP id af79cd13be357-93f29d66830mr1237945585a.54.1792410383075;
        Mon, 19 Oct 2026 04:46:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2601:b0:93f:115:7338 with SMTP id af79cd13be357-93f29d66830mr1237940185a.54.1792410382478;
        Mon, 19 Oct 2026 04:46:22 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e19ad17esm60581775e9.3.2026.10.19.04.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:46:21 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:46:18 +0300
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
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
Message-ID: <rpsezddufer654mndwogaguvriun4i2lhu4nnosedz2h34qnfk@s44v3tjrrnnv>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-7-86c05068efc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-sm8150-display-card-v2-7-86c05068efc5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: xAF8QsmOoJAnP0hf_8a1rQJlQ5dhVm20
X-Proofpoint-GUID: xAF8QsmOoJAnP0hf_8a1rQJlQ5dhVm20
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad60310 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=No1CG8Rj059PRq910ZoA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX0rxmSelssm7u
 x+dG7aMk8p3LsWugIR4UXjunhFfazacvpfZJAxarv0hoveXJhZW/qioVCokd9JQ2KdqqWX676Z6
 VbrXu9RH+PI7ORfgoAm30dHnrC5rP0Eximzsufoo39UA05JG/9Geye1YnJx9KTclNi4KgdM5HGb
 O859FPJwaXx/traZCNO0LFzhckDKfMJEEZAQezCGr0vqof1dirHcaTBgHBUP8qWCLnrK608IRP3
 V2W91LekGjoqKX7rBJBXCsFJjicCrLH0dOOQnI/eKfJhERIXSPa/LWwHk6oV7v1t7jjVoDcj0KB
 TjewR5a3Hn9lQ9iYfNYBq/OtT8JBB/F0Jp6JWK7PXpb8Mbful8DLGF0k8qJGw+XaTGMshyko7nC
 cx0ipRDErPM5w8qnz2yNwC9rkgapfA7RuuCYUXTLdTQZ/gnHHaFjGf2vVKLjGW7oLPxFDYMIppO
 2AZ2f9ymz3FodAeD/Yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX9OjCbMlx9iyZ
 kSkOeNMWhmsZ2DqUzTFTRSB4JkCGgsUasCsU4ZxJpp7WljrQGzcuW6pR01k3DuicdZz9vI4QuI2
 QgAVV6mx3A4/qo5YY9zj7l8L922yz4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190046

On 26-10-19 14:25:43, Dmitry Baryshkov wrote:
> The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
> the wrong address the mux driver fails to probe, the Type-C controller
> and the DisplayPort controller keep waiting for it and the display
> subsystem never binds.
> 
> Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
> Assisted-by: LLM
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
