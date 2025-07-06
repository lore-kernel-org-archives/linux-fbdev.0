Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDC1AF4D5
	for <linux-fbdev@vger.kernel.org>; Sun,  6 Jul 2025 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751800460; cv=none; b=A52oguaMRQnXnzHs0rFAMqnhRtNGUN7ibH/4b9KovoNBUsnHvDKDwPP5BtwMecbxzZ148O90SRxKGN16Ezye8/g4t/rbtMUXE8K7bE4VpbnKvRC77QwEshMJdkPsw2rfNNEB8eohoRNuSyQQCUZaFEamEyrNomWzNYI7EOdXdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751800460; c=relaxed/simple;
	bh=uuZhUIvreA4bF7pGZXOUB/dWe2RprMCXjDmVKLbJx9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loeoPoorWZiCP3IINNKrzR85FD5f182D52LrKfzK7IkSbNdGO6z7jA6BQCPfY/+FjBmMEekE7yRdkvbFNG/PGBLmmXIEKH69JlkaZJIl/ZGyBjlaY39tZNZ8TjLlPtRvi+QyrtKnZkULSrT5qmDrV28ebTcf1e7VKOe5j/3a4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NjnccWlv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjnccWlv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5668nFr9004157
	for <linux-fbdev@vger.kernel.org>; Sun, 6 Jul 2025 11:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lrSM8BW2HndVBSoj7s7FhZs7
	d3IX6Be7fW3wKRsVstY=; b=NjnccWlvZ8Zf9Dbyco2U/mrZHDEEAioTaJOyCe3D
	u+V3eyM4TkHJebOvk7//wbMExSPq16IDbMcpFwK17Y9j48KQfU5dZbyNFl17rDxy
	zjQ/bZet1awHs5MMnEhOQpJw84S4MKYCqq2a0TgjHGZC3CmBhRBfSq1n+UnycpaC
	RxPIgJzNaVVCj+9sid3S9LAyKk5oZnJh7oJVNH4nmDXUHdNsn3rOqSn8tZc71f7W
	/qGxh9HNDGHK0xzs/5v/xT2whOLN5bxwcv070+z5VdJh7Zw1gA5axVq6HYRM8Gf4
	x79XOADbOYH995mU/SIq56xWoCr+m9FmG3eUN7REBHXt6w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrk3q2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Sun, 06 Jul 2025 11:14:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb3654112fso47511016d6.3
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Jul 2025 04:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751800456; x=1752405256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrSM8BW2HndVBSoj7s7FhZs7d3IX6Be7fW3wKRsVstY=;
        b=X+h/khSldV5j0L3tFxIXd31dS8ISneoop/qgTfpr1+kobEqfL2ebDMHWB9OwtiBhTK
         Ozihd45YMiL9C2xekS+0f2DNx3lcSFuAQynsRDSzdrQusYbAWrHn9Vyc1qMwASdAdzAc
         unRW3OxqB7s0oVwAF+lT7EkZfUv/qxkHBXxmtbkzOz7/96rDx21U4waiYTJVzSgcK32g
         ZD2E++uJP6IXoppHEI0iQNN7hykILuZW0rmcuAx3I0dWx+lVqTdinabVRk36rL4dQ3Mg
         BkqdlrbqJaQ4Lxral/F8kxf+oeoShku7YuUlimYCHm8S0aISZntYyUDmxIxrwP90Ccrz
         OqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/hPm55RlgxvGE90A3Y5AgxRI8WZH3BmTYAvNWnhjqYdfbwJRicY04RtM5uzFuEJ/1UYm8EnBIsUHQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytnKFFt7w7J6iy0p+c9agH/4VdvQ3MylfyN/1EPgI8E+HEnQCm
	hKEd4V4jSmEN6t5E+jwfvMBkmskQthav2ZCZPk12RdSJwUhFcqGCEcc1CxTVH2UE7FMJBOzVpbN
	TqNfs06dIOJ9qb9Jnn+E4gkJJ3wR0l+bch32qr9Wvtt9dsmqSfEgRjWydT/18JEbSBQ==
X-Gm-Gg: ASbGncseSwpDJlF9//nfkogA6bvw9zTED+dDB/jjC+wk6gZwiTftHE8ZZQWTH0FJUFF
	x5WKul/QlGF76VV943qZE7FA/exzosNuVyKuBZ11ARIVgxyOJrtpQCN2JNvE/pK/ti29agYBYSf
	XLTz9kIBu4RsHTArFCj32I84wH7XF0rOSFsN9Kj7w/Dy/hfF0+V66wxivNdidc3ENPj4M8iW3T1
	HaUReaFJlTzbBCiznpIjFKSCoulK8XwEAzXkrgl00HlyVXUUMPbHtLFMOTpyFRS7/OMPJrwOt2e
	+DMX4niskjP9/q743wQJT+70TAP7BEHuyE8oPxVwf7M6oiZ09JYWBGemGYTy6TSfuzGhysQIdpr
	GPcm9l1q/B6xyfarRkRAJ7/QKNtdF8NkroUc=
X-Received: by 2002:a05:6214:21eb:b0:6fd:7298:a36f with SMTP id 6a1803df08f44-702d171dc05mr80227626d6.21.1751800456066;
        Sun, 06 Jul 2025 04:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3tVpmWS6ULWjjoEzDvnHa4iP9ltUJU6hMVJCwNkucLTWgzKEQo0EkOAPEAKMG3p6BoF+iLA==
X-Received: by 2002:a05:6214:21eb:b0:6fd:7298:a36f with SMTP id 6a1803df08f44-702d171dc05mr80227316d6.21.1751800455658;
        Sun, 06 Jul 2025 04:14:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1aff4e38sm8826461fa.50.2025.07.06.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 04:14:14 -0700 (PDT)
Date: Sun, 6 Jul 2025 14:14:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for
 interconnect paths
Message-ID: <ypjcqiyfzjobg4zsm5sowjtu6ctvzgd4bvt3wpbqbb7o7f3rcm@q454aob3wwth>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
X-Proofpoint-ORIG-GUID: Hr_CbX6OmkqHCnrYJHUT_T54wRrxmrCS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDA3MCBTYWx0ZWRfX1AK/NXJc4uX4
 qleaSkXKEYIChbD9wgywIDlzfW1E24n/KL6mGYKNM5j4tZQOoEuFlOtUKyLXBXQT1jqb63ICO4t
 BoBsFNvTMIH0JdvjnfsfpMpBY5AL/QEvfgc+suvvg3FSJkRXIIdL48qM+09iTxijNvVJGwCFjhd
 ZBQMvIOFvEeew/e5uFD2APWyxK6wG94wSPISoj4Ef8EgipefdAYo8cpJZxqNiOuNVJ6NOx6G+ck
 M6ogEajQDkDLn2kGFoSviann4xa85GHoLfd7w+32w15IOWWBy+l7kuYNNYDLmWt40Q9g53xNA/X
 f/5Ux+hDnVriqC76aB3OkByK95ZrsQK0CB7AJxUWpkIQTHNU7BPbeikatgczlHfIF/6yFrfrarc
 dJAfJFk+AECQAQg9RA7d92gKMakN3bJlM2E/8hZxfQ12F6GdeI8qrRM1any9xacJwODGdDMa
X-Proofpoint-GUID: Hr_CbX6OmkqHCnrYJHUT_T54wRrxmrCS
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686a5a89 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=EMKPgfd9biIQv-X5rfEA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507060070

On Mon, Jun 23, 2025 at 08:44:47AM +0200, Luca Weiss wrote:
> Some devices might require keeping an interconnect path alive so that
> the framebuffer continues working. Add support for that by setting the
> bandwidth requirements appropriately for all provided interconnect
> paths.
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 83 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)

If simpledrm is being replaced by a proper DRM driver (thus removing
those extra votes), will it prevent ICC device from reaching the sync
state?

-- 
With best wishes
Dmitry
