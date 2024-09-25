Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8AF14A62F;
	Wed, 25 Sep 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242202; cv=none; b=YitBfq703jsaB3omdE+ZZbt4VAEmsceXWYLq9tFNSgJv5qdLK/9zjSu90HH7GUr7XAVBxaiR1x2J2o7TbuGKznUfIK+7tLZQ0UEXQqkh6PrSB8UycFn5IbD/0kmwFepkiX+MBOSkFVzOz/uDNXLFVUjDiIKmAFf4V2PPPYdL7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242202; c=relaxed/simple;
	bh=jGpqJbVzRpKzy5QsoMynmjUtdDYVRQ+bX/xMcnAWlUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA8DKZ6bM0SlrdrOwinQ7rXjHVBFo1Q3BKLdyjk79HmVm/yixI6mxRojW2vO5dATe3mjHZnFELIxjd9QY9PkR78+cqRAVCnbDCkiQvjN+w0HTW7Q/HCmVx+g4ZcVlu3NkigAOsTiGgWE5UOMIduYxEAjboSPxkGaWgigDzHIbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WkKDmf+i; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WkKDmf+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=aqkoSnEgaj9DVcjWERksyIfsDRhiR+luevjNipHPwIo=;
	b=WkKDmf+iFDYdvla8K6TRmY4PJxkiiKAgpydWfGjqsQvAclMl9q0/MehBHbG608
	8NVPjwLY+uwMzyoZgCep4glrcOlK+X94WxQosk9jbvB563JaYLZaAv6zBMb8Drjk
	dDLRg1pJoNAlchuKGPFMWbmC1XzGsfvk/TubUu9WUKEgs=
Received: from localhost (unknown [60.168.209.67])
	by gzsmtp2 (Coremail) with SMTP id sSgvCgAXg_7An_NmfUNVAA--.16028S2;
	Wed, 25 Sep 2024 13:29:37 +0800 (CST)
Date: Wed, 25 Sep 2024 13:29:36 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Subject: [PATCH v3] fbcon: Fix a NULL pointer dereference issue in fbcon_putcs
Message-ID: <ZvOfwLvWdNHiU4g8@thinkpad>
References: <20240916011027.303875-1-qianqiang.liu@163.com>
 <a57734e8-ffb9-4af1-be02-eb0c99507048@gmx.de>
 <ZvLlEpIMQnJcJsla@thinkpad>
 <1b1a2d3c-ed4a-4d9b-b87a-8d05f3d6592e@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1a2d3c-ed4a-4d9b-b87a-8d05f3d6592e@gmx.de>
X-CM-TRANSID:sSgvCgAXg_7An_NmfUNVAA--.16028S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF17Jw4xJw1xJryDur1ftFb_yoW8uFykpF
	W5tFWaqrZ8try3Z34jgr4xZr1rXas8ArWUWayFqa4fZFnFvF18WFyIgryUCrWru3W0kryx
	KF1jy3y2kas3WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jEdgAUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxtlambzkrb51AAAsn

syzbot has found a NULL pointer dereference bug in fbcon.
Here is the simplified C reproducer:

struct param {
	uint8_t type;
	struct tiocl_selection ts;
};

int main()
{
	struct fb_con2fbmap con2fb;
	struct param param;

	int fd = open("/dev/fb1", 0, 0);

	con2fb.console = 0x19;
	con2fb.framebuffer = 0;
	ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb);

	param.type = 2;
	param.ts.xs = 0; param.ts.ys = 0;
	param.ts.xe = 0; param.ts.ye = 0;
	param.ts.sel_mode = 0;

	int fd1 = open("/dev/tty1", O_RDWR, 0);
	ioctl(fd1, TIOCLINUX, &param);

	con2fb.console = 1;
	con2fb.framebuffer = 0;
	ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb);

	return 0;
}

After calling ioctl(fd1, TIOCLINUX, &param), the subsequent ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb)
causes the kernel to follow a different execution path:

 set_con2fb_map
  -> con2fb_init_display
   -> fbcon_set_disp
    -> redraw_screen
     -> hide_cursor
      -> clear_selection
       -> highlight
        -> invert_screen
         -> do_update_region
          -> fbcon_putcs
           -> ops->putcs

Since ops->putcs is a NULL pointer, this leads to a kernel panic.
To prevent this, we need to call set_blitting_type() within set_con2fb_map()
to properly initialize ops->putcs.

Reported-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d613ae53c031502687a
Tested-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 Changes since v2:
 - Document the commit message in more detail
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

