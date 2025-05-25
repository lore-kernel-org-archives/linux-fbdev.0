Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933211F09B6;
	Sun, 25 May 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169637; cv=none; b=q6WCeXSi3+D+4Oe/d5WokNygbUVgeYUG3lY/i2/602LwGXQWMWct4c23Z6mKQD8/N14nAlnFa6rx/OMi+sK5In7WmCsMa93NFI+32rv4iZKAHSRPGa07dYnzPNQ1KXWVGTLxZdgmJVlkZcvU6TNYhQj/CkUxfcARIapBIGuts9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169637; c=relaxed/simple;
	bh=nO6zb6SjCFPUZ7IEufrR6PiJ70F6QMV0RRUqlhL9aNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBI4s1KM1vffJa/wtKGGgaZtJhgnIlsnT0GNIIKz3djUxTZx8hA/rRi9U5dXtujidEobuRFBq8ty53i3Ylwmy7N55zR695KV7I+BDp2ykdwZixgb+IhHo3wZD354M9P9g4kIlYPAt45sepBRPN7w3XkfN3NK3ZqqLW54gjKjBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXvN6I5G; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXvN6I5G"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso983131b3a.2;
        Sun, 25 May 2025 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748169635; x=1748774435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkaxFjVGSe2Qwk7a8pqzzV8ilfKVeuiiyO9oBhvP6G8=;
        b=HXvN6I5GpnAr5lmhjAQgxOD7e+YhmQxYpXg4RVZXaeH4pUoMqcqxkR1duS7Ml8hBQH
         NPNHUzh5AsNX/CACmKZJZLH2eKzE0PHeYLbM9FzNbg5vJxtM1XYIa0X03QUjE+lgjN6g
         xYthIW6n7Bd+S/gGoFFD+xb5w3Sp1XJS8lsV7yStAXrVqnR1acUYPIoLPR+ALLh5qIAd
         QSaC96yoGfjmbWqsEMAlMVbh5sDkQoJL36KYTEfyOQ+obtarMmnCGnjNycecDCzbnACd
         wh8HyB1qylhJz+EWmq99PePFw0PsrhdYI02i8DQtogsYI6eqJPatKfPhcLj5D78XdcVk
         WaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748169635; x=1748774435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkaxFjVGSe2Qwk7a8pqzzV8ilfKVeuiiyO9oBhvP6G8=;
        b=iuULv2agAgWyw4VgIsC1bxDTztc2MN2hItit6Rlw9ok6jEbeH1d4VW/zfDDBkPoiyS
         DvPxgGwoexxhAInZqAR8/QJmcIhPLKyNSo/z6gs0gCVGf0kWDbnsojzoMCZhP4a3HOoP
         4tfWxSPwZwoc7MZP8W4LGjMZvRYhwJIdyBNZkshODyi/l7s633nJbK9dSBejM6Ks+F4N
         RgVUCo8dxEk9XH4j1/QCnVcUjyaNXsC4gOmAAUZeIjRiC6hYPbphYXCu2p8xAxZJZ1lN
         weK+bppZyPwuEpyD+rJYtTsWD6+8+adpvTEgVIMAxS3PHGrYZkryVo2F+fsyXS63swIG
         pFng==
X-Forwarded-Encrypted: i=1; AJvYcCUUcRM9jLmrXAPnm3YwYHG1znJG8zNSIqOgrNygMNmuyDRr24/Vlh8cDa9H8/yfTQsZ0mgvoGdyv/hUOQ==@vger.kernel.org, AJvYcCXZ38u3SU9JsQ0eewHJxO+fKT+phPQmWaX5Q63XC8JkeW3n/PkXYycZNBdWre0YfIx+dlxaXCylcYrP8pSc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OGzE4/CA5fPksMWmekPp7oyN1V+hnt6QLbVX4wIongrgAeCQ
	oa/wdJfuvhmlRA/uLa77fmKrMxPrkw1pTSFF5cfNlNwPSRLE/HICIK97
X-Gm-Gg: ASbGnctV6F9NZ6cmTBz4wny0+LdmghoHOs2hSM5rzhA7nUQ5/llAWOK5PX32fsjWuL0
	JVcV+IpPu8P9vSFZ6bPHzYHstqasjwbPU8NpUW6d6WO8UlSKWZPzqY8RLxHaTZcYpTA8rcJCgFf
	i2vdqwz+e6013oXgHjooJpV7RDiykD2REALKd9297WYL4Y3jw5r+/8Sm53+bDKz++EbFLU1oLqN
	7D1uk9qplYALDuf0oy5oXEaXSAT/85ndiMSy7DSFS7KfM9il9sH6CAoMDL26vUgbLjFyVFmPuQg
	mKM9bWAMKK6XcopmGkVD/siL6jFkropS39Yp7jgAvY45ydYg8g==
X-Google-Smtp-Source: AGHT+IGOV1Qoz9M8Hpj3ynpz5Bb7xb/5hezEEoZviGII3MnP9qNtCwtF+oiJboyMF+/MRa5DZgNxCg==
X-Received: by 2002:a05:6a00:4b02:b0:742:a02e:dd8d with SMTP id d2e1a72fcca58-745fe05907amr9090249b3a.20.1748169634693;
        Sun, 25 May 2025 03:40:34 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96defa1sm15833363b3a.12.2025.05.25.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:40:34 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [RFC PATCH 2/2] backlight: Improve support for dual backlight with primary/secondary linkage
Date: Sun, 25 May 2025 18:40:22 +0800
Message-ID: <20250525104022.1326997-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525104022.1326997-1-mitltlatltl@gmail.com>
References: <20250525104022.1326997-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances dual-backlight handling by explicitly linking
primary and secondary backlight devices using new fields:

- `is_secondary`: Marks if a device is secondary in a pair
- `secondary`: Points to the associated secondary device (if any)
- `primary`: Points to the primary device (for secondary devices)

It also update `backlight_update_status()` to ensure that both primary
and secondary devices are updated together during brightness changes.
This provides a consistent update mechanism in dual-backlight case.

Suggested-by: Daniel Thompson <danielt@kernel.org>
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/video/backlight/backlight.c |  9 +++++-
 include/linux/backlight.h           | 50 +++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 991702f5d..2e7b179bc 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -388,7 +388,6 @@ struct backlight_device *backlight_device_register(const char *name,
 		new_name = kasprintf(GFP_KERNEL, "%s-secondary", name);
 		if (!new_name)
 			return ERR_PTR(-ENOMEM);
-		put_device(&prev_bd->dev);
 	}
 
 	new_bd->dev.class = &backlight_class;
@@ -428,6 +427,14 @@ struct backlight_device *backlight_device_register(const char *name,
 	list_add(&new_bd->entry, &backlight_dev_list);
 	mutex_unlock(&backlight_dev_list_mutex);
 
+	/* set them until the secondary device is available */
+	if (prev_bd) {
+		prev_bd->secondary = new_bd;
+		new_bd->primary = prev_bd;
+		new_bd->is_secondary = true;
+		put_device(&prev_bd->dev);
+	}
+
 	kfree(new_name);
 
 	return new_bd;
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 10e626db7..cde992e10 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -291,13 +291,42 @@ struct backlight_device {
 	 * @use_count: The number of unblanked displays.
 	 */
 	int use_count;
+
+	/**
+	 * @is_secondary: Indicates whether this backlight device is secondary.
+	 */
+	bool is_secondary;
+
+	/**
+	 * @secondary: Pointer to the secondary backlight device.
+	 */
+	struct backlight_device *secondary;
+
+	/**
+	 * @primary: Pointer to the primary backlight device.
+	 *
+	 * Non-NULL only for secondary devices.
+	 */
+	struct backlight_device *primary;
 };
 
+static inline struct backlight_device *
+to_primary_backlight_device(struct backlight_device *bd)
+{
+	return bd->is_secondary ? bd->primary : bd;
+}
+
+static inline struct backlight_device *
+to_secondary_backlight_device(struct backlight_device *bd)
+{
+	return bd->is_secondary ? bd : bd->secondary;
+}
+
 /**
- * backlight_update_status - force an update of the backlight device status
+ * backlight_update_status_single - force an update of the backlight device status
  * @bd: the backlight device
  */
-static inline int backlight_update_status(struct backlight_device *bd)
+static inline int backlight_update_status_single(struct backlight_device *bd)
 {
 	int ret = -ENOENT;
 
@@ -309,6 +338,23 @@ static inline int backlight_update_status(struct backlight_device *bd)
 	return ret;
 }
 
+/**
+ * backlight_update_status - update primary and secondary backlight devices
+ * @bd: the backlight device
+ */
+static inline int backlight_update_status(struct backlight_device *bd)
+{
+	struct backlight_device *primary = to_primary_backlight_device(bd);
+	struct backlight_device *secondary = to_secondary_backlight_device(bd);
+	int ret;
+
+	ret = backlight_update_status_single(primary);
+	if (!secondary || ret)
+		return ret;
+
+	return backlight_update_status_single(secondary);
+}
+
 /**
  * backlight_enable - Enable backlight
  * @bd: the backlight device to enable
-- 
2.49.0

