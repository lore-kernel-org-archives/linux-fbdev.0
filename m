Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436D211A14
	for <linux-fbdev@vger.kernel.org>; Wed,  5 Aug 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937920; cv=none; b=o99ENgfygavhR4hEfqyQeekQv2dyBAo7XHPoWFXjxI3rk8EhJVWsNpb4I7v9vaZKxrcvd0NuL4WyAwexwBBgadLyoHnCfaV6pNZblrBmWr5v6TMGHP1Cx9kEgV+zT3WIS980yzTeawpURhxB2BTMd/3I6SYB2BF5oVkYibTQvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937920; c=relaxed/simple;
	bh=Hr4xVAWPpDxP0gJqh+0e/jLhco6EMuXZJGrnnrCipiA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SVmmZWNHGwD/viYDznxiS+UeS7T+UE18gpz5yjfcQY0fSPFJbGAGsDkEHRJatLSggSykxqwXu7AkJaGL3drcNCrI4ZiYc0PpInGGmkgKZ3wYF/5SY5oA+vvhLz/mroZoJ3Uxc7SJh350a/AxhdqsmyhAo2QLsi2rplMaQxxaCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X7uo5iM5; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X7uo5iM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6kljpvv6hrglppv5cwl3usy5c4.protonmail; t=1785937905; x=1786197105;
	bh=chdGDX++TvBPFjBRHN0cQC/MRwsAhgfHznIjcup1gYY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X7uo5iM5/ktQ+sn/4GRGvmnwJW6UqbDVOkRS8oWXVJp8hZKKqIIFErA+wjsYi6BYu
	 KoDKUWlY1aWWj5sA6bXpUhaJsj7erOM78EFrRFWjlKrVefmW3o0duWSaV6rKZbxLIY
	 +CCter+fhZt77Jy8Gu3RTFmR3gEfyYWisSBsbfgFPivqp5oo7Mcpwpflqj3oPYJ4LM
	 mgKUU3h04RbmuZOFStcWOdZUxGRdMkT+NAywJAv7GPYTUKeJZVQvbglG0lqp4WWvQ3
	 t/XRiL6Vt086Im2uUwuKmNFRcZmXvBAU+B1koEZ+XkzfwzLAkn00yBH/kEM21LXVjv
	 1noH1sKOjxbnQ==
Date: Wed, 05 Aug 2026 13:51:39 +0000
To: lee@kernel.org, danielt@kernel.org
From: Levente Szajko <raedrimhun@proton.me>
Cc: jingoohan1@gmail.com, deller@gmx.de, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Levente Szajko <raedrimhun@proton.me>
Subject: [PATCH] video: backlight: Use sysfs_emit() instead of sprintf()
Message-ID: <20260805135027.43890-1-raedrimhun@proton.me>
Feedback-ID: 100557472:user:proton
X-Pm-Message-ID: 72184ef1d741a4d62fd5bcf41e6fb1132ae52a94
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replace sprintf() with sysfs_emit() in the sysfs show callbacks of
backlight.c and lcd.c, as recommended by Documentation/filesystems/sysfs.rs=
t.

No functional change intended.

Signed-off-by: Levente Szajko <raedrimhun@proton.me>
---
 drivers/video/backlight/backlight.c | 16 ++++++++--------
 drivers/video/backlight/lcd.c       |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/=
backlight.c
index a22d0bbb6e63..fc9bb303e8c5 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -139,7 +139,7 @@ static ssize_t bl_power_show(struct device *dev, struct=
 device_attribute *attr,
 {
 =09struct backlight_device *bd =3D to_backlight_device(dev);
=20
-=09return sprintf(buf, "%d\n", bd->props.power);
+=09return sysfs_emit(buf, "%d\n", bd->props.power);
 }
=20
 static ssize_t bl_power_store(struct device *dev, struct device_attribute =
*attr,
@@ -180,7 +180,7 @@ static ssize_t brightness_show(struct device *dev,
 {
 =09struct backlight_device *bd =3D to_backlight_device(dev);
=20
-=09return sprintf(buf, "%d\n", bd->props.brightness);
+=09return sysfs_emit(buf, "%d\n", bd->props.brightness);
 }
=20
 int backlight_device_set_brightness(struct backlight_device *bd,
@@ -228,7 +228,7 @@ static ssize_t type_show(struct device *dev, struct dev=
ice_attribute *attr,
 {
 =09struct backlight_device *bd =3D to_backlight_device(dev);
=20
-=09return sprintf(buf, "%s\n", backlight_types[bd->props.type]);
+=09return sysfs_emit(buf, "%s\n", backlight_types[bd->props.type]);
 }
 static DEVICE_ATTR_RO(type);
=20
@@ -237,7 +237,7 @@ static ssize_t max_brightness_show(struct device *dev,
 {
 =09struct backlight_device *bd =3D to_backlight_device(dev);
=20
-=09return sprintf(buf, "%d\n", bd->props.max_brightness);
+=09return sysfs_emit(buf, "%d\n", bd->props.max_brightness);
 }
 static DEVICE_ATTR_RO(max_brightness);
=20
@@ -251,9 +251,9 @@ static ssize_t actual_brightness_show(struct device *de=
v,
 =09if (bd->ops && bd->ops->get_brightness) {
 =09=09rc =3D bd->ops->get_brightness(bd);
 =09=09if (rc >=3D 0)
-=09=09=09rc =3D sprintf(buf, "%d\n", rc);
+=09=09=09rc =3D sysfs_emit(buf, "%d\n", rc);
 =09} else {
-=09=09rc =3D sprintf(buf, "%d\n", bd->props.brightness);
+=09=09rc =3D sysfs_emit(buf, "%d\n", bd->props.brightness);
 =09}
 =09mutex_unlock(&bd->ops_lock);
=20
@@ -267,9 +267,9 @@ static ssize_t scale_show(struct device *dev,
 =09struct backlight_device *bd =3D to_backlight_device(dev);
=20
 =09if (WARN_ON(bd->props.scale > BACKLIGHT_SCALE_NON_LINEAR))
-=09=09return sprintf(buf, "unknown\n");
+=09=09return sysfs_emit(buf, "unknown\n");
=20
-=09return sprintf(buf, "%s\n", backlight_scale_types[bd->props.scale]);
+=09return sysfs_emit(buf, "%s\n", backlight_scale_types[bd->props.scale]);
 }
 static DEVICE_ATTR_RO(scale);
=20
diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index e918f57608ef..461e393837d3 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -77,7 +77,7 @@ static ssize_t lcd_power_show(struct device *dev, struct =
device_attribute *attr,
=20
 =09mutex_lock(&ld->ops_lock);
 =09if (ld->ops && ld->ops->get_power)
-=09=09rc =3D sprintf(buf, "%d\n", ld->ops->get_power(ld));
+=09=09rc =3D sysfs_emit(buf, "%d\n", ld->ops->get_power(ld));
 =09else
 =09=09rc =3D -ENXIO;
 =09mutex_unlock(&ld->ops_lock);
@@ -118,7 +118,7 @@ static ssize_t contrast_show(struct device *dev,
=20
 =09mutex_lock(&ld->ops_lock);
 =09if (ld->ops && ld->ops->get_contrast)
-=09=09rc =3D sprintf(buf, "%d\n", ld->ops->get_contrast(ld));
+=09=09rc =3D sysfs_emit(buf, "%d\n", ld->ops->get_contrast(ld));
 =09mutex_unlock(&ld->ops_lock);
=20
 =09return rc;
@@ -154,7 +154,7 @@ static ssize_t max_contrast_show(struct device *dev,
 {
 =09struct lcd_device *ld =3D to_lcd_device(dev);
=20
-=09return sprintf(buf, "%d\n", ld->props.max_contrast);
+=09return sysfs_emit(buf, "%d\n", ld->props.max_contrast);
 }
 static DEVICE_ATTR_RO(max_contrast);
=20
--=20
2.55.0


