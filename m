Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ED81798F;
	Thu, 26 Sep 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351988; cv=none; b=EGT8RwaYcJEnI4ey86jvwWFJqRm78NLZncnvW8Tl2K5xq4HTY8Xg8uG4AzpT7BKUAirR1UNN1SRPUjUBoTbMiscDEuQO6YyD/PzyVSfZ4TX4jONWu4Ci4f1SilBARrQIBrEa7MU+b834VXjfhO5oGBYfg/AEyKUUiXVKY4rR31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351988; c=relaxed/simple;
	bh=y+nY+Te9CMW3SoF1lkygRmaQ0k3UjH69fBcRe15h5OM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bz09fnGnjUbZVEW3jRdJoOLG0epkWGA/YUZ92kkGogZsf+Ef9vr0xQRj6lAtHmpzKP/VyqK+Cu9UcKPYcs62Mch0WnB1Ysat2m9sqNk7HKEF9Fb7C/c+m4W3tzBxePfwqr+skfi37Chj4CaPFBU28XiR5Yc00uXYUDjmsjft4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JThb5KHB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JThb5KHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=F5vYX
	8/opjvE5wTUAnPujK6sAT6th5nnz2xNAH+qpyg=; b=JThb5KHBs/mXH7Jj2s7YN
	8Ko3Rp8ib5v4XzMqqrZM82an+1xVXRI8iasLBGXrV94khdTXPTVLCkvouxvtPvkG
	D/sOYSDQKvZxxtCvbEMU8DvsQfSo1ISNs34YeATgRordApnZ3AtuLmpDRiCsg9W3
	qu03wgAISnxHl4aEQ3qmqY=
Received: from thinkpad.. (unknown [60.168.209.67])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wCnK6aZTPVmuaNDPA--.52970S2;
	Thu, 26 Sep 2024 19:59:21 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] fbcon: break earlier in search_fb_in_map and search_for_mapped_con
Date: Thu, 26 Sep 2024 19:59:11 +0800
Message-Id: <20240926115911.620624-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnK6aZTPVmuaNDPA--.52970S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4xGw4UAr45tryfJF48Crg_yoWfurc_GF
	1vvF95CayDtFy8Kr1rK3W3A34Yva1jva45WasrtF9Iy342q3yrXr4fZFn5XrWrWa1rZFWq
	vF1kJrn3Za4rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUJ5rDUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxxmamb1RZ5vGAAAsA

Break the for loop immediately upon finding the target, making the
process more efficient.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/video/fbdev/core/fbcon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index d9abae2516d8..e8b4e8c119b5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -512,8 +512,10 @@ static int search_fb_in_map(int idx)
 	int i, retval = 0;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
-		if (con2fb_map[i] == idx)
+		if (con2fb_map[i] == idx) {
 			retval = 1;
+			break;
+		}
 	}
 	return retval;
 }
@@ -523,8 +525,10 @@ static int search_for_mapped_con(void)
 	int i, retval = 0;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
-		if (con2fb_map[i] != -1)
+		if (con2fb_map[i] != -1) {
 			retval = 1;
+			break;
+		}
 	}
 	return retval;
 }
-- 
2.34.1

