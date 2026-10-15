Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC44ED195
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054744; cv=none; b=bmk1kFNLNTl3Lrgmt3zdjhfkC5qNQiThWgDe0CUBssnDOBTPZFsvZBU/tbQZavpA/Agxb6rJ9muW3zbzvUzLLxFYD+hUzMyai1gW1uK4YdJ4Hiu7JjcNzI290WbEBl9oMIj6YtU3Yc2OY9mFrEIfBGBXP0waN4G4EKgLN+t7H7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054744; c=relaxed/simple;
	bh=CinbcOsRrU+weX/x8DlHfWVx496vQyqNGyiZd765C8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxuU5rXSz+y9zMe6OcPFx5HU2WVp5qWuRUmkzH0hRD+Q2VkRzNNIXfPE/zzio7aZfmSA/gh2WwZRl1LA5j0wl+kzWSEitnJlisg3UO9gjAwO3bHFy5ksZsiHRFm3tVFc2AL8sFkN39+XqlDNFzfTmodT6hcFqIjSjGjoh0ya2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RGifCXtR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hju/0/LF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGifCXtR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hju/0/LF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F8IAl1842056
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LN0Xc1GnQ+eoesbLJfJ1izlXw7BTBBPuCXZd6buDINk=; b=RGifCXtRCpX4F8XA
	ls0qBNylzApN/IOMej4NbtlqZIwB564QEKM9L62Lm+hEkjBplJA8aBEpBiJ8hVj5
	/LvJXWrPZE6q6QgzusbZ8WVYhBhpfrUmuX5HiuBYb/gyblPNst1XXhC29/OjnbwQ
	dIlhBXWyeVtHeFT0EFPVi259KbSFsBr5u7sOTYTXVPyS/Nqaikt72YijSSiRAIet
	VfuBB4db5E5RZBBpZpQHaoVVLjW9PabNIK32s4JAXcyaBbLQZFmFm2qKvZCo9Gex
	XVMRg2oG2RSjdGiayJ7x8v8jd/YinnFtvfUj1bYseyuK7kzTn+IvyFAlIh9FFFOW
	f9MKfg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wu4q5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 08:58:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91792488228so112362686d6.2
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792054739; x=1792659539; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LN0Xc1GnQ+eoesbLJfJ1izlXw7BTBBPuCXZd6buDINk=;
        b=Hju/0/LFuiiGAyyu5GFA1OywyD9sfF8ajdH5eoQf67zLfaal4YImfuOpboo60LkPU8
         ELif3udRZ9laH1H63DEPSU4RBCtTPomBTCFnnTyuCElSvfGhFZWr6I+wd5wHLxlWJ6YD
         d2s31+KbOhE6BUpUx9+vln4brCEtyFq3cRwwmz2ySgmLo9hlxh1Q91+TtdUqVRO6sZ2x
         ojmFUq38fG8BTh9laEv9lUuhswSayHUrTTWKxxAPl/ofFF64AtnJQPgU5F2xMhSyz3qj
         LvVwUyRY8NNCiWTFG+zZOdkQ//xrnkqmDExTDxPrLw/wQSOHXNBgc6PVPU1+v0BppO6k
         FfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054739; x=1792659539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LN0Xc1GnQ+eoesbLJfJ1izlXw7BTBBPuCXZd6buDINk=;
        b=e0S+wI+bRpokM13qPrr7PXxIx/Wqm3c8RpSjQZ8aRAy4/QrEE6a7FTX/JV4NLOlvZv
         OYVU3EWll/MumnCkuNQzOgRSi8dx/01yiCqHsKvyFsDzQvHHkwBHplAJzU12mNlzNcTl
         iV6ijdl3HECoxku5lSD4RixHsuNHcPIfEeFlL/SPHKt7XSlMqaWXM3TEkFKeHd7RFgi6
         ChFMU3Zpft3Qr2Y60SMvtC6tckrXrQk23/WM9XkGVuYq95diWZEJ5jpV6Lj7t1nTZQ1T
         +eR7+6zmH1RR9oIgBBM8xS71TfYEtlM2+W5OEUmPquzCrRsUrxastXcSsheWLzUjHBcX
         ZjNw==
X-Forwarded-Encrypted: i=1; AKwUvBwmoM9cKGbiKHaBue36r5O72/yrubWDdWmE84RAgMVUP5rd05v8fWkB0qmwfomx0y2CPsr+wDZdj/kf9g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKV5S89dw7vPEkOwuHA+LpuUyLb4tsQDQYujucNmWznGsSJliM8
	4uygu2SNMcBi4RUi7FkgWkxW46wtqS/tWiWAC1PPI+09bsLu3TUUPZDDRZDvLx1c8mvRBO2/QF8
	cv4Ti45Pj/OzskkGYBHDqUIz++o3F/hlwnY9jaY9SzbnKlzxKUQ12g10UPNRrU7gfHA==
X-Gm-Gg: AYBFou0i8Z79ipsBvZC5++25Q/m3swE1ohVmHOE6dd0qxSlWUSHTxUTbbZ08X3HSOpX
	b7HLLlVPJ5ZBhbKyyVg/GXGUmQtgBDJ67iTFiN3Q4POUFuGjn7HEkERveckf6mqwgWqvOovVHPE
	XsLHQXgJlAClApbt6RTz4xFp6fb8Fungp7F3a/dywCdYMPebLHOkYCwEattEj+mMTXNsGifCfod
	5jVK3xGyY9x8ahqkAD3PK1n1yKL3sbPF2XZiCLyuaGNBMs00uVLiyBmxmPclpOK6c5oI//s8IB4
	CZBiBG3CTla1rH8DlFCwdBe+AkRR5xD/MJ57FjGQo7QJqMfzHvZOr83EHmy1ViA3qXdibMakoPj
	RvhskDmVU/kA7RZJTvtYF1SK8YAuXS3BABNmXgZN/Lu5VpD9X8XrZWRReQasV4iWS+QHKZAW4Kn
	OHvQxEfHJWNLrS
X-Received: by 2002:a05:620a:4411:b0:93e:7ec5:2d65 with SMTP id af79cd13be357-93ebd20b8f0mr3005237885a.31.1792054739230;
        Thu, 15 Oct 2026 01:58:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4411:b0:93e:7ec5:2d65 with SMTP id af79cd13be357-93ebd20b8f0mr3005234985a.31.1792054738671;
        Thu, 15 Oct 2026 01:58:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:58:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:41 +0300
Subject: [PATCH 4/9] dt-bindings: mfd: qcom,spmi-pmic: add LCDB
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-4-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
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
        devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=903;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CinbcOsRrU+weX/x8DlHfWVx496vQyqNGyiZd765C8s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXEzPl3ITzxisJqsyw4t0pMlSYPsdLWHMBT5
 voOcnO3kOiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVxAAKCRCLPIo+Aiko
 1eF5B/9YLyJIm841SYHHx7rwcbc4xMrNlKQYxSlfc3LF159sdBscm4twCToMomUy2BcBEVMFUtC
 mdoa1ukOkMfZz5w/HKjj1PmtFbnLx/D3Bu93+giW3zgS6l2EwH+qUkGwFJLvkq9SFQ38TlRm455
 0Y/gSXgT19PSELm2mrxTbo+uaxIfBzJyygKhU9NiJpiCAzWLItkY3dSyIgc/joHWGNyfQatevW0
 w7F9C7B5MM/1cl9cVnPq+OHUZA53YXzXZN0Hnut1G2pCe/7ffN+9sSQvhddiU3EJEp9EfiNxeu6
 jb30K+1QwSzPiVqd3KR10oY9QwWmyp9OaUlg5gsPtE1jqJl2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX58ZbIkUY62v9
 S7XaZPrK7TNXJVKf1J6RT3Sjmb+KR735tQOyCZWWxFMz8X5wG1IzRWO0YymOG0noCtOIizZX5cl
 GHBTMO0YYtm7qgKCpmhC1unmc2wowD8=
X-Proofpoint-ORIG-GUID: lH4tDWj-EijKy4JfH1UW8rJEJ1eYEPD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX62tGMBCU1gGl
 QuPf92Odf63juzcmRQ4lUZix0JYD2ZB7CkUergLwnuiSJHN6jS3L94UTI4oW9xvr7g6iZ64jtqP
 qO59ghnlgD0dkbMCbkzYHkCporl8YlAVo/zlVI79L0eMLx/tMpT5eowzmk38rK5u8F5YNO4bU/q
 ryB/r4k6kTsmUBhKo2Que6OMwmjUW3kYyyQwELSarcGrIuViOxsB891K1LEqRnkUgmQ7YLGqYOy
 BFD3sTPgswFM6cJ1lGWaQuHcJ/RcUQgSyuG9s1MNc4JzYECEqlPNGsg9E+ebj7bjFwFjXbWWJFi
 j/PYTNdnfPvXoRTWS7qQbOJYbyClm/h3sXvJ5BMGmsrDZT794KNGuY5g/TihquD6Fa0WXYDyqep
 88d6suEe1NghbVbGktcZclHXuim7QyrKY0nr8hI56SIcvzt18JocpzfAYcPlXHCwKDS1H18yINt
 vh5GFeh0CRw3YlqhUfA==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad095d3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=l4xqpnzKx15mTiSKZogA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: lH4tDWj-EijKy4JfH1UW8rJEJ1eYEPD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035

Allow the LCDB regulator block as a child of the SPMI PMIC node.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index f6534e9e9912..1894fd82cbda 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -171,6 +171,10 @@ patternProperties:
     type: object
     $ref: /schemas/input/qcom,spmi-haptics.yaml#
 
+  "^lcdb@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/regulator/qcom,pm8150l-lcdb.yaml#
+
   "^led-controller@[0-9a-f]+$":
     type: object
     $ref: /schemas/leds/qcom,spmi-flash-led.yaml#

-- 
2.47.3

