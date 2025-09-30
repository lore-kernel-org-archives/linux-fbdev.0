Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723511A83ED
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Sep 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262783; cv=none; b=hYzohhYhI0TZLH13jqwiuuV+4A9eJYnzm/Dc8IBbCwav7rk8mXdaoUMZFi7DRR8JiwI0i9sPCdWKkI0N/nwRLybJwSqUw1v1DOscauIJfDK6WjNgI/1SXButWVsYfUS7NMqsRMWcr3O2DYKwaRmMAFQukoAjh9Zo8jQNBLfnX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262783; c=relaxed/simple;
	bh=uXkF/ihhwXZnSvOZ1vZab5GXRver+3TRBZj8qTXUuuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMkACt2T80TWwTcT+dNfW9P/f2mVR2wTklmsko99/mWMph0VW7NrM7T8nwJ8DNCkdVQ69L34avDVMz6fPXeUMIoZ9dpcNFCjE4/ugfIeD5vAy/fRnv0A+MplP2nXEUBhjG48hkgawZUYhioS7Js0nKNKhgXrmMKXwmwp+VrHPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPAcwORD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPAcwORD"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBWnvn009452
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Sep 2025 20:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nnCDWQBx3MEUkPGk1nPDrYBk
	0/iZtvd9WsbeqrQ9y0s=; b=pPAcwORDhNc5V5kCVRdy1IZmLTHcRoUgyba/fmd3
	LsdcVm9mBl23+/rygXKXLx4xTmFejhl5BRVUieYfVrucQZuz4UUt1acQc6HyTIyO
	RPqAXMPfwf7YaC7RTcJr4ZV3JkbbSxBKxh5pPWHJSWSsno6VL8fubM/sxLmOXb6M
	lWHGcrG0XGpyEMF1ttNJPNALUy6c1JR8Qk24PVus9lvJdbntQaG2hFR+Ln+FlgUF
	AyOiJsXXSybd3jMHrCKtl4KLiRcraBsEtSM4sCTFmWu3LWeBbK5TpP8rLv+3bwAG
	By3BP5CkBKpniG/bunzzytaqAcm5eQROG5ldQf3aestZ8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977t3ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Sep 2025 20:06:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e002f413e4so38929941cf.2
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Sep 2025 13:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262779; x=1759867579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnCDWQBx3MEUkPGk1nPDrYBk0/iZtvd9WsbeqrQ9y0s=;
        b=YyLhiau8qos3KgDlN46HW+F+ejkqxaoulBjv8CEIz2/EI/Noe6p3HUSex/dxIASx1e
         IfSGPmkayo21oyi6m7h81iNr5Mu9tPD8QY3RertQ4o1s3fp2lzmpu26W9KkZfh0ltJzV
         5K79PD+WRs3ry94QDji0WyDewMYIAFDaemP0ZUTAnRfhAHnbsyyn3cEU8XRu2J3Nk32E
         CgRchOpsiKQY6KmKqpJhNAhQF1nexOCPiF/QsG9GMgGJqTXiaaWbFSDtKfs6d82O1o84
         nBf2j+GktXmwjYunzp2EVaTqrOSn+19XyiXVTP8tUYIZ0P/5GuEO7vpoTrgZNYpkbMSO
         /vKg==
X-Forwarded-Encrypted: i=1; AJvYcCWlm0aYO3j1ZG5CCR2jtksiO0sV9Y4Mv0a0Tc68xiBQj91Rv7ugokLKm15211YibY5i+qfk0tSBIR6kng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNDvXY0wjK0CtBWPosA54jbtom7WUC5KAKrL0x0/ihJ3YdZWj
	tVK9xLZH6B1tXJS0HDzBNceReopTmPkSLEAfykn29IfngDsJHEhxVG48elJDLivTWCe4DptzybJ
	EcCOFXLFJQaix7HwfovJsHW3H27D+hgAbwt4LrFEMEHpvs3moTx35Iae28AR7kLGjsw==
X-Gm-Gg: ASbGncvCp2S0ZiyMwnHG4995W82/z60RqUegybG45hwQbO1lR6XnsJuGNDoPiHS77TO
	adjqV9ieGFYohiw3XgjDa8YjwkW/HqPW2QtspldRcTfylrjMfGWTfsxsmLGMKXFYvnVemarbV2c
	zbZm2FyfkYl/8Z9ZwOsKt0th7OcsHfW/MrFqkzvYg0dHRmIOgraJDyqYvLq9Ksf94CgPc63V9ZQ
	DbifLsFfWUtHNlQy/CmLjwotp/FuERMZi9JBgFwN8f1Vk8DtPft3He82xChEjhIY/yBDkhZPmNC
	5GQctSTq3JKCDH0WBZoaS4TguT9wtg0M/IxhMIMO+qmfRg+HxTAHBdJXCcxWEvWTQC/l1YwucAN
	Tl6tjH03/oznJX1AXyqsyJzclSGkCsd3y6wRcgaL9pKvEdvXKCXcxmygMQw==
X-Received: by 2002:a05:622a:1f06:b0:4de:8e13:2ccf with SMTP id d75a77b69052e-4e41ea169c4mr13229291cf.74.1759262779101;
        Tue, 30 Sep 2025 13:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAC+gjWYrGkYGyC7iuQx0n8IkXtiwE5ml3GBXLD2rdjXMDvnTqbMjAoTH934KEvOlO8Ctyg==
X-Received: by 2002:a05:622a:1f06:b0:4de:8e13:2ccf with SMTP id d75a77b69052e-4e41ea169c4mr13228591cf.74.1759262778420;
        Tue, 30 Sep 2025 13:06:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-586048c815asm3037274e87.25.2025.09.30.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:06:17 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:06:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] ARM: spitz: Do not include <linux/fb.h>
Message-ID: <atoda7fiaw6xxc3arfg2rvczt4ezhravwogbshvca4dsr5kjqm@vjj32eqjxkwl>
References: <20250930112651.87159-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930112651.87159-1-tzimmermann@suse.de>
X-Proofpoint-GUID: UtCwj7gG5PlVQVakye2Feu80bfybgakh
X-Proofpoint-ORIG-GUID: UtCwj7gG5PlVQVakye2Feu80bfybgakh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX/KyVlLnX5k/Z
 o34WhU9BIgsbJ3WVf9pYTKeRoUbce6Xf8b/aACKNgzsxDyllxFr9/woOdtM0NvTwJT+y47W7mdj
 Y11AUIWhd+Dy61A8L299BKEg0arpst8+u6oRaTWG8BjxcbvtBfKZQd8Dr4fNIFEatL882/qFEtW
 la1CIKLlDYVQKjrfMCQHtTdqQqU3N9hQXSObRHH3TImco/2/AvpYyoYo85tnOOLqH6gxhcWpNwW
 kUQfqO9psjboKmBlop6daMrRcaFzmBuc+Ey1GkTaw5hm0OCRzdoUHPIL+eWdjvlCzuDZ02Z5IwO
 AZf6L/sBYXx08dHNqRwo0CfHiSgo6vC6ve8e8X1zO9m2NGT7ltAWH2JsLz/K5S3tYmQ/7LKmRFg
 /UIDKC7iXr6gdXxV/h3rxUDtP8FB/w==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dc383c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=al7qi2xbfAQSSKGDXgwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Tue, Sep 30, 2025 at 01:26:46PM +0200, Thomas Zimmermann wrote:
> This ARM architecture's source file does not require <linux/fb.h>.
> Remove the include statement.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/arm/mach-pxa/spitz.h | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
