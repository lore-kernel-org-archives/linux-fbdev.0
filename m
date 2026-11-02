Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606619;
	b=dMNXQiVTtXCGcyCnHvFrTEPQWWFGVOF/g6puOD8QW01PAxMsJf9QF2RHkMaN6t9r7GjN
	 PjfiC+pjxsgwTkdUcQy8hxat76jpyHxwbVEimG85+jtO9l432NyuUMlWWddv++vUSjlFi
	 j8AcjsEPufqCrEZDTeuB3q2iwve2R7hKV4mBo1L1GG8dtug3CrNmySVzRXhEGfDmy86P2
	 lDt+kQaGtbFj1ge75v8keXhN38yx6pXIJDGxQ89yqk0eA7xMNaRA63c1l9rta8rdrueMo
	 dWbBgQPkes0O8V9tdvHSpxqiXus4FamyioHpcwrnh089sQgaoEcOSr+CQSZx9FtdIJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z8EJgkp2KeWeadwF4AcKa6qCzv/o/cHNGkKe7Zmmr4k=;
	b=jABdIn7vVIoAxeWRJH26gVxA2SExWGcoL1hXcmjEMnGiHuazoc3cnoFTnBsNML8mljOL
	 tStnAm8aLQUF2t6DEniBfeAOhstlMS+opcBklESfgpzwM8LEi/0aZd0U0rIYXlVTWB/oX
	 /x6pft4LNo6gwN2rp4FBBHhtinkToIpm9HVikH73QBeR/LzH379iP8VALa592LtUNunyl
	 KAJuV1t0Zt/bamJEUqkx7NCknMXuIk778WvnHag9gPZf/69cx4BlT60FGw8GxvkYMaYWz
	 kN0VNtxVHLvcuadxQv/dEP70rXjL8H4EfOJsIl/k+4+FxIZDTCo4Ugd6ojmM3NBTkbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGI8P3mN;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3786606A333
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 08:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3786606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGI8P3mN
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e5fb79ce82so17217045ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 00:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606618; x=1794211418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8EJgkp2KeWeadwF4AcKa6qCzv/o/cHNGkKe7Zmmr4k=;
        b=cGI8P3mNj6yeNclc0dcW+C94nWagQ+oKQFE4xWtvKlXr0jIZK0CzT3+xXgeHJvVDUJ
         43LbY+lfuJ2f57ovgT8yBh2Fx6rdndrtl0vLyCgjGJ2mN7FlYman7SXF/kzYm9ULRINy
         aPgv+EfO4AA+GGVaaXHoVEjUviTkxmS1vQpruQw3g+O2jmn23T+8y3KbhU4AFV/y/l2G
         AIi5RK9wa35UUsRPDotZjFc4FgLZLz4IYteehhmSl2FvYGDWpOdEvpwBP/UJ60ZVGxWU
         0wZ+eo2YOWiiL8V3TKN/3jLeI6cizk25N9sxb1BZnMiKZaT/F4GC7ITPPPFF1EbGUZwj
         Uvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606618; x=1794211418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8EJgkp2KeWeadwF4AcKa6qCzv/o/cHNGkKe7Zmmr4k=;
        b=yqv579J4ht+itPT9KM9grn5WkYsyIEScWqe/Fpq5gNcOAt/S/GcXqD5dR/LL+CW7d8
         ForlgmDHRATZStHOzXcDPU5iCGSGWXuqfGOGzFAMkdVPEk7Em8laS1aT21pAOBP2zY9a
         qt7jGHZ5NPYM8OTQPdyYn7A5KjfUrRpBDUcuH+m/lOI/47hBE0lnh8LUHiGssc/jr9rC
         aunty3hFYCHl07tXuxjpZP6REUBtFFOKEg7KtjlKjGC2LqPRJ9jTJ+/eB3pYucNKHowq
         do6WNtOcgOmuc/g0JzabHX6omDhWiIftWNaRk5PbjOMvI2dEr2x2Mt5aN8SR1lvVujXk
         JDYQ==
X-Gm-Message-State: APuU4Z8HwwSnwBrbB/lLe0O8fo/jfrQ/jK14dvFyTbEBVND/WwgQsPxU
	UeFBMb3hz0yBXoJgIq2Qs6fMLAfzXggOnQvicPc51oXPtYkj544zm8B/
X-Gm-Gg: AYBFou3dVVl3Ra7o1SwS2TBfhkpdeZMEBP3BVEf/+v6ICGC6gn6dkmjQIeelgL/bR8D
	BW4bj/EiAAYmVdqxl+4q1KUFBELb5ZXSt8mq1/poTiRAk71PV5jp7OgF43j8LL+cY/NXK2E7zIo
	yln7iMtmKOSWvecBa20c82UtMc0gqIarER2qhfWb36nmD3TOykv/MuUBkkdW6spsWhKw9Jj2TgG
	itg8ohcPuSzUAkWj1UTTGaiyns/ITAM9amvslKiStBkruyW/R6wGKh1xKbB3T+gpHNFwf21Q9o4
	e2utQa5fQJRFQJzktcVHerjM4G3uW1TMPhzQasd4ckM6pGKcwgJWvi4Yn4M81YxuOniS+EODw1p
	hB+Gqlm37pR+xqFuoRgqSlv8JJA0U/uhu3j2KxgVu+coQkk4k5e3hDlWlOMQ1shzbxBjNod7I4G
	/lH9lrx+pjT0N58TBVWmML/xfJM7eH4mavlibvCsVPbjv/LAXmJXhKCwxAC7RwrMIivhC+sXFwA
	4FSpGsyKnGiW2bwX0mN+ahJGVaH+y9IIZSyUuVoWBuQWprkZFY9rgQnUXc05ZTxlsrXcffNW/fK
	idkQe1+JL/uMApkL01OXloxbkV+byYzmeE+JR4GYyOw6Vo8J+e10jY7hQet1dTCyOR+sf22OIqi
	JGOLrw1etLipUL7CORt6mnh/yxDYGskxBsRfkeyfEYJadIosjPbCl2uanOQ7ESleQ3L0DQCJHqi
	pDZ/GEq2mVt5yasGI=
X-Received: by 2002:a17:903:18b:b0:2e2:b624:54b7 with SMTP id d9443c01a7336-2eb3649b19emr87836225ad.17.1793606618284;
        Mon, 02 Nov 2026 00:03:38 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392afa5asm23573655ad.72.2026.11.02.00.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:03:37 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] fbdev: pxafb: unregister cpufreq notifier on removal
Date: Mon,  2 Nov 2026 16:03:30 +0800
Message-ID: <20261102080332.1466689-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102080332.1466689-1-matthias.goergens@gmail.com>
References: <20261102080332.1466689-1-matthias.goergens@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxafb_probe() registers a cpufreq transition notifier, but
pxafb_remove() never unregisters it.  The notifier block is part of
struct pxafb_info, which is devm-allocated and freed after removal, so
once the driver is unbound or the module unloaded, the next CPU
frequency change calls pxafb_freq_transition() through freed memory.

Unregister the notifier in pxafb_remove().

Sashiko, the AI review bot, pointed this out while reviewing a pxafb
cleanup.  I have no PXA hardware; this is build-tested only.

Link: https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.org/
Fixes: 9f17f2874834 ("[ARM] 5118/1: pxafb: add exit and remove handlers")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 drivers/video/fbdev/pxafb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1682345fb9b0..4f5c408eae56 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2384,6 +2384,10 @@ static void pxafb_remove(struct platform_device *dev)
 
 	info = &fbi->fb;
 
+#ifdef CONFIG_CPU_FREQ
+	cpufreq_unregister_notifier(&fbi->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+#endif
 	pxafb_overlay_exit(fbi);
 	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);
-- 
2.56.0

