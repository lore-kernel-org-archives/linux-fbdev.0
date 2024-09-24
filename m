Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DA1ABEBD;
	Tue, 24 Sep 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194410; cv=none; b=YuXq30Mc28zkoHDax63VcibeHva0E/gfUQk9oZyjZDKRL9UCC4FfBLj5D57V+1x8Z8YGcuvIOnppsEObWxiIWJ12QRi8XAQzI8Bk6rcmoMf0UxfcIPD8oU+fBv5n3uT6YdExtT5yCxfTlC5Hjh31TwK6v9ZiPdPNIvJv+e0YVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194410; c=relaxed/simple;
	bh=t6AjbKcGVGH4Lyk3hdDpgm5HtA6JgD4/Qz6lHPOv/2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRgfGxfuo2tKg/N2EBR5aOmRzA5j2kkNhLtYyMxQvJtHTUKAOe1Gr0URjeyi9okqT3ODaxQcOTRNfIfcjFYxZtlacETzPQ5T4FU+LIWWiZ68vs38vJxk4IT1wOAnHEgXySgQGCR9vqKlGdAefIW16uz3Pd9wWFn8J/zd/IeWxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LH/wwFNF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LH/wwFNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=BrH8uwAPz6dm19tTD8qJUI3oNOdqcPltQmXlOJbEMcY=;
	b=LH/wwFNFtFU31UGknMkYN0PYfJIIIGyhE6xwTbQJiAjs0oksSJ5pzsXd3Sgwdr
	zYcuBWGSr73C/EAXKc0NxGHeVxtBQJGD78twN4jvSYkMfxNEX+Q7sgCDfA7auhYL
	PDpDTG6n223mS9RI6d8Vj/aOcZK6xNkTXkr6IvjrWupa8=
Received: from localhost (unknown [60.168.209.67])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wA3P38S5fJmrprUDA--.36212S2;
	Wed, 25 Sep 2024 00:13:07 +0800 (CST)
Date: Wed, 25 Sep 2024 00:13:06 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Subject: [PATCH v2] fbcon: Fix a NULL pointer dereference issue in fbcon_putcs
Message-ID: <ZvLlEpIMQnJcJsla@thinkpad>
References: <20240916011027.303875-1-qianqiang.liu@163.com>
 <a57734e8-ffb9-4af1-be02-eb0c99507048@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57734e8-ffb9-4af1-be02-eb0c99507048@gmx.de>
X-CM-TRANSID:_____wA3P38S5fJmrprUDA--.36212S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWkCrWUZr1fAF4kCw4kWFg_yoWDuFg_CF
	95ZF95X34qkF17KrnYyF13Jr90y34xur1S9a4qyFW3Cry3Ar1rXr4DZw1rWryfGFn7ZF97
	J3sF9r40v3yfCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUexpnPUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwdkamby4gU23AAAs-

syzbot has found a NULL pointer dereference bug in fbcon.

This issue is caused by ops->putcs being a NULL pointer.
We need to ensure it is initialized properly.

Reported-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d613ae53c031502687a
Tested-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 Changes since v1:
 - Initialize ops->putcs by calling set_blitting_type()
---
 drivers/video/fbdev/core/fbcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 2e093535884b..d9abae2516d8 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -861,6 +861,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
 			return err;
 
 		fbcon_add_cursor_work(info);
+	} else if (vc) {
+		set_blitting_type(vc, info);
 	}
 
 	con2fb_map[unit] = newidx;
-- 
2.34.1

