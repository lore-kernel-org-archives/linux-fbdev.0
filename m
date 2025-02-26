Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5B221701
	for <linux-fbdev@vger.kernel.org>; Wed, 26 Feb 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583893; cv=none; b=TD/DezywQt5lrVj6o5j7Pdqe2GKBArbCXnL0QerRkQl/OG0YbZucqvpcl3RMwd0nA98Gc1e65ic7S2Ql8Odn1lo+XBV8yd8L+l8n5B7dAG3dNRv/ZboweOebjMudlzNhRqYaeBdPf1c4HA4KTlrbpxf/IdjxC8aqtzxe7NI8Be0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583893; c=relaxed/simple;
	bh=k4N0XlmGvdfOMTmWDEfUUGimUOVDhSaHXWbUuCud4bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fpMXNxj6MTVeTfRS97EdqhIKSicwpuvlLQV4xOu+EFSIWAuG7CsAiSfRvO2VhuxOPv7wvW0jQvU0PPlBwPwoz85U9eU8RkDnYdb9EEcazGpOIVTMPATof4Oh9PKfKZAQ4isb/ZGNpmuqsfsxBERA4lM1LGYvCGTT9OHv7th03kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ylNlPRPe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylNlPRPe"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbac134a19so1061530166b.0
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Feb 2025 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740583890; x=1741188690; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqAmajrUkSWP+RSh/qNpOLcasBUoO/Rx4Ka24d+ReWk=;
        b=ylNlPRPeAKQtHh9Zt1uTQRSYCkoMX2oEjLTHfyBeWhueH7An0ZAcv3pZQ9Fx4H6IlE
         /LbjgBqmdXYkNFM4RX/nJZepEMrGd7k1Qr4pcK/E+lHdHcOjNYLaFUy8S/n9q3l609C+
         jLN/k0gdVrT6OXjcbJEihV5YfnmoUmF+fn6jOWQr9Vxh5+dSEVish2sS7uiex6KmngRi
         /LWx1Dz1McZ/afnLwagyLAT4/w2uXl3KCF9un/7c4A7TEbE1LzNcvNZnRVZf9Y4KgYt4
         AgQ1x3DzKkfi1j2EXRAvxVozVbVTSThC+S4EuYp3K7nK8ZSQFXQV1Rnvz6tVYwQ05YmE
         pnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583890; x=1741188690;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqAmajrUkSWP+RSh/qNpOLcasBUoO/Rx4Ka24d+ReWk=;
        b=qQvdKJatHpRxe3S2JTXJoNOk3W2hcsOVmcxJfsETNfSDMDPNt5EC8vHAvTKLnVWAqv
         EPzR3/OVk1bsp9vVbWHYsJyRkSHmjyjubW4vIcLp6E5ga+GdxysqRs54Dbntg5F707LM
         Dmmz3RKX1rhqPwCJXTstXOpfr9I882QqaGKh4Zr/ruweXmf4EGQoMJfBxFygq51TUFXD
         oxKwyOb/PBIhyOpXI+xnPTCVvUBO05QiboV3A7nZ+NCu8rHDBGzzGPsD9FAJDqDMvhj6
         lCGmH3g4Wr04jfanBKUe9L2qTr5lcc2MR/8Pc07r/f3hyiLz7ViYJWwUNmTE7qPSHwFs
         b9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYJXocUQ0QhUqQWo4HMSp/+Mp1ODOvQb9LpPUKWOFJVXS8CQq03ObfvkwSlNWwkIbu1nahfW6rEcQryQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2SawabFImIdNMoRCv5/VpAwRY8dcxU6OJNhciJyySVPtMu0K
	BgLmmXDlMQlxUiTWAcTEhM+A2xGOvcy4/NJ4aGFLYLdhypphwJ+XyfhaIAoVIKI=
X-Gm-Gg: ASbGncsBxAmC/qQsymqO9yvIOwPRIGCu+i/oeo/YZUdtPxGvjwIOp/sSTGdto02UfrE
	dyEjVnkQU0X6NdLBM10ukGw35EiiRU8wCihK0tZ/N4GSiblEOf7HqlyQKakFPrQbBjTmaqNlO3V
	dxhcsoou8OejXQrd2CR9CaWbSzL3a/ikSrqvFIHqxI6UUrnBLfjIf+CAk5yW73YIs8P31lBfPsq
	6g+IjTLHKh0ZfBIZBVQNSZJZjRgASrCA8vOAqLEJkvmQiJImm9PXeIkKcRZdLGMwX5iRRpi4KcT
	YcDp9bXgKdlYrlZB1MfZGIHY
X-Google-Smtp-Source: AGHT+IF0ukKgt11J8m92/F3mriaR7AMU8zhdZvDGdYgGmsDEjZlnfX63CFS/1zLHknAiaWI/zdCNdw==
X-Received: by 2002:a17:907:94cc:b0:ab7:f0fa:1341 with SMTP id a640c23a62f3a-abed10fecbbmr789811466b.56.1740583889548;
        Wed, 26 Feb 2025 07:31:29 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdd82fsm347594766b.16.2025.02.26.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:31:28 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 26 Feb 2025 17:31:08 +0200
Subject: [PATCH RFC] backlight: pwm_bl: Read back PWM period from provider
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-pwm-bl-read-back-period-from-hw-v1-1-ccd1df656b23@linaro.org>
X-B4-Tracking: v=1; b=H4sIALszv2cC/x2NQQrCMBAAv1L27EK6oKjXgg/wWnpIk41dtE3YQ
 CuU/t3F48Aws0NlFa5wb3ZQXqVKXgzaUwNh8suLUaIxkKOzI7pg2WYcP6jsI44+vLFYIEdMmme
 cNnRXs0KgdCMHVinKSb7/Qw/PRwfDcfwAI/cPvXYAAAA=
X-Change-ID: 20250226-pwm-bl-read-back-period-from-hw-08226cc2f920
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-pwm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=k4N0XlmGvdfOMTmWDEfUUGimUOVDhSaHXWbUuCud4bU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnvzPErP7VvYpWIiwM5iOAh95Cl7Of3k5CJDYyY
 tofqZ7znOuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ78zxAAKCRAbX0TJAJUV
 VpsBD/0R5b7F9kLEtwbwLoSttnGFhMw8cAjfYdA10nLSwkzvBDW4C7Mkib3L8buwyAi6Hw7SQj3
 LZmlKHmppMYlXI0n8HP3d+JzOhACkZUXIlQvmOt5zthhRxY1rC2RZTGbL2VoFwR18edWyWl7xu6
 BTJKr1Pp49cScIWMfZkLRKtvrcwn6bUx/zW9iMKleWEu8ZlwTWvH/t7jSPPHqSOGXpR0By2dhtL
 CuEVvNdeXkqYAECaiIaDUh1P4H4sMVFHzE4370KM8SH3zYmpquz+9RnrOEZhG0hdfygqsjd3dtB
 kSY8K6nH4Zpg2WbNDg2VXmhVxdWqMEjyC/FfhxlEv6QDIRFl1vBTfLj1wXml9eN3pMwNEQPje4n
 7i3iULyvwcUPHnyfABIIo2IsZAJyzy9zipJ9r33u1zD5LAbFaVrETi+EExBcXAzfFEs5yD1Ocpp
 MnrkbT/QwfdB+Ef+VtsFuOJAkgNDpBhm9dZlI7B7Pzt7E0eqV+hNoseJ097j9aeiUD643lX5Ylk
 53avnd6zhE0nXhcq6CA2/Q9UbgHbGJ/43DmuW22CjDIiiBma5X06gMMIdENplUTfx8HWJJX51uL
 gig32r0zM8+p2rjEye7qZFH42x132GPTs7+37B3IRPzyUQv2JgixEjtYkzQVbBO+zFLGvSCkuIy
 kqBHK3JKeE0OpeA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The current implementation assumes that the PWM provider will be able to
meet the requested period, but that is not always the case. Some PWM
providers have limited HW configuration capabilities and can only
provide a period that is somewhat close to the requested one. This
simply means that the duty cycle requested might either be above the
PWM's maximum value or the 100% duty cycle is never reached.

This could be easily fixed if the pwm_apply*() API family would allow
overriding the period within the PWM state that's used for providing the
duty cycle. But that is currently not the case.

So easiest fix here is to read back the period from the PWM provider via
the provider's ->get_state() op, if implemented, which should provide the
best matched period. Do this on probe after the first ->pwm_apply() op has
been done, which will allow the provider to determine the best match
period based on available configuration knobs. From there on, the
backlight will use the best matched period, since the driver's internal
PWM state is now synced up with the one from provider.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 237d3d3f3bb1a6d713c5f6ec3198af772bf1268c..71a3e9cd8844095e85c01b194d7466978f1ca78e 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -525,6 +525,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	/*
+	 * The actual period might differ from the requested one due to HW
+	 * limitations, so sync up the period with one determined by the
+	 * provider driver.
+	 */
+	ret = pwm_get_state_hw(pb->pwm, &pb->pwm->state);
+	if (ret && ret != -EOPNOTSUPP) {
+		dev_err(&pdev->dev, "failed to get PWM HW state");
+		goto err_alloc;
+	}
+
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {

---
base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
change-id: 20250226-pwm-bl-read-back-period-from-hw-08226cc2f920

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

