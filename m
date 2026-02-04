Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574B230264
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206765; cv=none; b=NeL2gt8r5QRKLmzREKVVvBn353dQyaiDaVeyH4CfQYCqIsiXBzDIKWfgRcLxNlw7FEVzbhLouwFMwcxbBsR0Eqnnn1QP0Ka+naAMANijx+6MIClcigVFykIU3vig7qnHxsekbNFVlBUtvhifDFpQUt8AInkM2Kr9MvWDJHuBL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206765; c=relaxed/simple;
	bh=eQyRA3zK145ERS+0VaG1fqXXSzWHRu1UuG6UzNBeOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjezjVFAoEh7ORWP2ztYDc74vAdzKm2B0W5ir8xiSw3pF+CwJjrgVYkut/Tde9kLYxX/yjDKp8xz4yZ4Am6pR+/mhEVtpHxoHE1dolw7yCSizCnLyI9yWMCVd2Q80LzvoH7ixIFaASaDCIVQL6/kSI0znubacRyLgt+RvDjCQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4eO8aNF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4eO8aNF"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b884a84e622so1066987566b.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 04:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770206763; x=1770811563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhoP0pPQXzFMYeoL8mgzc0GAjk9Sji92Sg8sNl17bY8=;
        b=g4eO8aNFg88jnqrPR9/IIIEkigUiwAjv/7E7jnCGsmcLH+w8/YaNLPTH6UY+v2n+Li
         FFiVD8lp75i6k+gQpWDZJUi0nHiSZNdXx9jG9fbjcP+Db28MSBpa3WjhldGziFk5Qu9Q
         ODvarVmdYd2BheuqUcYP3tKImdPEo1e9ie7TnAY7hKGPXpvQT6p74Ey8em983q5pJ0Zv
         YqbU9Ih8DTAauDQMT/QmWJY344H8ee+khqqKYDDkc5l+fNXhyjKKqAUILuXIl27IAOxi
         QMOiMVmfpay8g/KEDzwjdYPH02EWUKQwv+dW3bGEwj0ywYa20mAqmUlnC5Xo+62tK/cF
         HweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206763; x=1770811563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhoP0pPQXzFMYeoL8mgzc0GAjk9Sji92Sg8sNl17bY8=;
        b=u7lRG4Mg3p7ADuoZfZN29OFpp7eBvv7u6IrSWEnFg1wqTmdPoADQzfX1KzbAVJwOAK
         9d0bQh5z5cFIA0AcH2eQMw/Lpc22twGd6vNsEFBeZ9uq6sKNsobY2WIz2daTLvnXmB6E
         LF2WopKcWddFdN3b0TTbNsvmbY6g6BV6V0TYkzdLL+pz74n+bpH7YLlmq+SHohmC8y8l
         bsIxCVS3GXxK0yeG/Y+zWgUOUIyo+lAtfOmIWUE6Ow8I+gx/ZA7wvwgveNMjuXA2n2RT
         NbDxi5KFWxRhDESVu8p2dISilGElP1FEoULjRnNLA24+tDg/Hoqr44k6DANgmaq+FjEf
         4FKA==
X-Gm-Message-State: AOJu0YyAOfzx4pCbmwqGFpSupfD7jyLWRohSfim8quxVtZNDTBYDVpZM
	2mN5T0ml6gYKMKdu9hs7hj6UNF3jZ+wGfdQ99tEzR3E1VB8yvS3+xxwo
X-Gm-Gg: AZuq6aJMVYI+uGRhcFMjoND0WOiM+GtPdSnZVDHZO9aEBEj0CU5/JRhAGsD6a99vzmR
	hvKX6hGB8TBKD9SAIPznumWQSLY3nwY7TplXi2sHmIIWSemeZOaGgIFu5U2mbNYTHvewanQwS0e
	GjsmlNzEqI0ksJqUEiWBSwi8tzMXdqPGVK6ZL84Jn289YfZviB1ho1Lcc7jDbBzNGhd298zPUKr
	PhHuEzcHYlKwHAs49LKfnu2XUrf73X1qfrhESGhl/ipBfRKL0g3hoexSOwlxMUluAARNbbKc/ya
	zwu/AGM+fsU3q2NleTcVu3T2DugykvB/6COfHIKxrxxo6RFNaVwDPcbdA3uqt6hZ9uDurSwV3yN
	mEuE0zKacvYvPWMrp3PYfdz6NWtl43kHO42IGLI37F2Qz16YpWELPQjf7bgNxbBWgxwuO//4rdQ
	S6fkMKchdfnDoExzO42s+GCaVp/mHT0+GYrxVUAdDXf/O1s4gL5ZxSBUW6rsXPpBm2voFB+Gqu/
	9cOZ1CxkCHnZVoNaeBje46vihMULUBG8NCRgd4+OPSDN5QEMQ8EAyt604Bs1JOP9Rodfg==
X-Received: by 2002:a17:907:26c2:b0:b87:1eaf:377c with SMTP id a640c23a62f3a-b8e9f3966b2mr203944966b.38.1770206762944;
        Wed, 04 Feb 2026 04:06:02 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (216.79.91.34.bc.googleusercontent.com. [34.91.79.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fcd8be3sm117979666b.10.2026.02.04.04.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:06:02 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v3 1/5] staging: sm750fb: replace strcat() with memcpy() in lynxfb_setup()
Date: Wed,  4 Feb 2026 12:05:58 +0000
Message-ID: <20260204120602.6715-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of kernel hardening, I am auditing calls to strcat().  This
code works but it is a bit ugly.

This function takes a string "options" and allocates "g_settings"
which is large enough to hold a copy of "options".  It copies all the
options from "options" to "g_settings" except "noaccel", "nomtrr" and
"dual".  The new buffer is large enough to fit all the options so
there is no buffer overflow in using strcat() here.

However, using strcat() is misleading because "tmp" always points
to the next unused character in the "g_settings" buffer and it's
always the NUL character.  Use memcpy() instead to make the code
easier to read.  This also removes an instance of strcat() which
is a #NiceBonus.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..4c6e84c03 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1163,7 +1163,7 @@ static int __init lynxfb_setup(char *options)
 		} else if (!strncmp(opt, "dual", strlen("dual"))) {
 			g_dualview = 1;
 		} else {
-			strcat(tmp, opt);
+			memcpy(tmp, opt, strlen(opt));
 			tmp += strlen(opt);
 			if (options)
 				*tmp++ = ':';
-- 
2.43.0

