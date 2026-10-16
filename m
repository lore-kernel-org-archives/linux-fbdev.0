Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA43C109E
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122358; cv=none; b=EcS1o61snBRXSvXsewsxzPbZpKqUs7yidWciT+1evWl+m4dJCH7AvPXraWJofOhN5duDSxq1+D/b12nWiL3qLyrmnFEOh2Xo5FxBBRgpdyyr3oerozH5MD6sO652yL+rtgW9GUfrm5Ql7fLcQAvb8Dq9jX9OLMkWbeEk6IVABF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122358; c=relaxed/simple;
	bh=WnSQZDNJL9uStHjJfld+aO4hEqR5unnU5IUqR5eY5Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHV/UHvqbUYIWYr+21dY212NhxnPjejavPihpqrrJSp2vrd2khKAuyZKZp6esDBOtxlYZMkQaFWUMGWgjXQxnSTLBCS0PxTL2i2p9C/nqH2ppeGc3kGhbjry1w+Saj1Dp8RHOG+08AUM+vpnXKLU5ESYTDkfTDqNtWlDU7epdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHgDaGQa; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHgDaGQa"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35cd538de29so1199412eec.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Oct 2026 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122356; x=1792727156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZAMtIxyqaOU5P+355zxZjtsgqUUs04q64AQMCXAlLY=;
        b=LHgDaGQavx9zoz0CnljBdZLS17tEswmX2KpLOHjRNEhsM77miJw+Lv5pvgtv+PYfP9
         kn8JMOjEnxp5iWoRjhyO2UTdInjKLnxr9TcZagwb6tzZSNefxcTe47FnzZXT+10hc+Wh
         Rfx8ZYfcdI4IAb/a1Kedvhdmshej0J5jBCvrhspfqVQO/N2zxg5cZEtgXmSsWpXXcXZ5
         0idKefeD9oG+Gr1ryqiy/9XH0kbRsi7h4JYRNu5F9adPWiYZjdtdMabecPGsAy6VMt8t
         +gqOTwJEogUMPT4SB7FA/N4+t7PmlJhehMt6slrT73mrj2LyE3g1+t8Gife6/MWJOo1q
         m+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122356; x=1792727156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZAMtIxyqaOU5P+355zxZjtsgqUUs04q64AQMCXAlLY=;
        b=qur1safjftEOJF6+FmW/tmjLIDrwdEmZvuzBOH8tKVTaDhYT7lk3DC16I4/RYpk89O
         hT5zH/kX3I3HVVjzYtbCnlalB+tCUwN3GQPapid4U4gP6zAVey8Z9v/Mr5r6Ti0pVvHI
         ELvWRda+wvOoWuvU/pJwquXUFf29HvKk3JW2pgTVwWBYSrifelPkfNgA+y8Bq8d7IE+t
         xsv/70xgZam4/fNdyJCL94w4Mb4q0v++JaP4xWTLzf9cQRB7qE60qQCLXNi05lBAagCg
         VEp5nRdvziVls04YPG2D3zDkz+vaffdoQzggv1IlpPUmpg3z88+jf0JmZThkWQa5ea7H
         3d/w==
X-Forwarded-Encrypted: i=1; AKwUvBw/mqNU1pxVo2gky9XwgeKNBXmTy+1ZVHH5wMMrltbOQJlauWdYFqlBQ+NJSsXsXOcrfzNW+uQY5fIFuA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvTxXb1rh3vC8Qh9ly/un2sdyuLrt0SwDasfQ5WGMeKMmupHQJ
	EIxFa+Qt8lETiGByELukqAzv3F/QCEUgFssplvYbbRtRs3HXUjIYpqvr
X-Gm-Gg: AYBFou0QY4Nto9XdmtT1OVd+AlFuj/P/n5tICKfmqG4npsG9Tc0NR8NHMtnnhS57X4u
	U9+iZaokWUCudg7f3izEY0YwaiivXqwrA+7y1zEvJqvEio+3P8LgXxVUd0IdxxKXiLFdjRt9+la
	C1FCcK/jQoLd1aSl7NBiA5apLy2XQGWhNV+R++2rZD8i7QpkDgX2xCwenrFLYsgncO6IOHF//lR
	xnkc8CbtojOFzqx5WhA72ita7XMkPIzb/emi4XgJFeySW/sNRMbFmAx6lk4qAnUOiSJzCeyxnLC
	NMoU2dsjbB17sxEZSBDv2Iy5TGRPyaGju5w8naK9K4CrqE4Q3Arh3Re31X2uBYu6S1BXDlOSYlE
	+7ziQb599/UpOTemzocn0GeVaFTdyvR6L8bTJfr5kNdGJVAn88+Utq2J8rK1ZIiwE/kn5xc+QrS
	Ojz+WUOf3ZQWG5RwqBTOCINPRrIOe2ldPAVjT6neWpLo0dgMhjwsEz/DY0jWGHi8B5/YHIGjwHi
	tzQ2NZAdIkhsJcRNI1oyBcacKAAedvMTfsD8VQ=
X-Received: by 2002:a05:693c:41c5:20b0:35c:ba31:6fef with SMTP id 5a478bee46e88-35cba3173b2mr12712550eec.36.1792122356200;
        Thu, 15 Oct 2026 20:45:56 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:55 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] fbcon: Retry rotated font allocation after failure
Date: Fri, 16 Oct 2026 11:45:33 +0800
Message-ID: <20261016034533.445862-4-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016034533.445862-1-yaoyiqi3@huawei.com>
References: <20261016034533.445862-1-yaoyiqi3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yyaqia@gmail.com>

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() records the font, its geometry and the rotation it
is about to handle in par->rotated before calling font_data_rotate().
If the allocation fails, the error path clears par->rotated.buf, but
the recorded font, geometry and rotation already look up to date, so
the next call takes the early-out and never retries. The rotated
putcs/cursor ops keep returning early on the NULL buffer and the
console stays blank until a font or rotation with a different key is
installed, even once memory is available again.

Also test par->rotated.buf in the early-out, so a failed allocation is
retried the next time fbcon_rotate_font() runs: at the next
fbcon_switch(), fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v2:

- The early-out now also compares the font geometry (previous patch in
  this series); the retry covers the combined key.
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81bae..7afd63dcee7b 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.56.0

