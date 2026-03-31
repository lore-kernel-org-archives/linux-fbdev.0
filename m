Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BA1C861A
	for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965512; cv=none; b=kRyJWMA8Kk3eMC3WPl8T5MMmFoS1w2EWjmMsoLjHA3Ct5wLvSvjTS/GHBqNvUS8ZF9fyY4D79xO7rNDI77AMWt6zGrmIBzabB7xuvF4VmBmzQQ3XqpdmlhSkSwRq42uVDVa7Hjb0P3OXTmXrzc+74kUtFmiTiAQ8MAHLyOIj+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965512; c=relaxed/simple;
	bh=2w8IBapKnz1Sxld7KRM2gygjrEbTSCCsEM6TVnxX7CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3hT2jI5oCzEw4U3KEgcLdp9IzBXltvvwLMJ3268wJX9RpkveCA8rZhRhfef+fKdXbgSk8HKgi2omTlAOeY1xcRtUCHMG2azPHNpU1NCGPkaIxGturIOsmsztxVTSZvA4dGlf4Dh9LtQDOwguZ2i1YtxK1pZpqEynZHQChW/Jf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP6LbMyv; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP6LbMyv"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2c56aa62931so2098069eec.0
        for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774965507; x=1775570307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2jTYn/FN3yNzRhPDPsyr3eRIifvRUFAJXluiCT4Y4c=;
        b=AP6LbMyvZTvjXWZJz3f9GZrlSNY/TXxEJ7DxviHx3zUuolPehu1k/hH2UwWEZC/VO+
         ZxvVvSA5UPwt0twF1yxWcQy8HohH9QyP8XGqNn8o6lsDfLHguzj07K1ZSOHOW4vrHTQs
         R6bMmXUcModwNUalHoxKq0nwRH5u4Y5bSDLgHiuz/Vo7Ji93qNtp6MD7H3V73c0mKm8Z
         1B+s3d1wD+CAaHuLhj6nt8+MCa6sDmrl/9Bn/TOB4xxL1RBN9NWAa2hdzB0IMKWlo7xQ
         SVGehJMaOInrO5T7bnI09TuZ9PqyLMVHb3McLVABkpyh2xmelOhziyA3Mxg8jUUl2FXO
         SI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965507; x=1775570307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2jTYn/FN3yNzRhPDPsyr3eRIifvRUFAJXluiCT4Y4c=;
        b=THbo1ULRHY4mEwvZCJjZfY/qLtLfFkZ5+YAnBdBgWQat6v+usmYlZ2SHUg9Cyj2TCn
         WkqtFelUIU38m8ydQ6AC8+GvZfsSBACpranTqDKR3zRn/H0X0dR47TbzqwnZg94CtGRI
         YALd9c84ozJDa8oCHaGK0V4peIaF2Q+N5Px5ZJrhmrJc44NMAn91+TjEPc1aCkvMN/66
         rnc4cpb0+oi1WU7OTeubyj0VGz4+xJQgFcZihg+D18jVjxtwErokKOO4YgOrUar4CvnP
         4axJf9Qr0VdlPPAJxfqMcShnzZeg4zmH6mFKULpVUPqupSzDVqJcZ41ugVsitzeXTc9A
         m+Pg==
X-Gm-Message-State: AOJu0Yxy8LqY/QbgO/VXMhwb5zgpkpXgdYQUPf6rJVNdPs/dds+TlbXC
	rwhabcl3Zwkv21lqR/a+W9B2Me2qVHbadU6BIBGU0DNxX+CvzNI0TBFr44qragAnhdQ=
X-Gm-Gg: ATEYQzx43ZYB+g5nalIIcH2whgurSRpP6y0UEA67xUO61/1J94mgvqSJfRyYso9rIcM
	g1b6e/EmlYvH8kpSTL32eHd1pJU7VeKf/Q1T38MoMxpVV3sWRBGLcXQsDqKafi+GQ2tTcfI3EXH
	8nMRL3fzQBAayWcKj1c9+upLIuILOjRB1kHqKKPaphayIi7qdKGNBb6oHJfAVyFhoNdA24nYPQ8
	qFzqxDdRBDQK27C7gxfGK0maViL5MpOY1aQJ3QjEpG6kRI4skwWY1XsTqNe1+KFZwQY+DT4B98S
	RT2IhfiQv9tq+QoqoBkiwJ70i55pJ44tBJVV2jYoAKIj6Sa164z1oYqUsogHddlUSrUCNn9qsxT
	UgEM4snwVuH8U6uYTMgsR5C5pmcOvpcQoHBLT6FwBvpvjNJa59uYfjytObOHVctjEaU+T8ani+n
	VlJuDaen0EYNVqXamcs9kbHpmbi7Ld+LNJgtumgj/IacWto0Zwc2u838auTrmlCnd4mESfdW6cd
	5U6c3/M5CVvdg==
X-Received: by 2002:a05:693c:3008:b0:2c1:6cfd:73df with SMTP id 5a478bee46e88-2c185e90d4bmr9416531eec.30.1774965506865;
        Tue, 31 Mar 2026 06:58:26 -0700 (PDT)
Received: from localhost.localdomain (58.sub-174-193-131.myvzw.com. [174.193.131.58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c45dfcc95fsm8348215eec.29.2026.03.31.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:58:26 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] staging: sm750fb: constify fix_id array
Date: Tue, 31 Mar 2026 13:57:59 +0000
Message-Id: <20260331135759.19108-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331050738.1547-1-dennylin0707@gmail.com>
References: <20260331050738.1547-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify the static fix_id array so it can be placed in read-only memory.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

---
Changes in v2:
- Drop g_fbmode change as it is modified at runtime.
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 62f6e0cdf..795e9164b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fix_id[2] = {
+	static const char * const fix_id[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.34.1

