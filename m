Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55144E73CA
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409530; cv=none; b=RTzDDYZWJI3HUOswjaKo3piEr4/fm4C10/HWQjLlCjhrQIHLnv0zP5PQpT7PCLvAZUWv3psPNJLEKwNODHiv59LL8+7byYgfmxw/Gn9nfdsxscnXnl3g2w8eAwm8IftN8cX57Im12YoBdTdQ+3OH2TrybrD2vlURmUDDIzYbzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409530; c=relaxed/simple;
	bh=lwQQfEh9nOqhpblPlramWU10O82Qm2G3izaI5hHN9R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2Fz+PcwWrjDXOWWdF+OwUbS9kdaPbkBkGT6UaQ6jddGCxQ4Il0gclow3j5atHDfN1KKQNezyurZNxAZPBTrZ0MRkGQSokj/Zi50zsBlOpJBePy8Nr4Ua7J9Fql7+dxHI6B7kFTC3JN15CPv/NjZqh9eTNbQ/RSj6gJN87fi9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTDo3FLr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iakHDYG4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTDo3FLr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iakHDYG4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8OuFa1348224
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pohp5mV7y1QLZu3exMVa2FPIYN+bK5gJNyDuRfvMI3Q=; b=RTDo3FLrGhjc/gZy
	n9Glp4xGxq7EJQEmcX1CiiEZZxn9jiqfa6PgqNIScBlelsdwbI/OqFuP521zGQ24
	sPooiOe25IeGZvNevJlSmbfEBn3uP60wQcWomHSTfYosxV7WgnANn5YazYR4wCO/
	hwOcWMMaTHiZAMPdUdXZruWtjRujJhyks+dyQ0KvMnH7EQc4GTBEVJDHbWsUgmWI
	gU0QAVjU2any5x0K/exh2z4mCUoP1R/zW6MMJeWFSILCCAcAA+HMZ50SAvMnQjrN
	NbU7PqlKGXGPkCxB5ow1R920VeVDCryDIoWwoMPBWJ2UltbyoWArBcwDZRzsREsm
	e2qUow==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgu5n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:32:07 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eacd73e83bso17394e0c.3
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792409526; x=1793014326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pohp5mV7y1QLZu3exMVa2FPIYN+bK5gJNyDuRfvMI3Q=;
        b=iakHDYG4vMtBHmj2yC3gRRWgIXMF/XTRCHP5bVs0GEXABg1GexTe05n/jui93hbWP+
         xKjHTm93XTF7jC1w7Ym9ohglRiFTJ21iLVFtC3XY6W2jDcwEOWsoXMfsbtHYrP5FPfze
         BidZdVKwP2Pz/0MNNjj1hzbH/98q3Vhjrw8bvmSdrFcQ+dtF5BK2/x6q/eSTtjAx+wnV
         tNBAhERoQSA1GzXQWA6LdaC/DXKKhKxLtbmeKsl+sphOa/PhhstbC7JjxzlqKdPxcXtS
         jbTzaB2pvGhMIsH7J25i7hb8o7Mv7sdCzSpgLum9cfIVEX7t7JXWgKWljcj8s6a8ljuz
         lI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409526; x=1793014326;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pohp5mV7y1QLZu3exMVa2FPIYN+bK5gJNyDuRfvMI3Q=;
        b=h12e0uvfRhsWFqiFUImdpWQMjo45L5zFCP6GNXJ827S0AZCWR+bfQzLXvD56NMSngF
         32ka1LmBAgCZYnyyiqXgiGYmHH4wc15JcAszACTjcILvZFtJLUTN1LELj6iIXIho0+uR
         IGppeMZMJUeBSaP0mqtZB4Ft6ooVvibhjP8SpM4L528sHXnfQW0dkItKxfRDWRo4Bpji
         p5jg99/nU+Ue2B2j0BBYEDfhQLoayl6lfOUmlV8GJn54p/Io5sSSbUdS/Th27yZbCP3R
         wczrPDwh50ucYqs8tlls/SF/6Bz91X3rCy18Kpoow4szb19HNLqdXOL/pQj5dB6alOS2
         w7fg==
X-Forwarded-Encrypted: i=1; AKwUvBxzuhBaeILMix64Lqb8hK6dps+Pvt4Fqm7hY3xUPgYqFCsCUvBW5upv2wPVe7Sdg+e0V2rdT/pk8if4ZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLfv+XMoZw6xSjx67v2IkMegct/2PEhvaLIgP+eOWDoWaFbhKMj
	n/KhqC3eJBZgLIllpzaDZb7QrwKdTHsbxc2Ph1Gh/eJSOzUrwhaaXmO/QuNMczlB6Pv3kA6hQK1
	53W6OqiCNMGWkDH/gePyqdzH3A38X1BJq3qv+wKNBm2keZiQux8IT4uEhBjAR0Hqs5w==
X-Gm-Gg: AYBFou3LcLew93AGwzWhO3+mE9vcwz9tpLDS/5RnHEJNZV973LSgKK+Hq0pS0hg35vs
	iHZvFVKOxdguGaE0+Uew8LWTyEgHGwb/zQ9kRicIO4eiiP0fjD2WklhQ9heLDZK3jfbN0Wt27L+
	sGD5o6EJ3XcT1AI77C+01H+JWBO5gbJmjipoudua1NfakUfu2qknCGNaJk4AtxnccrOKxyXN9DD
	Nrds6PjjFOKLndIfVrkWUqdV1wJXRWLzet1/TxVa+zl6BLmgjTo6gE3SNA6zer7vcQ3z+U0+kMb
	89kVte6Uj+6B5fRQXmzIpa6X31etHfR73LVxRFrkc4ow0fjq9VycXt/0C+GqaNpKHSeiHX9TkqU
	2JTVUUmmEJQAtBPzSCWCU9Q==
X-Received: by 2002:a05:6102:dd1:b0:7cb:fef7:3763 with SMTP id ada2fe7eead31-7cc36973b47mr1277912137.3.1792409525976;
        Mon, 19 Oct 2026 04:32:05 -0700 (PDT)
X-Received: by 2002:a05:6102:dd1:b0:7cb:fef7:3763 with SMTP id ada2fe7eead31-7cc36973b47mr1277902137.3.1792409525489;
        Mon, 19 Oct 2026 04:32:05 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c42554cf6cesm217763566b.36.2026.10.19.04.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 04:32:04 -0700 (PDT)
Message-ID: <e91eb6ff-1d7a-4295-ad57-02ca2bd10411@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] arm64: qcom: enable display card support on SM8150
 HDK
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2MEdke9u3buXHMoJ9LVkjlNlvXZcD7IC
X-Proofpoint-GUID: 2MEdke9u3buXHMoJ9LVkjlNlvXZcD7IC
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad5ffb7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rzYBljbM_JLXBvC404AA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX5NIiszXDS2tf
 r4g8ivN+odcQb7r6/wnwt3fLydXmIFmOlKuQvcGMW9JaAb7nKLUxyD0DJ+EZzP1x7/0B98O95iw
 QlmfxC9ihgVBmOmr8F0H6Rt1b3d1KzDIl9/B0wv9CizKd78KN8xka+P7cOVJkaWCPFFZEmNLrjg
 lrZcfX6lojmO9Ci+RLmfNUFCpbr3/7Q4STgg8JS20mz9g5lPcdkAPupVvjW+0GX8DrlSLeuJQTo
 KGT76vCmyKN7so78+CCcFhAWPxjx2oaCsj3iZWw2T9iskfDA/s3c0EhmOuO72jgHoyrUk49yz4p
 VEYlZn23hPrx+LiIlJ4YvO4qL66QtlyApon8aDXyijfk2OT+jfnQDt2CkbpWB6X8+KcFfgn0Ymi
 ioDe+MyX3wl5TvgdFcHR9Q94X8qaUZeT9oj16kG1jFAGo10XSPDo1cPRQt3uEFciXkaOvSBfrWK
 IQEf4U3UoYzx1bpQxog==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX2nHov8EyqFfx
 TructOEPYcwcTCU7Bcd/8iPoh/QY+qyl3iHbzjIFUaC4Is2o32nQ09H1tj7hjfniTfBVZeBxRsq
 RGYimWwNeq46sluhPLNRlzge5iy6vm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045

On 10/19/26 1:25 PM, Dmitry Baryshkov wrote:
> The Qualcomm SM8150 HDK can be equipped with an optional display card
> having the same panel as the display card for SDM845 HDK. Reuse the
> driver submitted at [1] and enable display card support on this HDK.
> 
> Unlike SDM845, this also requires a new LCDB driver, providing voltage
> for the panel and several fixes in the WLED driver. The FSA4480 address
> fix is independent and can be applied earlier.
> 
> [1] https://lore.kernel.org/dri-devel/20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com/
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Dropped WLED patch, duplicating one of the applied patches (Konrad)
> - Rework the WLED auto-calibration patch, also dropping the reviews.

The latter failed to complete

Konrad
