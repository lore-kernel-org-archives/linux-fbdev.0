Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82122749FE
	for <linux-fbdev@vger.kernel.org>; Sat,  7 Feb 2026 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478628; cv=none; b=ahBGZaC7WMiCpKIe1osDAJO2EjYizz1gbNJeZyRdztis+Q5Ji1xAwO1TPesAz1EQwJi8ZQv22fvxbUwmbWzSAVS/0K1bC3rsBfz/Gz218gvjhoQhtCU1CVH5H3/irTnNxf1yY86JPjR77LanjZnFhZwuqWln7ad2RwUcpoExBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478628; c=relaxed/simple;
	bh=jdubdm4I79MqOnpsLzJ91ixMD6dvIG6KUclj8/ope9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsbrspQQ++uMO2GU5EN3pLsJ+54Ar4XSLbUF0T50JZD/KQEIg96eJkbX5LOeMTOAEt17YmJZ3ToLpaKpgW2MAqvTaMn+xiax4UEjXzVqcK/VdTHP7qPxBhVQF2AC1z6TcMXSMUA/JFEomuC+7pbVQdzkPJTlHeyS0s3fZGZYPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6LdHpHP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6LdHpHP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65832e566edso4216006a12.2
        for <linux-fbdev@vger.kernel.org>; Sat, 07 Feb 2026 07:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770478626; x=1771083426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J908Zx4L7U5Tl433tB9UC9jyDe+BTgpPRWxg57FIM4U=;
        b=H6LdHpHPhgcfNaXS6hSjSmCAXYraTd2zfHxVZxnUCpvVelA9LIwrLNH2JUVACpZN+G
         1IdX/NjW4C2fKOsoZa4JHN65NlJHZuiD2oXZ+iHbtb21Vkm9fYC+W4ckjmtXKUIVy0AP
         7PpbYrOPPBAWLDr9alsbfGbReARejT3OeX63DSe3JKDrITgEObhYWQC/KhWRVE4btnYf
         oV+VA3jrO5xA0x3V8Gu0wf98VsnkUIgrHw5S3YAn1UfUeXbL6VcKMJnc+5Ufzo+/1SBX
         pdVfV18ugJ/Z+tG11l5ruvrOH0FMUeiV03TAG7A0GvYZ2nK3pbAah2OKEO0NH7sWbGun
         JJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770478626; x=1771083426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J908Zx4L7U5Tl433tB9UC9jyDe+BTgpPRWxg57FIM4U=;
        b=dzpdul+CAgLOosKPgu7efO1nz2YgO3yqz8i7fkLx6dGPgFQaP5SJUklhlc3qxzA4Pw
         0zjrhXwraDZFU+ED3PdiZG99jfDpPvBh5cW6dSN8lIg10yOGZjsIWdAmT5yOaDA8fGjR
         pnBY0R7tI0l1rE3/X/E0jRv74kq+wdECyFvlwquH0/g1/LF3uIpRH82EOZjOTR92FU58
         2eF6/6OWHnz1x+0LHkRm6paMwowyqq1Nbf/1Sj0sMdcPurD8GQtMXJlBYfwE19x/JcKl
         /8diMNAq2WkZbTTtlyIqWhn9woZP0jjyM+cic3DzYcN6M/4FYWBRYL6LYmhFX2mNpS1X
         1xcA==
X-Gm-Message-State: AOJu0YxQVPenRe7xUm7zKNAgq02MV1JZ6YNutCZGvLWNFDb3HNrvGw94
	SbnGkOMube+7ayCfqbPADvA8AZk7/A1zQYvDa7PsYUqsNhJUND6T0689
X-Gm-Gg: AZuq6aK+fNeQX1RGZlLizNfOuRQV/gqNWLnfJIszjjSB9xZpacTmiaRcLDQJ633kKV9
	tiZWzk279gSRdl6cI62a4nz/ffkbNwnzruebiXX9jrV4SF3laBR12TTtevHHosk9/xRA8GjFZKx
	sGMr7dRtGRLJACBr1yPsPqoq0Mvc5mXamDHah8qqWdUwWuGrukbNbCuxXWh2Qaqd533kYKePLpU
	o7pobQzfzQBlScxNvpTdrIZxExtkcIUwSJ9SLuaiqDLRa1O3mYSzlZ+ugv2+N38gnMY2CqAJmFK
	d42znBaQVaPAbh+CmDx2ru76XtXoWP7ibEQlzwe2QCbAnt2nS5wk3pWXHCE8zOqan9gfoK7dVXO
	OazFKCJ2ue7GB3PusK+crWL+13nn3k/h2sX3ywTwaLGQwY++U97f2ZmB6RnNKmHyS8GnUuRLsGy
	O4u9CLTumzlefV3wzLyPKkB+i6uCXFT92K6SqEKh3GuISdWr55OkBVbCeNau50xXGDpPG/54Mp0
	EQrifvhXZbe1PcNosxeSE6dRQAyvvwJBQw/zwL7wdMldP7bHkQ5J3aE+7Z1hlCi
X-Received: by 2002:a17:907:3d50:b0:b8e:2a8a:430d with SMTP id a640c23a62f3a-b8edf22fc44mr323680666b.26.1770478626090;
        Sat, 07 Feb 2026 07:37:06 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (170.249.141.34.bc.googleusercontent.com. [34.141.249.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda748aa6sm181308666b.1.2026.02.07.07.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 07:37:05 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v4 2/3] staging: sm750fb: convert logging to device-based in sm750.c
Date: Sat,  7 Feb 2026 15:37:02 +0000
Message-ID: <20260207153703.2049-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207153703.2049-1-iprintercanon@gmail.com>
References: <20260207153703.2049-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pr_err() calls with dev_err() using info->device to provide
proper device context in log messages. This makes it easier to
identify which device generated the message when multiple framebuffer
devices are present.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 987ba8772..c5eb3e98f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -388,7 +388,8 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
@@ -487,7 +488,8 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	ret = lynxfb_set_color_offsets(info);
 
 	if (ret) {
-		pr_err("bpp %d not supported\n", var->bits_per_pixel);
+		dev_err(info->device, "bpp %d not supported\n",
+			var->bits_per_pixel);
 		return ret;
 	}
 
@@ -502,7 +504,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	request = ALIGN(request, crtc->line_pad);
 	request = request * var->yres_virtual;
 	if (crtc->vidmem_size < request) {
-		pr_err("not enough video memory for mode\n");
+		dev_err(info->device, "not enough video memory for mode\n");
 		return -ENOMEM;
 	}
 
@@ -527,7 +529,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 	ret = 0;
 
 	if (regno > 256) {
-		pr_err("regno = %d\n", regno);
+		dev_err(info->device, "regno = %d\n", regno);
 		return -EINVAL;
 	}
 
@@ -834,7 +836,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	ret = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (ret < 0) {
-		pr_err("Could not allocate memory for cmap.\n");
+		dev_err(info->device, "Could not allocate memory for cmap.\n");
 		goto exit;
 	}
 
-- 
2.43.0

