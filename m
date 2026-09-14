Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97C446820
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392291; cv=none; b=Es4Iltg5O7BFAW4sLzbt4Q+AzVCwRcQVpMsULhn6NlVluieD7Mu/zcnZtCWXoRteyvKzMmOO4Bfyn8f1x+N956LFqfH3vcFLozKNYRCMMQnqBC4jnznKOvLK6njdZOpq8W77g4Em1I8Mn0arKlI5g0fZfQ5ZQI56BtpR7CeixwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392291; c=relaxed/simple;
	bh=5KLPdncsLccVWG4vS1VbkO+4SihTxYoWlWEpXBujLM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iScRYkEUkBiUmfjwKLy7lH9tw4W3RkrsmWfDUjy3pFYfVn0x716XWzThehvko6FPac3duKwhjjkU0ND4F8QH62XqjUB3lPMFDtVb0XcS7vKUGTxbR5lcSj2oIjW4NFdPV8LorHbaC80Nr6ofvXaeeZ51YueEYTHfADJte+GR5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QWbNb02Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cNtCCiDe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWbNb02Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cNtCCiDe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0Vn33588169
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 13:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TJEsqlbhkeYlvOTZeQMhupa6Ph/sDiB31OAPFik2LLM=; b=QWbNb02QNVXvEYSI
	LSHs0mIIGJEbh/T60hOsLDfGeW2+GMdGZgtgPBLfnuRpRvHzI9whPWMqZB86tGU4
	F9Go+RUrpDjru1FiBA3stdJJu47PqKS9Z5kGo27IFKcinkoCSQTC198YnBCTizSS
	ttcOlgH7DjXqVvTOOKEM8duu2LlXmt6ByPebsT4qK8MFH2VOQceaHToc8TlTntSS
	Jn7hcGDiwvYgr3Fb+R6PtOmtQl1oAp8Lo9ckpm5fsVNJS0O+rlcpLsjr6E/Xe+FD
	OtEhHqF5jl8gITZcdzYhNROZS9Stzi7zQy10Mx/ibD95d4dH+3yam4vpdPeXUsiA
	44yPZw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperg8tm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 13:24:48 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-79cdabf7d89so2059137.2
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Sep 2026 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789392287; x=1789997087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJEsqlbhkeYlvOTZeQMhupa6Ph/sDiB31OAPFik2LLM=;
        b=cNtCCiDeibDi5/bc8ZxF38OlsZA4M+jjBdAOsIm7ByWVO913r3NfhHOM0HKxr4imAq
         Yh83r7fTbEK5yuhPYNCcuYqeFAwJGj4PwwUQHxMdz56pE/GpDNbqKkniUqSKVjSfz7cd
         DI3xuze9kL5keqJ96+G7xBDdE7HLXpjTCt333PjM5uBlaljaDmeM+PNO118HxLNDIFN0
         IAJ+E1mpwF3Cs80L0VcfO45czc+V6/yBHq9Be66YFyPLdHAAqhbX0RI1hSjC7CVWIsAO
         x8EKVlbu9d2S3U/dOMt8ddlRtKANlzYe1bMKOk6SjBR2s0+1bP1/TeWhRt9Sl//zRdf/
         5VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392287; x=1789997087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TJEsqlbhkeYlvOTZeQMhupa6Ph/sDiB31OAPFik2LLM=;
        b=l003V6p14Q4MKcCAXkSEl3CRxF/T7h5kME2+1QVUOs9hB8SY4uJErh3WUBEQgzm2zC
         SCL8hrgfa9XMq4/UbOnTU3vC3yTAXLDf1M5zrdehllZvmsbjbsw62z1MzBK0mfZlTwRG
         powIVkRJD/jpidnItVgQwCzyNiCBDelXuNE47gRXaRBR0G2vPo5Do3PLkLiuWnJkj/x1
         2wC2C/bTYhqrsdlJDoKtwhDH+JTjhR6IE4sEvV48k/WzVQxdeNzowSNxFhfgK3KHsCoJ
         ZlXANRnbDa0Q+O7h1mRIw7K72MVZa7qWGw4xc3e05+X3pdDXEHZMIBz7TkWBHLm6gKfo
         tUPA==
X-Forwarded-Encrypted: i=1; AKwUvBwuVoh9JXVoeggDIxwPFtNj53N9eQUeORQAguycxT+FHCTK472v7sxh3F/OpMezzin/PzZpqXfjkGaXgQ==@vger.kernel.org
X-Gm-Message-State: AFuF++koJ0q7Z44LCprH0a3iMoM25x+ut6LpNCsji1M+MmQjWQsydgA+
	xLLD3s4IvDAA9Xy+dAMp4zgtmgWGzt+40KeLVMGKtc4gbJihVh+pO1jcQVv0JsD2F4EpQkz3HCb
	mgCBxC+ry3sxxbW40HJoRBfT/4QPg7lrjPN5dd7cJtihsj1GC0S9uhK2GmS4zRpbJWg==
X-Gm-Gg: AYBFou3m/8yl4CHCX6XjKPGVFd4RnxcEYEN8BcLFW46UeVaew2NTTwWyCq26VVgz5vU
	8VSyblaCxjcASPZZHm/96rfffHKKGhCFsBvHaNKRRzEEFkU1wRQhQWH10GSxIs/IZtdJ+9qdVwq
	r0H8e5NwyWSfOCJ+T87cEChCKpYA/g3mxnHcY92scHFr9zwGahT4UZ54s9MAHK78ubN8s/osUg/
	kZ1ZidIkgxP9zLGLRVd6trcQWdiknTJJNIJoZprmh6GeoYs1S7crBDc1KpLqqOUiWa04+OD40jx
	ODixLvdis7vbfblsQyGA6YLpILeTFL30YBCqQE7SNncvr5fDPgm0NsXvhji+yuoaH4wED7FA8UJ
	VheZhgNe72K0W+UWGtoNBgIvSFZex7VVNs4BLgN3MCckokTDrGUamo5aBoKNxrFSBb5UCIEB3e+
	pbzHjj3hTBiEWJ
X-Received: by 2002:a05:6102:6a90:b0:795:1be9:661e with SMTP id ada2fe7eead31-79b570f4ba8mr1228016137.1.1789392286936;
        Mon, 14 Sep 2026 06:24:46 -0700 (PDT)
X-Received: by 2002:a05:6102:6a90:b0:795:1be9:661e with SMTP id ada2fe7eead31-79b570f4ba8mr1227965137.1.1789392286464;
        Mon, 14 Sep 2026 06:24:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0472bdasm2443458e87.63.2026.09.14.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:24:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:24:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: kavakliyigitcan@gmail.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 08/10] drm/msm/dsi: make command and video mode
 configuration mutually exclusive
Message-ID: <pnlrq23steuyvrqm4e6krzdlaa7pqozxqcaaakzsmqajuo7n54@hhhu6chgeei5>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-8-0e68e63a18d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-ginkgo-submission-final-v1-8-0e68e63a18d4@gmail.com>
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa7f5a0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=irAkg3Ti1NS2jvoIXoMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: ULMctKUZkMv02T9TBBic10W8lSGB0WYW
X-Proofpoint-ORIG-GUID: ULMctKUZkMv02T9TBBic10W8lSGB0WYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5MiBTYWx0ZWRfX6iElsuUvNFPj
 mzyxjAhSA22o8lOri+DGYfJfRyuLtmGnu8oVb6obejlazqf+N79mNxfqZ3r9x1QAtwzoIHi2OUI
 zWecFJH/uT9wKAUCbQTmmjqQsABABCr1x5YL/ms3wnh3ipVwv1y+dc1Y+1f6Th5clKDkW47gjIg
 lIZ4iys/cbOjTZW0ZhUqukcfPlnd1b0Wx4yTOLgNBfbeDFJ/47IMSMVGHyBAIFBhi6x3B2tuuSR
 xyzSfygzUWLQpZdF4yselGeulSZeUHloWy7PrJj87AL5l6jtSw5vi0bquDvVQdsVlRZTdjdBNS4
 LgiES+DD6AZn4wBWHwtmJFNHnu0T3U8OKsxTe7bJo2tJFjoKm0CGi5iJ65cPp1x6yzE0ndpVKU6
 lJ/QepCM9tS/ZgPgohH+BuzykEvSc6MqX+gZJaa0EcsCb1+goPs6ktSXxKR6b3uyk6Lrb6KULi3
 +/09RkLJvP+0nuxBg/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5MiBTYWx0ZWRfX8cvXbbjOwBDS
 VMDeAbj5iTV6j7bHnyWVP7DtM8llp6f1ofNaZgh5KvhdqBVTSTOvWkMX4F+i/Ezbu/m/Nv6GGJV
 luwrKEY9eY2K+FT1hXaeq7Qg4TYqiHc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140192

On Fri, Sep 11, 2026 at 11:51:05AM +0300, YİĞİTCAN KAVAKLI via B4 Relay wrote:
> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> In dsi_op_mode_config(), entering video mode sets DSI_CTRL_VID_MODE_EN
> without clearing DSI_CTRL_CMD_MODE_EN, and entering command mode sets
> DSI_CTRL_CMD_MODE_EN without clearing DSI_CTRL_VID_MODE_EN.
> 
> Ensure explicit mutual exclusion by clearing the opposing enable bit
> when switching operational modes to prevent hardware bus collisions.
> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 7e4e3718b536c92dc555de213042857379499447..b9e2867d435a3ad8b6db6b57c440bbd827180b6e 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1094,7 +1094,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		dsi_write(msm_host, REG_DSI_ACTIVE_HSYNC,
>  			DSI_ACTIVE_HSYNC_START(hs_start) |
>  			DSI_ACTIVE_HSYNC_END(hs_end));
> -		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS, 0);
> +		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS,
> +			DSI_ACTIVE_VSYNC_HPOS_START(hs_start) |
> +			DSI_ACTIVE_VSYNC_HPOS_END(vs_end));

This fixup is unrelated, please split it to a separate commit. Also, I
don't see corresponding code in the downstream driver. Do you have a
reference?

>  		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_VPOS,
>  			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>  			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
> @@ -1168,8 +1170,10 @@ static void dsi_op_mode_config(struct msm_dsi_host *msm_host,
>  					DSI_IRQ_MASK_VIDEO_DONE, 0);
>  	} else {
>  		if (video_mode) {
> +			dsi_ctrl &= ~DSI_CTRL_CMD_MODE_EN;
>  			dsi_ctrl |= DSI_CTRL_VID_MODE_EN;
>  		} else {		/* command mode */
> +			dsi_ctrl &= ~DSI_CTRL_VID_MODE_EN;
>  			dsi_ctrl |= DSI_CTRL_CMD_MODE_EN;
>  			dsi_intr_ctrl(msm_host, DSI_IRQ_MASK_CMD_MDP_DONE, 1);

For this one:


Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")


>  		}
> 
> -- 
> 2.47.3
> 
> 

-- 
With best wishes
Dmitry
