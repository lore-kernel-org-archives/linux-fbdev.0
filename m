Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF272E7F3E
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430260; cv=none; b=Y2NUw6WpUcwLKw8SS9blnooEmPWd6ie3KDIxrvZDTHDnjjpIDf9GgI6cWLIPTsKAqPxfPjpu/Zc5fiemcpmX4ToOXD2pNEaJDlVCRRcWtrTV/rPJoNQCjbLbG/9Mo3/oFNKt7KklLu5HftaUZYEZ4R/IwbvRV1Txks84ZGHrk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430260; c=relaxed/simple;
	bh=JmZtsug5WtgXf6JhdOF69IW+9iNbUv2Fp4dY8g9+V6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFXN2cKUMQ/8RwCJuX3yL3PsVAItgUmLdcP0NSTmcsWtsYQAHtO0n/WtoY4jbhhnXimkTYyeinarAv8td+r8oRzHCmzFtEEeLhPpoty0okYOHEzwyWNTlDvYY1XLbs5XCqq8ejMXRBdbzkWq8y0Zc5WVlc5gpMQUGnzVlTKA+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJJfOcHr; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJJfOcHr"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9673385b1efso1388183241.2
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jul 2026 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783430258; x=1784035058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnKl9zDr4Iq4r6JmBf9gQDMvv/B9gbWj5R0POi5eeEc=;
        b=aJJfOcHriH5y1LswskmnsddYhvx19WnW2G/FileYvtXqMVUfMUfGZszTYmlOk6iRBM
         IlGf+GMnJu+KQCvqxP5C/EVlvRpl2LLMtuptwW5CmuT/cMTtSPMoZoKM/jUfuTPCjlHL
         FEusaWKslqKbB6uda8PDq5kymwEA3lKTuPoEkMn0jVS9PP9QhVpt4AJbzidvruAsCDYF
         QP3JXwBmX39VblP0OqkoXcPpYg68btjE8q1e1HeEVeQcMbibnnq6zljAmWsn6K90ea/1
         8UrxmvQ78BCuUAxCwDfN0d645+bdC9vrAFzX+W+GaCyWmSmX3EPvirdV3rA1s5UuhLhr
         12rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430258; x=1784035058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dnKl9zDr4Iq4r6JmBf9gQDMvv/B9gbWj5R0POi5eeEc=;
        b=I09i+ccMf+hQ6P90T91WsIjFpXCHM3r8VvNRPDfjzHJxbmDYmKzRjsIcSPhjxwqghy
         Rjgz1s64nq+P6h1B/UhepiifQTbOXyZ9sdUBqD01lgtSQMGRi419Q5vqM6cbZQxhxIeE
         d2m18ExODeHZOT9Hg3HXXfPt3HrbGXEvEc239Mc1uVDHaINJMN7EwR9OavfmOtxiZrNi
         LWVwoJ/c04pOEk6ltgPCUa75x83Hk8iM9mZ/A7spFKpUrdz9FeF8BcYnBbqhzgrboRyB
         vCCjGfPW+DHq+U6JheK+Q2EFpcT85ByS1W9XnsL0Z+2RhSVZd5YyTQ8TLfEQMIh3SlS5
         Pr1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpcLzO2/2bVThhnI7txsKvsMksOWKA1Ei3b7EtVWN1DJXAH3bqg/LP07OaeDNbNe2VP37wUL/qk3MfKZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGBiQqUchy6NRZya59NW6vVMk0buFiDvhdb4C5e+A6DG0B4n1
	1/3uRN1nTKcBzWcb8gE2gRhLnTXewmtBzMpAQCsYzUWER3bX9sr4ySrO
X-Gm-Gg: AfdE7cm/M8wEQEYRR1Zj2jaoDkXggHexYmrkKz8hs48ODwWyAh7w6uLhPLiTnT4lr6Z
	PrHz+OpPj1kHqXS8q28c/y8/1n8KLT4G6pwmUpPsmSE7x2+isJCP2keir4Ace6Zuo4/z3zjzzZr
	kxrO91RaquOlDAT3aXshNhkVZ+PYwrhjMnjHLLyNhkA3q4ClP67n8VZvQUGG0+tsTa0hEZL5yHo
	5gzBNrl6WZTzC54X8b/cdaCYBmDckjnXmaHrcLRoxZezX7MX7hvolVESRXc4RxmoVddbcEJEEh8
	IPqVyKgp4vfLWS30hOdj6KPbAXQN5HsbtmDknZz0S651CHSWdAY3KtbRBLUHqJc6sjI94RUkOLz
	33qU0VuEgE+SGLK02Ev0RUUvlaPGXdr5Yx7Jd3Bbz2VbtdOcLhzEPq0/EbGNAKRWl6EwWdVlpF/
	ML5NBaNbsPXlcsaUVWRg==
X-Received: by 2002:a05:6122:e183:b0:5bd:a7e6:10bd with SMTP id 71dfb90a1353d-5be8953be12mr2766521e0c.0.1783430257549;
        Tue, 07 Jul 2026 06:17:37 -0700 (PDT)
Received: from adr.. ([103.216.221.83])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5be02c5d487sm7425810e0c.14.2026.07.07.06.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:17:37 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
Subject: [PATCH v4] staging: sm750fb: rename variables to comply with kernel style
Date: Tue,  7 Jul 2026 10:15:28 -0300
Message-ID: <20260707131529.38340-1-andrem.33333@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026070710-exact-unveiling-e321@gregkh>
References: <2026070710-exact-unveiling-e321@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename 'setAllEngOff' to 'set_all_eng_off' within the 'init_status'
struct to avoid CamelCase and comply with the Linux kernel coding style.

Signed-off-by: André Moreira <andrem.33333@gmail.com>
---
v4:
  - Drop register renames 'pvReg' to 'regs' as they were merged via another upstream patch.
  - Keep only the 'init_status' CamelCase cleanup.

drivers/staging/sm750fb/sm750.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 0324778768cbc..3a1bd38ab347a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -39,6 +39,15 @@ enum sm750_path {
 	sm750_pnc = 3,	/* panel and crt */
 };
 
+struct init_status {
+	ushort power_mode;
+	/* below three clocks are in unit of MHZ*/
+	ushort chip_clk;
+	ushort mem_clk;
+	ushort master_clk;
+	ushort set_all_eng_off;
+	ushort reset_memory;
+};
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-- 
2.43.0

