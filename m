Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B9254851;
	Tue, 11 Mar 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692585; cv=none; b=Sa7Z1WcRZTgQqTBPQVVJHQrIUK0YNC4Jo1i/i0/MB4eJQ+Nqenz+jIeExmZRZLBsGyl4wp+Lv06Yk20Iqktl5Mtp2yIggbLmyRD1GcL8+6NTjHZBNiViVwQDpVaQrR5ZOguWujTnElbStk3OoNy/5/+0mgTW6BXJ7XtQN7PhdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692585; c=relaxed/simple;
	bh=Tu/4a3eRN8s8yAnyoNfjovhhGoXRq9gQ3orbX3fSyfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j02Yov+t2gEPkC+6ow7l2FIyr4NjxNcmxLIJYJHMHvpyFq/3H0xe3et2ID24BgDsKhUY1Ic3qg5l/MnpiNefGGDIIeBbMsY6fUhyW9ieyrjWJOt+T/pgxgi5IQlgVrWZpZMu20OU1VNSt1cj3zrmepQDNNLBHXP8W4jo5+9JRVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oeO82pSr; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oeO82pSr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SM9Ub
	Ll72nXfMLjNLt6sWlifM6ckJcGNSdk6TeIigO4=; b=oeO82pSr0V+mkKe+cTj6F
	MtKUCbiTBEjXEhQ8WTR78xGJ2VyPl/i8KE96XN1VKpHEW/zeB3nNHa5BNbwZiejs
	dQkzRtzoWY5DumqMnCHJlGk/QYyJHXFiFmHfuENJ1b87RVICPqoBgY77Accxm50K
	RrYLHXluzk4EKo4TiTDgoM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCH0Ct6HtBna0J3Rw--.58446S3;
	Tue, 11 Mar 2025 19:29:04 +0800 (CST)
From: oushixiong1025@163.com
To: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 2/2] fbcon: Change return value type to void
Date: Tue, 11 Mar 2025 19:28:56 +0800
Message-Id: <20250311112856.1020095-2-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311112856.1020095-1-oushixiong1025@163.com>
References: <20250311112856.1020095-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH0Ct6HtBna0J3Rw--.58446S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDurykCw4kAFyDAFyfXrb_yoWftrc_Cw
	1DZr95XrykKry0kwnag3W3u3yYqa12qa1rGr1DtF95Ja47tryFqr4DZr1qqrWqgF18ArZ0
	q3Zrtr4Ivw1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0xOz7UUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXBgND2fQGIlhsAABsw

From: Shixiong Ou <oushixiong@kylinos.cn>

fbcon_init_device() doesn't need to return a value.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/core/fbcon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 51c3e8a5a092..c1692b68f69e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3296,7 +3296,7 @@ static const struct attribute_group fbcon_device_attr_group = {
 	.attrs		= fbcon_device_attrs,
 };
 
-static int fbcon_init_device(void)
+static void fbcon_init_device(void)
 {
 	int ret;
 
@@ -3305,8 +3305,6 @@ static int fbcon_init_device(void)
 	ret = device_add_group(fbcon_device, &fbcon_device_attr_group);
 	if (ret)
 		fbcon_has_sysfs = 0;
-
-	return 0;
 }
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
-- 
2.25.1

