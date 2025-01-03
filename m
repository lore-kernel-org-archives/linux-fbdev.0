Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DDC189902;
	Fri,  3 Jan 2025 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874810; cv=none; b=IyfX+bkAPZU+dzz0ElKMG6a8uGlGMC3S9jxN68qaEJDN5nUGOIO2dKemSrtXXc32dQIbf7tv1pUMwUNXRjws2oqISZ4BuK/wvmMA3oACG7R0h9ng4ZhXQRErhxoeUmUAHB3Etizk0RQOK+aMr6QRxB7jME3f75EZU0Bb1jADN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874810; c=relaxed/simple;
	bh=L2iWIQcqhGPCsl2QlqJqH6tc3Xxv7oK8rgP045YgChw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StU3IDgLexbLiUym7yE27ZYXHXGhqQmDmip0B7X1VKpIAassNboCXtKnezRFY1Ixh7HEEoUgggdkucFyhEqzjZcdB2MpMPRwry9hoZA5ufk8b0YnXwr24ltf2x/teSvQYP4uZ0IEfddRl5E3mTh9AUJ/HkoR3s1/WM/abXAPBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SToAFvDK; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SToAFvDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B4KeP
	p60jPUMgspDF+ld1z+FbtKzxwAdGj/2H6fY3FM=; b=SToAFvDKzVNBI4hJjKW8b
	+b+ju1kooz5OUlNNLP/HEDziSo8I9skCTZCCM5N8/q3s368s+C1nFcwxDkeWxt5U
	b8oPgHfkZkKAkSREm4E4euWzUyQBx7nKLbZqnEKctBwlH10XdIDmnHjtOFwNyeLP
	aLSH+fd3V/k/0LHCHokE9g=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXNVfqWHdnyHcDJQ--.21003S2;
	Fri, 03 Jan 2025 11:26:35 +0800 (CST)
From: oushixiong1025@163.com
To: Peter Jones <pjones@redhat.com>
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] fbdev: efifb: Change the return value type to void
Date: Fri,  3 Jan 2025 11:26:33 +0800
Message-Id: <20250103032633.98807-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCXNVfqWHdnyHcDJQ--.21003S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3WFWfAF47uF43uw1fXrb_yoWfWwc_Cw
	48ZFW7JrWqkryF93yIka1Sv34aya1DXw1I9Fn293sxJFyUG3s3A3y7Zrn2qa4DWr4kCFnI
	ywnFgryFyr1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8dR65UUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXR3JD2d3VelIhQAAsn

From: Shixiong Ou <oushixiong@kylinos.cn>

efifb_setup() doesn't need to return a value.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/efifb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 20517448487e..0e1bd3dba255 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -275,7 +275,7 @@ static const struct fb_ops efifb_ops = {
 	.fb_setcolreg	= efifb_setcolreg,
 };
 
-static int efifb_setup(struct screen_info *si, char *options)
+static void efifb_setup(struct screen_info *si, char *options)
 {
 	char *this_opt;
 
@@ -299,8 +299,6 @@ static int efifb_setup(struct screen_info *si, char *options)
 				use_bgrt = false;
 		}
 	}
-
-	return 0;
 }
 
 static inline bool fb_base_is_valid(struct screen_info *si)
-- 
2.25.1

