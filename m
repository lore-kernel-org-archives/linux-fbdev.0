Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E1218585
	for <linux-fbdev@vger.kernel.org>; Mon, 31 Mar 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452590; cv=none; b=GHMu2w4wMw4QVx0VH49pz5VJywd8dGrGYpwEbnsUOyrMIcgzeZ2oaNlbUU7VGzFSKP0NRKFvWZBSDVg8TVwySVmyO3YPWbP7/Sux5/BB4jWy/ldzQKLNDH7VyWehFaJl8jKg3YaLsJEBszIafbjyJvudJmP2h1PHZPmqF6FPOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452590; c=relaxed/simple;
	bh=2GfGlNKbYEd6eGd8KETFvs5J/4h7n1NwKtdRzeRnc5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXbpfO2Be/0wuY7SpyPFZn/7lqSXzrI6WQIHgJYRbGMUZkugVjqNcqSaDG8xyoz7W3oK5gZCOaL017xckt+DyM2TxKuIUdQsfCKkRcPNBU9XkEo4wYApYReuXLx3qOX9PzFPaFY3ZbcAEJ/RiAYpDp+Mi5l4pOETQIpJHn8g2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KBJvjflR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KBJvjflR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFCvKj026717
	for <linux-fbdev@vger.kernel.org>; Mon, 31 Mar 2025 20:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/XDH4np/11kTXmxJhc43+oag
	MOQJnczYYqLJy3cdvic=; b=KBJvjflRmuDdRLdfTA89gJtezMY912+9wModq5w/
	+b0yGderQ9faUPoMJV2sKTHYL4gSGLcqrYRh6xrv3PLUwKaIul+sImZLawy4kuBX
	VaFpGrf3iF7lyRsdu5sGrPPMhf+OIZrfB5oGD8AgUgHcCh9q+ZToHxWLUylbxWF6
	s162OJMAzC0ZaFGCLXGX0zVzdWC3l0XWsIUcPlcAl+jnknWcX8DUXjTSndZOH0/U
	V1jfeblkBKAnySt94ZD0n91novqsa60pAFsVMZz8VSuIcUbNcRQnAKpkHZZyOGeS
	875ke73XIJcta+bOQUZjfHerJjFpmmMtADNhhkTIpmawzg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7v8dn8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 31 Mar 2025 20:23:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5c9abdbd3so477210785a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Mar 2025 13:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743452586; x=1744057386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XDH4np/11kTXmxJhc43+oagMOQJnczYYqLJy3cdvic=;
        b=QowAlBL2OhLT3BYhNgK4c25EI8Lfbicv/zX0t/h6FcHcWLC8uH2VsRVY5Ykp1Nk0Zm
         Or/AdDyVvr8VVBDUr89aHCL35rGq97XTzKAGBOxgY52Q+waEtPEzschnxMTbFUw76Wf9
         8AxLqY4mIrCrSUaNsbnfOrDu6AWifZb5d0ypDAG+jEOFvzhQWGTpOsFh2QiBALBwcY3U
         KX08dLUFlKgrBf3FdO725o8Q66H77B+vA/MhfskMx3wihQPQZQwwJ+iJJFD+dytunAKV
         rzVTQscOnJBh8kSsYJQFs/kzX4TbDJjv02Wb2N0peKwxPl5PLCdqmiic4rx+KzfIvffP
         tuuA==
X-Forwarded-Encrypted: i=1; AJvYcCWcNhYMqJbKSLhRDnnH4foB6BxQVWy1cdNNv+UDgnCNikVXleXw7w3ARhw3QU5g+S6gSxHfCaHbaFjrZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTz6bmpwJSyKDCIWpZoHxvFJheLvsZyZB4uICYuJbid3Vk82Rl
	8hrJIa3kMqjUiPGPUILWWUuNNh+ehu4tMr7l3VbFxNau3qOJTN9iikG5UjZQ7+UbES1ss+95DtN
	Ss70oq0Yd1u/gT0xDapwApv+Mw2Jpy3pNxH0kbNHHWjgztdPaCasomQTIz+w4zA==
X-Gm-Gg: ASbGncvViLfV1700gSJOn48NT2JQTaeJjVJgC04a0BAftGwmtbw4D3utRn0PvnlbVkP
	5yQM77RFnVWFc5tmBj/J7n1MMCZ0IB7EJnxBxxC1vZYX/8p8e8KcqnjPJPaCM2D9OynhAhew01u
	qdcs+EwiqlS0TvfVLdRD7SIDOhyERdbm+QjaqP4IbyXRNMWXNLZKvqfoJSs3StSKm9aekW+958d
	3MKb326P3VZQtRZ74xP+nCXK3dGhJWh4RHNGaW0TxEUjCdx2V0Vh3DG1Y0CjDxA7orh71QvQwN0
	+hfSdQqoK/Zg3xslZlz65QDmacPninknQ1WtG/lSaRI4FHpjI8xUD4sg9rZsW/xr0DEB6p7o776
	j7NU=
X-Received: by 2002:a05:620a:2a03:b0:7c5:6375:144c with SMTP id af79cd13be357-7c69071e2cbmr1183408685a.23.1743452586623;
        Mon, 31 Mar 2025 13:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYPejo3kER5dNDXDvNgrSMesprgR2DDS2npUVvqdvd1MymJqIcUXKNSnahqXjg6Ltaa4Rclg==
X-Received: by 2002:a05:620a:2a03:b0:7c5:6375:144c with SMTP id af79cd13be357-7c69071e2cbmr1183404185a.23.1743452586084;
        Mon, 31 Mar 2025 13:23:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094c1ab6sm1203757e87.97.2025.03.31.13.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:23:03 -0700 (PDT)
Date: Mon, 31 Mar 2025 23:23:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: pm8941: Add NULL check in wled_configure()
Message-ID: <rub2lfc27qef33iziydwd4qoaxia3ycs4iq7o7hujfaccznma7@hyavk23v7rbh>
References: <20250331141654.12624-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331141654.12624-1-bsdhenrymartin@gmail.com>
X-Proofpoint-ORIG-GUID: lrVdBKuLBSkm_bMVxsOKEh-KPM9XXFR7
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=67eaf9ab cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=cQ1TuvgcctVPKzGXpFYA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: lrVdBKuLBSkm_bMVxsOKEh-KPM9XXFR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=971 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310140

On Mon, Mar 31, 2025 at 10:16:54PM +0800, Henry Martin wrote:
> devm_kasprintf() return NULL if memory allocation fails. Currently,
> wled_configure() does not check for this case, leading to a possible NULL
> pointer dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue.
> 
> Fixes: f86b77583d88 ("backlight: pm8941: Convert to using %pOFn instead of device_node.name")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V1 -> V2: Fix commit message to use imperative mood and wrap lines to 75
> characters.
> 
>  drivers/video/backlight/qcom-wled.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
