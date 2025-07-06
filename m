Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F793207
	for <linux-fbdev@vger.kernel.org>; Sun,  6 Jul 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751801080; cv=none; b=Qiz5UCqH5vPGfNjk1+hVQW/a8HdsHaaz2gjSdCXAlSCGgbs/BlbpHte8rMwGJ86VY4KT7IyW46+xNMHzK/D2mqtRJTJQdYmR1qPWuThrwR/sknaHTBIj7icDWNGOEji7dmW6bsCqIxJgZEH66OwkHu9QVtsHq0pIV/mchBc23cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751801080; c=relaxed/simple;
	bh=xviC/Capada6BatJaaUFyNv9rU1usAY5FNJckp2f86I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMWTbu/Ow5iErTWdILG5CHLd3xzAPXp0F/yh8zgEOiN06GW+bIA+SmDtJAP3yZeb8Xu2x+mYKcO+DxI0tw1lPdVIe3BCBvybi23E/dvGcmRfLsbyqlNffHyVv/3KckkE56/RBzIHfDixyfbH2DHVEmjc31s4axpHx3lDko5/sSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VYYBIkei; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VYYBIkei"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566BJ0gg021545
	for <linux-fbdev@vger.kernel.org>; Sun, 6 Jul 2025 11:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lZ4wwBfarfMu4FkrcJkR7OZr
	INgFH1Bdf9heJSXgTxs=; b=VYYBIkeiin0PR82ZMncxUtwhwPT6cO5tPwmBch14
	PE5RogrghKZ7F4s+jJUA5gtYoR9of97tLfBAbOOk9GEyoWB8zXRYA/agbRQ3ZGf/
	ZOk9fx7OAhEQcVkqq+o8Q2AmqNFAiKkTC8wEd+Axvr2YeqU4onZunRKCkA4giabc
	tyEB8OyDcUDRlL/WthOh/nQxl17SiReeLZ91nkBLYS5TokXQi8JiJ+KMVb3CIhTn
	flj6zwflp25uO2CGgQnWujouXDSwhGQlMwekGyY0jprIR5OIztUUjpZRoj3AyZEP
	JPl8RheHt1nON5jtGnJcQJT6QYkoWblob3c0LifUF12CWw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2akuc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Sun, 06 Jul 2025 11:24:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d399070cecso402332985a.3
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Jul 2025 04:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751801077; x=1752405877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ4wwBfarfMu4FkrcJkR7OZrINgFH1Bdf9heJSXgTxs=;
        b=kO+92s7aKCLV+PSJefjQaL0ZpDpq79e1b1fVXoBHp4zOfg/GMyxf761CzCzcmqlCkv
         IDFcOUJBHNuQVCmrt9x8NlV5ay8Y0EluvUo2B9FgUuXVeyYM+r2kMjTKuU5TWh47yJrk
         c7Meu96+7TEHQ7N9UafRoyBDdEwMB1UhfA7cLNc/ZB5l/OW+KF1U34/PAgAdMXFsE38N
         Ydg24avwtOK9/3fm5Usc5OF1mAWuCtgkzbq+Sc10hkZwvjXtBOQUoHibfNOlLroeLwO3
         525QzoAUIFsAZwJrCl8OBxyw8+KSNpEK7ieyBx+3ulnFtOUpHi0SOeqeK2CCgIwMEOgO
         yqsA==
X-Forwarded-Encrypted: i=1; AJvYcCVmp6lFELGPOMlufjnUQ1lnFmi+axZXVQMSY3JGb0qlaPJgO0h0DPDSGIAMnRihr79NnardNVcwjx+5EA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2Qq6hrHFzJ9ZFL/C9Es1kvp93LgkMjHj1KJuJlbuolDmvKAl
	KcNmEBAywX+8ISA2CC9Qur2oKvlI2cUeOKjsIFhLPtDWov6LzcP9YYTC1i+LQD8eIT9EkHjTLUs
	tNTKKYDd4sG6OL6aWdNsb6b/C4H5i+zWIMNsrE5/TddihWgWksVdg/6R8FI408SVpGQ==
X-Gm-Gg: ASbGncvX2oUeQslZHw8Krs4vcKr6Ibp2qbEC/gw+MopElOUKLwO237TKVF738rSznam
	FfwFBgLUSi2gHbD3BrKpYfC8ykvxWWlOilhQuiKvo6+JCWAIb5q86tTUuNxHbtIpqiYChD6fqmt
	k2RMP5OaWioNadmkU6Fs44hOSnUMgUr2z3IC4lFua10AoS/uWgr1jJTTHRqiND3RyeTEMC/VkaW
	hhuSrAf5LpxsCZscOw4rLHHp49PZ6rpCbGLMQzEYBDHPAqKIbOanyEnNRVBxwxxs+SjjWQaWAX+
	qY0QwhEZNdiErFF5p/Xm4R1cBUlBXSkaSOEX85vXNmCGn1Vp1Scwj9TAp3y/Fh/8Z5VYi1cVjhd
	ubXQydxQRbRFdabwpsNMxuORII5ZEyUnAhKU=
X-Received: by 2002:a05:620a:bcd:b0:7d0:9ebd:821d with SMTP id af79cd13be357-7d5df0f57a1mr1309143285a.23.1751801076688;
        Sun, 06 Jul 2025 04:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQxYqVhwCDN6qw826q9oGMWTR8eFtlGsSrq4QGizeqSiuAU0bbfjwG1uKJ+bSsm5e2+rnjSw==
X-Received: by 2002:a05:620a:bcd:b0:7d0:9ebd:821d with SMTP id af79cd13be357-7d5df0f57a1mr1309140585a.23.1751801076305;
        Sun, 06 Jul 2025 04:24:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1afecf39sm9101591fa.42.2025.07.06.04.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 04:24:35 -0700 (PDT)
Date: Sun, 6 Jul 2025 14:24:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Luca Weiss <luca.weiss@fairphone.com>,
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
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
Message-ID: <vk7xshncx3vj66ykbt3cfdjwdsx5uewfzlqmfsdbjfgju4awwk@lz76hnenxq2u>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
 <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>
 <DAX7ZB27SBPV.2Y0I09TVSF3TT@fairphone.com>
 <1129bc60-f9cb-40be-9869-8ffa3b3c9748@kernel.org>
 <8a3ad930-bfb1-4531-9d34-fdf7d437f352@redhat.com>
 <85521ded-734d-48e8-8f76-c57739102ded@kernel.org>
 <e534d496-6ce0-46c8-835d-94b3346446a7@redhat.com>
 <6e4253dd-cd73-4302-b9df-44c8c311eb22@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4253dd-cd73-4302-b9df-44c8c311eb22@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDA3MSBTYWx0ZWRfXx1cfUgRIOgZl
 /9AKSp9zMh2LHrS0hSNK5UT76TXhQa3rTHmYA6BMj9EsMSbv8Ti57Fp6IECU3MDl2s4n2GCP1X6
 4WV2IgCuXewcRUJFLtzDBgQrSjztebl16RXxjiUnyHql/7tnBwBcTq0rdQjLCIjgHfmSJktv2qD
 hgdZ0OPhL6ZYxxbHJi6kvRhe2COuLx4XKV16KlamZlT90yjU/PmxbkL66KVBcY5k39Y9XopY7UZ
 hpWcs8EaKsJmXXH+hJGz/S4us5Q5eFarZWB728JJ00wToqHd5xpICYMe8utfqMa4MgBjOfGfejY
 ojsM+7MPQpdEd+q4krhycXoHiUkbrLM6BKpsKlwCcMv20PGUJezKX98U62N/zN11AAD1wZfbl03
 OSH6sGDPdNB4NPqvZP5hLJkjOzv5mCp1jyJvKmcOB3HanfEeWRmZUjYDVwBZ0a4sP9udzYK7
X-Proofpoint-ORIG-GUID: FPKgGDp9_IpzmVjEua84kleMzIEwn7_i
X-Proofpoint-GUID: FPKgGDp9_IpzmVjEua84kleMzIEwn7_i
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686a5cf5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=N6X6wSw0Y0as479F-PQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507060071

On Wed, Jul 02, 2025 at 10:43:27PM +0200, Krzysztof Kozlowski wrote:
> On 30/06/2025 10:40, Hans de Goede wrote:
> >>
> >> No one asks to drop them from the driver. I only want specific front
> >> compatible which will list and constrain the properties. It is not
> >> contradictory to your statements, U-boot support, driver support. I
> >> really do not see ANY argument why this cannot follow standard DT rules.
> > 
> > So what you are saying is that you want something like:
> > 
> > framebuffer0: framebuffer@1d385000 {
> > 	compatible = "qcom.simple-framebuffer-sm8650-mdss", "simple-framebuffer";
> > }
> > 
> > and that the binding for qcom.simple-framebuffer-sm8650-mdss
> > can then list interconnects ?
> IMO yes (after adjusting above to coding style), but as mentioned in
> other response you can just get an ack or opinion from Rob or Conor.

But, this way we end up describing MDSS hardware block twice: once with
the proper device structure and once more in the simple-framebuffer
definition. I think this is a bit strange.

I understand your point of having a device-specific compatible string
and also having a verifiable schema, but I think it's an overkill here.

Consider regulator supplies of this simple-framebuffer. Obviously some
of them supply the panel and not the SoC parts. Should we also include
the panel into the respective compat string? What about describing the
device with two different DSI panels?

I think this explodes too quickly to be useful. I'd cast my (small) vote
into continuing using the simple-framebuffer as is, without additional
compatible strings and extend the bindings allowing unbound number of
interconnects.

-- 
With best wishes
Dmitry
