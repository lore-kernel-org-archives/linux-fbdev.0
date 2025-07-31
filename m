Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921721DFFC;
	Thu, 31 Jul 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994190; cv=none; b=i///RZqGnGg0SS4iZSRs9df3Y8I2FNOYMKkoMTwhoVhvqca4VRyUtLf6sNLYwATqBERneK5NutKTFWP+wYiJ/8ZTwKFeRkwdHk2eSmTy8Zq1sJ4UwroRv5miEhKAnJmf4Z0h9WpOHL18Sea61QJNE4hqWs/50Adp1Si6N8UzK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994190; c=relaxed/simple;
	bh=lllDj57kA6USq/JccDX4aEeiMCwv3lG54Maxa0HvAuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUhTVIsRS+tHjRD427O77ad5b8Z1K/Y3cx0HuZJ1MJScjuTMd1g9vC8XKJNW/Tf9aHptkgVp5wadpNnKKV4m1c6Lkst6a2SVSw1X4dOygqH9zckXOVAnI4TVG/wGHmAKs6WenxfVkxHCmEmSYMywPASGk4wBETz5bHAKnkWHEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyIScblm; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyIScblm"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-875acfc133dso32753939f.1;
        Thu, 31 Jul 2025 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753994188; x=1754598988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Bkzmad0FHY3Ddy5NFcMc3+By4Cx3sAMV/rP5o2AEJQ=;
        b=gyIScblm84zntIWwzC1zy91ek0yo/50oQ9Thvbqo42aRXoAKhyKJlfueWENJQMHE4u
         t49kP4Fg4lwSBdA4hDyDK0gg33tX97qfXSU+x9ZVr+llcMg4rtRgkKg2yRYzj8cClJba
         xL45Dk6QSe4p6bsfd38PmS/Eb3JyNJQixxbD+5odDFWhQ2s9xpugzd057qdiDNRllSxB
         eHk0ioVjEkAvdGHUEmWPAkGwYsDCex0i3U8YunsoCspk5Q0aDD2xWi90H1tY+bAM8PU3
         TGPNZms4MJ1U8px2uuztnmd40rc+t71MnZAZMnWuI9OktEz9pR4YZcR8WUzKiW91NZk5
         2mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753994188; x=1754598988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Bkzmad0FHY3Ddy5NFcMc3+By4Cx3sAMV/rP5o2AEJQ=;
        b=RWxdz1PWcnQrepCgqx8tM97dZVDuDy/AffkvB6d87N06PhYHBFvLhLoOTwXKXzUtyQ
         9h2z3V3HuxnljXc8KfJ6nJ8aZIocTTZUXIdOyHc44oH9Zf6NU1+pt+NqI2Ouw8If+ila
         52BNWQUT5imjIXIEHzwzOyRUPpDb0Ioz3ov2QuJPYNYg9ZHGMTIe9hiZHGx4f3Yck5I9
         OAd3f0U3lq5U72l21p7GU48dx2329/dpZRNTSbfBjkB6Y3ZhOmLm+18Pjboe3sc5GvCh
         w6U8S6PRxzQBvHJtlf//57PRVl+exiwBiUxhB6yGo96M8NQYSDlywDiT4o6HVg5g6VH4
         g5wg==
X-Forwarded-Encrypted: i=1; AJvYcCVxA9759zPhKNQe4IxPRQUYF5hJEO/1szimxmkGuRG1ptm8NX1rmaWvfdgeCUiMJidjdQnAWSWRXNgrB2rd@vger.kernel.org, AJvYcCWufJp+DVcuWF04O/tTimaeLO9WjCJ/eAZY9n1hWQn870um5ubcJ9etrH5lC9jHnxOTHLDF2/GMcgnxKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSjG9cWTpfJ3LmVH8jAgR3QZvimtBNui5QXLX9saZA6lpdAKf
	Uv77UuYjwCV1vqPS37cozD8+fZSPwpDm/7jqpO739J8pKtZLLhMmqt2W
X-Gm-Gg: ASbGncs758Os0qoVioJB8XcOF0nZT+uFKpY9JmX1YzXIc0BTfig61iEn8mJhHbx/s/9
	OK18u0NJLkZSnX2PfGVp+5HNisEX4mtSaANmCX7nf8dAq5sNorv0KjhugRt2U8VEfPxh1UKI7Nu
	n1mOhL6GNqc7LZpYbhQBqEH/8NLi9jp72fxxzpoqjsaUGSpLgkp7rwegIPgeNFK/ReObIa78uMn
	rh3hjp2Q8gwtZuBu75WVHcl1gNgIfTM5/Ir6kY4w2lUE6YdM6w501yrx93/Jx44wkkxPFx65dtB
	4PWx588467wdz+L7F9uubgjj1Q2+X05iuZA2Jr9WFwr5xO1yhbErSaakloGvHyVUWKMit5Bb2X0
	7CX5oOecQqe713VWSbYhv2VffgVROQWSEFeFdLN0Mea9M7DzXZOW/4fznic9dvkHUD/rdvpvjzy
	MyC1aKkRdwAxvqhNgO+TUIvzs=
X-Google-Smtp-Source: AGHT+IHw6r8Lf+6zjHlaPGrM/dmdCKU/6h6oK0JKKrXD5sL3aXoHzVWp5gzJ99Itr+K+yw6WuEQuQQ==
X-Received: by 2002:a05:6602:60ce:b0:86c:ee8b:c089 with SMTP id ca18e2360f4ac-8815a870752mr15789939f.3.1753994187605;
        Thu, 31 Jul 2025 13:36:27 -0700 (PDT)
Received: from localhost.localdomain (syn-035-144-110-073.res.spectrum.com. [35.144.110.73])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814dfab231sm70312839f.28.2025.07.31.13.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 13:36:27 -0700 (PDT)
From: Sravan Kumar Gundu <sravankumarlpu@gmail.com>
To: deller@gmx.de,
	daniel@ffwll.ch
Cc: skhan@linuxfoundation.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com
Subject: [PATCH] fbdev: Fix vmalloc out-of-bounds write in fast_imageblit
Date: Thu, 31 Jul 2025 15:36:18 -0500
Message-ID: <20250731203618.25973-1-sravankumarlpu@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issue triggers when a userspace program does an ioctl
FBIOPUT_CON2FBMAP by passing console number and frame buffer number.
Ideally this maps console to frame buffer and updates the screen if
console is visible.

As part of mapping it has to do resize of console according to frame
buffer info. if this resize fails and returns from vc_do_resize() and
continues further. At this point console and new frame buffer are mapped
and sets display vars. Despite failure still it continue to proceed
updating the screen at later stages where vc_data is related to previous
frame buffer and frame buffer info and display vars are mapped to new
frame buffer and eventully leading to out-of-bounds write in
fast_imageblit(). This bheviour is excepted only when fg_console is
equal to requested console which is a visible console and updates screen
with invalid struct references in fbcon_putcs().

Reported-and-tested-by: syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
Signed-off-by: Sravan Kumar Gundu <sravankumarlpu@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3f7333dca508..2540d9046161 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -803,7 +803,8 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 				   fg_vc->vc_rows);
 	}
 
-	update_screen(vc_cons[fg_console].d);
+	if (fg_console != unit)
+		update_screen(vc_cons[fg_console].d);
 }
 
 /**
@@ -1336,6 +1337,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct vc_data *svc;
 	struct fbcon_ops *ops = info->fbcon_par;
 	int rows, cols;
+	unsigned long ret = 0;
 
 	p = &fb_display[unit];
 
@@ -1386,11 +1388,10 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 	cols /= vc->vc_font.width;
 	rows /= vc->vc_font.height;
-	vc_resize(vc, cols, rows);
+	ret = vc_resize(vc, cols, rows);
 
-	if (con_is_visible(vc)) {
+	if (con_is_visible(vc) && !ret)
 		update_screen(vc);
-	}
 }
 
 static __inline__ void ywrap_up(struct vc_data *vc, int count)
-- 
2.43.0

