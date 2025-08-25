Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF53153BD9;
	Mon, 25 Aug 2025 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756089068; cv=none; b=Inv3XPmk4tug7CbhdjuMW7VTlkfyOET8x9/KGDC1hfQD1aAHT0BgK7ZxOLIqI7zb5GJO+1gGDHIdJlgVZGshfuAlWQY/wQplfPX11t9I2bnneaDX05YUEowefwkAHzxss39cYdf9WPwSsQ8u6JEV4/vF3NZWp/FLwITz81hs5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756089068; c=relaxed/simple;
	bh=l4d2aO6yflIfj5ehW9qRQYi+2Dxw/Zf2JlJdhPbdTWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpNtfJ6+MW+b7CBM71JYa8/K8bRXMLnLqRfKJErgPLqOVJEdfuA3En2mIfZTV4djUp05QT9kZb0ht1Swn1diAsouqM9i0uceye967XwklIzHGqjPpvdD3AmDO38WUavcA4Dd7UW1wp1EGrmju3edTzVLybnRgX66RAjNAu6RvR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcTeO2Mk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcTeO2Mk"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323267872f3so3010197a91.1;
        Sun, 24 Aug 2025 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089066; x=1756693866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+OueiTUtaQ+cl4byHqQJI84zYdm0M5wQwtNQy1rpWk=;
        b=WcTeO2MkOCzTvt270utL5p0lLRjRwePHQ7scat6skhMuIxsENAuVEznNCp/IE5NI8r
         BQjYWnAJHp0RjQhfgS3GNs6Wlfft2BvI/OIlNJjMsfsZ05y0hJ1ClT1WNfhokiHqoXsJ
         Txg3E5Y3V2OYd5R4g12BsfEc9tCXc1kZk+UNM65YG6mQcEUYj5lQeAMcZzs7BgZAvjfO
         7IhpjT/Uyh+/HiL496h/RAKPckJpGkhABV+w21m+l3Os5mx3VkVaO2nrTJ3lhfltqhvj
         6eZ8fYOPFAswJ2QsfJuMETE30Y53Tydb1W3Fn17+pn9Wb5gX+bm5Z1z49jZgKsAzlDOH
         QKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089066; x=1756693866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+OueiTUtaQ+cl4byHqQJI84zYdm0M5wQwtNQy1rpWk=;
        b=j+WnwpczMwMayXC0L6F8XyNwCAG6itzd9Q7seXnn2sW84H5pXHD7KAn0IpZMeApm/H
         5kI06Hn54jXTAOTjL5nLnivz2mfOtr7m5M/yHtUzWL0C0ilmSHRe7wLHD11mZpUro/Ud
         A2i4HSpopYh7xLl/JF4R3jsIDI37/WXunRs5pKLELaaOTUwY2SdhWFAHEGSDX1hyAU3g
         /15cCtFU+3Hj/xjXD4ON7/FqbcwxQkftyZK8ZICvsGN7PLWyQ4KwxDpLdP5yEHkIIgvf
         kXxufBO9vasUJ2z1rbrLhhMnXTUmM4atCjmJ0fYRP00+T4/5LC6YafSUwDlXeH//cO0X
         vU6A==
X-Forwarded-Encrypted: i=1; AJvYcCUBh1B27bBbpLD9GOTUe7XpnuC125yaDhuqhHEkilEDBzlF4GfQ1a4ZwiXfYX2No0YcR1QEW4Exu86frA==@vger.kernel.org, AJvYcCX+F5yNVObW949NcNuohAWQPSn4AYMxOkx9RU5jf+QnF/ZLyQ8O+zUjZzPGRJuuWxCRFtm4inIZJQ9VgI/A@vger.kernel.org, AJvYcCXMDPH3WwHSvV3EXp1NGZIMQVjYdAsLI3oUK0sp1pO4AIXtQ01OC5shovFlqnIL8YEifKlB8vWqvjtadbbsvEm6@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3c+k1+SE+VnZXSyrWu4e4cYicSJsNTwzdnXkD8gSAjSTFuF+
	VPUy/JZxJUtB3wg1DrPPcqcZ7DrU1YCFq+m0+hwe8BOudcpszAyF0gfW
X-Gm-Gg: ASbGncvk6jBPCsJXNz04MKgCJm8ytVUMkdQxyOddbCy0D3y0thvv4hTBO5R3OIqNy/h
	kctPE3luPPAnbA17bZXyl/SJO1DMnjgVwjiXfv3EbKjUN8PIE3NzS0S8NXSQITSP6Yg/w6uLkzC
	5vdAvB2uW7exae1gPZldKLr9nOx24BlhF8ODXzvITBqUs6nUP2cJ/koW/noYLJK5rKNWdwsGHfG
	4jyI9j6x19B+TQlBjWKtcaLOK2dQ8LNfN1JyBSvHJ62P6y/MkM+f+O8Z5tsc9q6vt48VXR8rMcS
	Uumr3vc7GNJss/TbFIWv3sppXBlpxFZDEt62M4T05Zugh+Oy1+O3TIzJAf5mKnINBNFQeosXtno
	//XpWu/cXeiU8FIv31MTD5xZtF1FKgjjcQaRoCwrj7sJ3RLfZwctMVookd3BnrRtEM09AXSxZaZ
	U=
X-Google-Smtp-Source: AGHT+IGGTCfkkziinXGfm5OQ/klvHSQOorcEs0SZvFKbeIqW5aKv9q5QfSmua5wLs2b3iOYngv2Dpw==
X-Received: by 2002:a17:903:37cb:b0:240:1bdc:afc3 with SMTP id d9443c01a7336-2462ef6f678mr124826755ad.44.1756089066318;
        Sun, 24 Aug 2025 19:31:06 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:05 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] panic: use panic_try_start() in nmi_panic()
Date: Mon, 25 Aug 2025 10:29:32 +0800
Message-ID: <20250825022947.1596226-5-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nmi_panic() duplicated the logic to claim panic_cpu with atomic_try_cmpxchg.
This is already wrapped in panic_try_start().

Replace the open-coded logic with panic_try_start(), and use
panic_on_other_cpu() for the fallback path.

This removes duplication and keeps panic handling code consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/panic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index eacb0c972110..cd86d37d124c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -355,15 +355,9 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  */
 void nmi_panic(struct pt_regs *regs, const char *msg)
 {
-	int old_cpu, this_cpu;
-
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	/* atomic_try_cmpxchg updates old_cpu on failure */
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
+	if (panic_try_start())
 		panic("%s", msg);
-	else if (old_cpu != this_cpu)
+	else if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.43.0

