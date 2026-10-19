Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B84BD7B6
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410451; cv=none; b=bIjtiWhMlspZgBaqCPodsDH8L8ekzcORvtICZ7YrnraUJqtiHL3Yo91dtevQ5OdgBPhvvXJ9zBM6vrhwMFUspLDwe1Vgj7PGXbEeSSA9LoRQoMRhEzwGuXHntOVSXgbJ6T53f8SMKJjOjK7sx437Rg48rxXhfkNovYh4xFUHBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410451; c=relaxed/simple;
	bh=y0Ccx45xxLYWt9pp0bul/0px2ejfDCS85zdyec5AYdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrNPR8BK5/Y/pr6ulNrLIXA2CZQEaZogtxSevqZL2ElQqDAbHwKCG/C8/NCN68lykowO9apoP/fpk2O9QTauuRlL/6NjS5KzvcJSsSrmZn8gJaDk/73DxUWm5Z09o2VQzq/GnObBdCZAq3wUcgrE6s3JaoDZ2Zrz/nv5jLXhLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XW/3WAht; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQnML2Vx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XW/3WAht";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQnML2Vx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P16t2041974
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DA19jX9AB0uHbCWwD9Zbkxsp
	a0JfxX+l+oTCDhGHnvg=; b=XW/3WAhtWkwvCLBXO/vlD0QZ6tpeQ3sN3MTurgTS
	OxtGoYo99+/xkRlscU80YeHr1FgogvIN4dd5HV/rt53OdWbEVSDqM3X4XbcG94fD
	gLYmZGjQu4xVzU4IEVSP9Sgss94Lre2m5cDmXuV4Vt3iz8/oq9leUu0DK/20x6tW
	Z9GvJfHnd43p27MVk/MD+s/hC7YyZyjyWLIMCHa2NKhW3y8jXGRmgE38X+vLPQim
	7/Y+9OqT4cprNevEwlJoMG2NXGmUbzC3DeditX1IbIvQVZ+vQysLMasPFFit1MOk
	ma0d6KgTKawpeQZyVjP7cVVFoIgtqWdZpkqE0gfRV0khtA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur2hs4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:47:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so414680485a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792410444; x=1793015244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DA19jX9AB0uHbCWwD9Zbkxspa0JfxX+l+oTCDhGHnvg=;
        b=KQnML2VxCpD+9VqQJRc4Z6MUJJCvyqV14h6THhyEY52oa64OrpoRDB1DzVNmoFQb8/
         HKTTB3zpVtde/r9EL69Kgtvms4+1zaL2pd8yXQDM2lOPiyOuEX2RJKbDNTlH00gTipNH
         KLKJFUqrFpWo1t8AAOtRdBCTtMFkNMyCwT/7jllV6UxoIC5yUA5kzkpBC/iDYVsO90j+
         /Vm/KV8NE2I4xzU6ibOTJGuhPp4FAi1rjvVs6Hfr3q2SH1HQ863JPxEE3tFSWk+0NjKg
         IZDqChhZK4yYDFuZwExU+KP4dp5NRryjLVWXJ9+g2iJEhW0UvyH9CdMG+Wge81pdXQCa
         42eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410444; x=1793015244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DA19jX9AB0uHbCWwD9Zbkxspa0JfxX+l+oTCDhGHnvg=;
        b=RcGHL1RLvghXP06YVYJSIAe8St7r36TMaKi65xFT0+28qMNd5q6AsucFfJ8IizSxZO
         JELIpS7v3eSNTdC3RH3Up1N27VmQWMOCGvj6GVp4QqnndfcHkiVobT2jdvzqifNdBq9W
         cG86MHYugkda964/3wqixiK/IJ0Xc7R9BLuTBxq8t7EM7FdsrdAItowVxJfjXrX9YEca
         O8TUd3I5amMU5dEogzQ7zrLLPfLyeCeD9FEeWuYvXG4Z7wWwLWkR44SOG5Fwisb5MmRf
         lbwaNbaTyqBS50Ttxjekv4J13rcEEERTFrxRV0iIqwzX5HArXsQ76c55fLr7+gCQv7hj
         Et+Q==
X-Forwarded-Encrypted: i=1; AKwUvByHueY1PVN9GN9hw9cRv1smO3s4BZSwV3NEmWiI9vk59ylES+gKRYvfbebGgbu3gEm6FNVmCMnubSKc/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKfCd8wWxTmUI/jO9ybQLV1Yf2EvHNeiuY6AKiboxHMnlgP+D7S
	qerl+4izcDSQs/QF0NIJfkZvVs6zJ/JttkxKrSVkF5K4PhAEBnKQquSL4B5FBqmbdzW910ClIl+
	bAECiEwWB5Jx2jelDVkJrA2GbnyDMkrPxJR2uPP/4YeDAqYwIG0+hKFp4PrNZ8xxuPQ==
X-Gm-Gg: AYBFou3RYUYZSsoBwSprwNh7+S1/CZf+iiODwfL9uQxHCma7J/hWxRouLIgaZD9+5+6
	Ote7JyaTYSeylos2VpEq5zJLmujO/kfk95Z/Bzy4i7TyIw7c+6Aik+usjUBl+MdOwn2ufNyHlqY
	Dw1L0RnVZOomtLN82DfaJp8OKjV4dMrUXfogeFcuYdMHHqwihvxKMYAZaiPA3A5oMa0WdJQL+M4
	UTz1REdTpBZ52V1PCNRAbYPMdPLyiYS3P/kRhHOY+XnRSl/OuXleWlk6aXrEZpo5XXtD//QUyUF
	Yv8byk6uCFpXkyVfdlv6orRmvM7Frc2NsK6rm5EVBRevIJIQ4irY0vEn5SLOjsFTrXhAElit4iN
	RJ0/4ip84xStFBGKR
X-Received: by 2002:a05:620a:4042:b0:93f:735:6c83 with SMTP id af79cd13be357-93f29da63b5mr1143956885a.56.1792410443622;
        Mon, 19 Oct 2026 04:47:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:93f:735:6c83 with SMTP id af79cd13be357-93f29da63b5mr1143952685a.56.1792410442992;
        Mon, 19 Oct 2026 04:47:22 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c575esm19986031f8f.10.2026.10.19.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:47:21 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:47:19 +0300
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
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: pm8150l: add LCDB regulators
Message-ID: <gcsjw73m5tj42ftvhyckexor62waf5eydntycyy5qm7ubkesn4@qgr4ratyntfw>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfXwiasz4oIUNmi
 9XlsilAZlS/Ub8VFR7O9byMYzzVpjQdrOSOa5s4SU5rB+rIszc2/Df3oWwWG22SZ9WE2qp6UOkL
 IOusHT6dw5YSX+nmsxnCw3RITmM9pVY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX2sUa02zJfcrs
 4wm3/ZhijU+xd3NuwxW9DM/YHz17c9BAa43vGR16KhazUuX4UcgSw5j12ffVdauHMS7n/RWL2MY
 Ub7qY2VI4I8C0m3XdkYiQV/enBDGpsDyQrn7CtemqI/p8AO26qBeQWVIOSmde7PbB1aE5nf0Cre
 TxFiYnxkzURSBr6CUZwduSCU5k0fFTP63qmTWSQ7ddBxvUTmAPMEtBhJQT0wohUO1MbRyz912L2
 dAnKcTJyx0eBJCj7VeS2yei2PLD6pNf1zLrQgexB5uoxdB/k/tF3+cQA2EWYEeQVZpAkWFCrpOp
 CzcmIZkatn2V1x155unY1iJUQwtqjaNxvz1u2jhVWxtswzdkXxkGOpnE0DLk7isvkQSGcrvKTck
 B8BN1Fms2IvQYO8Teg8YqxK5eLLETVEWRp6MFWSn0AVne16SNy8usii/AZ1tX71MwnFhYtJ642n
 9YxOFEzjdSAZ7VCZAyw==
X-Proofpoint-ORIG-GUID: 7CWaVMprSAoLIJvrdh-srqk4EiP3pnqG
X-Proofpoint-GUID: 7CWaVMprSAoLIJvrdh-srqk4EiP3pnqG
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad6034f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_xPOIdEwXcuG9LIM0_EA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190046

On 26-10-19 14:25:41, Dmitry Baryshkov wrote:
> Describe the LCDB block providing the LCD bias rails. Leave empty
> regulator nodes, forcing board files to provide correct voltage.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
