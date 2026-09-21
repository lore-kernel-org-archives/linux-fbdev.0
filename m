Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAEC3515E6
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990015; cv=none; b=ZcX2z+1h3PUmr0uWCcXWyBMVp/FckPVm3qhE3tvq34ud5fa4o90bzx1Oo/pxaOvbkb8+oEkv698ja3J15HUTaJZFjBaxUCoLnjeMgKS1eL6rj7ZZm2GVZFvi1L6Xl1zvNG6imv+liAb9CIgwUf4wFOk9coQjcMLQMGvGeBUae/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990015; c=relaxed/simple;
	bh=NyFEyYupsQqC9FmnuAyHOciufETAcPql7I1A4fZ++VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMyogxIUxgq96kh62yO2XSCPfRFi1OUIaHJ0ziuwJyhX/kKVH0LI1SyZAiEYkrrWmwhSVstMuyY0+h+YRb1zVwBAnLUNDjMQwGCdEPN9BeeYJRR0r99p6kCpLOsIx/TR32G766j4QpbwA4CCw3HWRM+ycVOH2iUnLw/JVp89VJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPzYissF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KLHOiX6U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPzYissF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KLHOiX6U"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAduPo2091278
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KkPM1XLiUoLDcoILla1/Ubfzxgq/Q7SN/cfaDwrB3vU=; b=hPzYissFujvFvApm
	LTP03tiCFFSqKHF5DMo/Z89gQ8u97eoJajej1x/qCIKrjh6a4t6xL1a+GHt7y77T
	yIxb9GgmgkKVyXheCd+ex11XzOutJf9ajnurggZFzCL5GLd2lGQMc7WXeU8D4YVq
	QD68YT9t+GxhE3RiPQTBg5YYesDefbcOJoV+/amkUi+hYjK/w+Z9rkS45/E23KRR
	U5KGw1OSqr853cyBqb24F769Yrf51AIHvtAD4GRVXUxSkrIlnHCFkQzDq/hIRnjN
	ihJ36tBIWgX6qmHDbVGOZ4byTWjZw4w8Tk+/SVnpXdufzx2qqN9K160tP/LXy4/i
	8hdk7g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wt3wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:26:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90cc288296fso4453016d6.1
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789990013; x=1790594813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkPM1XLiUoLDcoILla1/Ubfzxgq/Q7SN/cfaDwrB3vU=;
        b=KLHOiX6UBloNzvebpjXur2UCpKy8nTrSXxYaViHmAwjlw45scH75TgLu2PhAocq0qw
         l2jzkbvPWSLvdzVM2TBhT4U/CvImHaNUPU5kaszc3MyQaBlPDmxKntTxhkasUdnr0RAY
         IF+08JizjiRXOHYx0LKFRgKFp/zLfSlHrhQK/tnq34foYwtbaZkw6VUe/Be8dGzlDeAA
         bNRMUSnQyeMhy4Xr+J3fwKHGtYB1JSmLj/3AhNiLxNXjpNqoqk9Jh5TM6fd9YEDLcJEq
         0EooBoMoivmt13tWggMxjUzdK+6j4GwWcF+UesiZx7r1aug5yjnS7kmEospgCUUEYrcY
         22hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990013; x=1790594813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkPM1XLiUoLDcoILla1/Ubfzxgq/Q7SN/cfaDwrB3vU=;
        b=FspFWmFQMaupTejO0JMRQ3NA9edCaWCVTwXTUDjW375Eo10TCYlXZ+/BoxsZjOwpgj
         OGCLNcT8JVt7PXMVdNxw1MSb/bU9gzcJSzjoUWgdLt5HhNflTuJwVBDu7luz6xzN9jsI
         KEWJssPBCXqtKFy484ABWI/rF/zAkMNdxQDVKMZCiKWbG2xzSP6V/mtqo6Vg0sAXn2HH
         BfL5eL/1p7gkJF0PZsIM2SYyVO/htK5dLX2mtOMxTu73n6E9kfiMLVr2sdVRd9pWwcWH
         Zi2U/yOBKrgpiOlhuNqLHEyoQU2dDP/2tFCLq6F/WORldgREoAlrgB5r+u3lM/ZvMuo2
         Odxg==
X-Forwarded-Encrypted: i=1; AKwUvBxY51m0Tg4Ozp2tcHSt7Qt0Mm0DlWiv2AaEnjHF8rccdtM5nNH1LoNV/6WIhlKNXJyg5Lj6+i5DCzdNhw==@vger.kernel.org
X-Gm-Message-State: AFuF++nvs3XoGmHvwGAX4JYH2iEpdt6V93GHv97J84tgk59z22ID0xUo
	wxruzNZiZbACHogUb+49dciMqXX9/T1k1GibieH1QgjGRmuLuJWRAWpWm2nMDeuvPevht8UFVfg
	ydpDsXkH8W2RDGqaTXDJ2rAKZuiFsOWGLZMQCl0P/sJ0BvUlbEJfym2u4M07EtykO8Q==
X-Gm-Gg: AYBFou05wfOe6VOphevBG5lSIbagKKXIUACnqJeA6My1lFM45Dv8DsLtQrCOnB4d5tu
	EDU7qrI6vG1FpfzgSrfm8PU9PnWoi423ZPk7gANHVTwquEfN+V0n/s1oYeqDqtbkT+WjCl6J4Y7
	gO4+FwBEb6N8TInyVByWBN8r5k532/jrzpb2ENViIaGu2UTzB9KVvYKtD6LcCTXsAn7EwQvYGSi
	d343fq4rkJ5q/5wpNd6ZDB3gI4bf4kB7ayiiEMXvHW/Ved2F4WfkmzjODQKZUkvq4Kdv3+24zhz
	+76Y8HYOQp6ThfBVHUbBFpBgva/A3q1U0oLeG/hpzqXWVI/f5AJx2bvIi14F3mfDGLsA1fYqjUU
	uP+Qgl4fw17Oq9RidWdaDFA==
X-Received: by 2002:a05:6214:4b0d:b0:90e:969d:6ea1 with SMTP id 6a1803df08f44-913fc8a2523mr1004326d6.1.1789990012670;
        Mon, 21 Sep 2026 04:26:52 -0700 (PDT)
X-Received: by 2002:a05:6214:4b0d:b0:90e:969d:6ea1 with SMTP id 6a1803df08f44-913fc8a2523mr1003796d6.1.1789990012168;
        Mon, 21 Sep 2026 04:26:52 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3523a063sm282442566b.8.2026.09.21.04.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:26:51 -0700 (PDT)
Message-ID: <fe437142-eb1e-49d3-ad3f-704066bea53b@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/10] arm64: dts: qcom: sm6125-xiaomi-ginkgo: enable
 display, backlight and touchscreen
To: kavakliyigitcan@gmail.com, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
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
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2NSBTYWx0ZWRfXyZfmAYL6SX76
 Ex0Xd++FFS82yR5GVsrrs2a6qOW/bQ1a4rv/i9MIPTLdXRpVGITdPJrRXyM4idvtBH8KEgWh9eN
 VPizFXvmq2rNJHdOIb7U+tSjg16MWdRr5naC6GsBwk90z+VrXZ2cLU3nJaIoiy1ceGgGX3oTzDx
 WK+tSVqosiITP86rsxmhNN9dXK0hxy8UuXQcYYBA+/kd2XZ39yS4Q48/LyOLu18c7cxMHK4C2Di
 798DTCFWX/WH02Ikxt6SE7ZtNNQgDCxtmRcHNuYOSK2lBHERe9TbsVNe3iu3zZXuwmSuPqO/QF6
 5TWcqFauFg9+nugnwlLhKd224GpRYZkSOggiJZV/Ki3MrYGxwse3UpUiikg9NfAKGkGrc4sRYfj
 F6i7AotEFflG7cEfz4Skt1eXW5yl2OXVXbQ0EvvCBWkWE7/EKtdIl7BJSqh7FJ1pDWGmfw3lrOO
 IhWMI2D5+lrkPzAGbBQ==
X-Proofpoint-ORIG-GUID: Q20CSPQBD-XdmIIodUqrhlXr9s7OxYH8
X-Proofpoint-GUID: Q20CSPQBD-XdmIIodUqrhlXr9s7OxYH8
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab1147d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=1o3L4E6L0XnED3g1xlMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2NSBTYWx0ZWRfXxVJFtz69r6KK
 SALQ9jzXYMKI1wivs2g2Iqo07hYSF7RIxbMwSCVF+h9ag5vHai8oYh0zP3OLYoD2X2fnY/QSDwR
 TNww/MZwXDh0gU8n8nUHkw11fNXMSlI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210165

On 9/11/26 10:51 AM, YİĞİTCAN KAVAKLI via B4 Relay wrote:
> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> Enable the display subsystem (MDSS/MDP/DSI0), Kinetic KTD3136 backlight,
> and Novatek NT36672A SPI touchscreen on the Xiaomi Redmi Note 8 (ginkgo).
> 
> Hardware nodes added:
> - Fixed LCDB regulators (lcdb_lab and lcdb_ibb at +/- 5.5V)
> - MDSS and DSI0 with Tianma 1080x2340 FHD+ video panel
> - I2C1 backlight node at 0x36 with PMI632 GPIO 6 hardware enable
> - SPI2 touchscreen node at CS0 with GPIO 88 interrupt and panel follower
>   reference
> - Touchscreen active pinctrl definition on GPIO 88
> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
> index 59042a5937535c4acda064fa0f865f4f5a52d01b..f4b9e2092a814e56cdc23218025cb4166dec110a 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
> @@ -26,11 +26,30 @@ / {
>  	chassis-type = "handset";
>  
>  	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
> +	qcom,board-id = <34 0>, <34 1>, <34 2>, <34 3>, <34 4>, <0 0>;

This should be a separate patch with the reasoning for the change

>  
>  	aliases {
>  		serial0 = &uart4;
>  	};
>  
> +	lcdb_lab: regulator-lcdb-lab {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcdb_lab";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	lcdb_ibb: regulator-lcdb-ibb {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcdb_ibb";
> +		regulator-min-microvolt = <5500000>;
> +		regulator-max-microvolt = <5500000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};

LAB/IBB and LCDB are separate hardware blocks, only LCDB is
present on PMI632. It provides a pair of pos/neg bias
voltages. Looks like downstream has a driver for controlling
this block.

Konrad
