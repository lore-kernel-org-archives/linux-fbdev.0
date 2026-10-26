Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026786;
	b=2kkE7tuN8Cd2k+/7+TOxMg71VD7rcS+f8bIT9XVIIjdQLfRjeCKMLpR1t7DNosoCjgGr
	 7UI5AJ5TthdCyX6KIgt7IHP3n8d5qnSvFOeBR8ZfypCa6q7i74pqXg/GVugg4gFjRt3Rz
	 DkOxKmrqlRNwuZQqHRH3HHB0tCvjye0oKb3iVF5EhTt3Qtrr9wsGkpzR1djC3KPshg0Gm
	 Qa12NcMdOtYJ0Ji99Q5nknN5URPDLlyQhbY0thqKUwkSrVD4QdN7Xx1YWRcOl7CGSJAVb
	 /7nWJ6yVZwszCBmhomM3ZvocoGnYb3VzCevIvnT8jR1YynBF8kSB98hZwwqRAzFeybg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0hZu4fC9M40eXtw7zx0zkLs5DS7aBYk38bRzFK4atkQ=;
	b=GlyR7lq6vsh1zM2yft7vwUOG7aYeBpw9bF9TSTR37Zlh0zmRD1eNqxOUs8E+q0zijMjX
	 pnwiFZMBL/AQov0fvGPBpSK04vRgjBNb1JBocab4nAcd/scEVZe2R/N+PfZu+WcjmjpoG
	 CXvUgbLpqbN/lXJXvaudxpelTrNt4YJNz49e2BxQvQEk/Z7neEcQkSkIBG5JT1mJ+Zih8
	 HQsUSTV+NSoEmNkCAkUr3TAaleFOazdx7jhL8zlioqgizws9KHQRB2ZfYXrw747H+Zvfe
	 +blfJHffn/mWXoT38t3TxBM9yve4lizX1ojIf80CxRNBhetuHHFYE6JfxpQr03cAxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mQy8fw7u;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B9606A31D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 14:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A90B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mQy8fw7u
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-164f08a9e84so1056944c88.1
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026785; x=1793631585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0hZu4fC9M40eXtw7zx0zkLs5DS7aBYk38bRzFK4atkQ=;
        b=mQy8fw7uM92wWWIpdiHyh9wLBq09jjxq+zed7nK0I4uMFJsjwo4T9dRlW9l/8wRBSE
         KARQf98Cx0m2nG+1l2veSKT52Qf9C0jBOxauCrb1dSCfYr4hJr5Yo6u1bmBHgpEZiNww
         jREkZpdX9W0EkNkfRh6w4765LMxQg4E0nkVaFir6rtGeXI30z60OxyvlJdAlXul/IRsO
         yQqYbY2nZI0C3f3UX2h+OtQy8pipnbCslAG0NLxng/2/cm5088gu/bHB70Nb8Xqzeolw
         3j+AvpIEh80m6FN7IUbrRaJY0qdh48F8HvR9p7TblAPI8tObbxW0pU257bKxxXxIBsGV
         74gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026785; x=1793631585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0hZu4fC9M40eXtw7zx0zkLs5DS7aBYk38bRzFK4atkQ=;
        b=c5Vn7amJO7L/EJC008YFjuL5owAJuMgoIN9ney4UAcHNUNrkG2SpsNPUQxJX/stL/I
         59forAMuonbJoW4P5bALu3ibP1QxxbXfhNREUklW+3exOotvs6jUJ/E9Tnuqfv9zhXl6
         +DHcuF6rtwbs9q9G2pbsG7WStzQ3aW4nvKExAnkNz96UlACDWzUlG2HMbqq3R3Oupdm9
         rHsDSG81EX8iIRTH2sjI44LsAK8PJicDgEiJPDludD55e4ClxHy1n9mGqYYTo67NVNql
         l9pM9i4vbMaFth0r+pUy27zyYke1hFVgLjNr7+FgZ8IGOaZPDmh5aVfEuAnMqeM0SkTP
         k7OA==
X-Forwarded-Encrypted: i=1; AKwUvBwGUl5ntGfiHzLl7e/cw9SVxj8cl7WyjISYt4HxLerOMg+4mdxN/X4IPBe1w4cDFdKTyDKpEqJhvNZo3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLRMbEhKC4wOWj97+gRjlLH7M99BtAfujc1PhZwywXVBY5pF2u8
	Nh91qH30F2dNwlNvbl0gApivVjAECzPE7uaL87kxTfTmRWNM2jD9ACK7
X-Gm-Gg: AYBFou1GXQnANV2Fgf2TB495MPl9jELnNK8HKPbHfWZL+P1vBoTDFtM/n6GfJCecr8M
	JsBy/cLYfyjNP/Qw8GI7v4o+hA6YYRB/m3shLKvx8ZbiWAnGSuQiReGpBmut86T8tfwTU0RIYF8
	X4chnNPJ9D0EA5Ehv17tl/kfeoRTD+htr9Bn186wCWEvFKj5p+BypRoyPjDx8Q9AiLIBYJL2bm9
	ucxVWrLxV2i29Q8YHNoxkok+MlzGs7gYDioHsvxrgDV5MtwIUWn9r2gibFIIvOAYc8Cuj5Nxjj4
	NhzX9kcpgimNoGpJK+MTed9g2+OL9HfbJdh/BvSCdF+hvn1n39m1yWus0Fj9xkWJKveatOg3o4r
	hMw2LBdka5GCo8BpiAEVnjtKyzaAmoVrwcXWRTvakPxqm1KV0a4RLvTsVD5DtlHOGN1nBt8oGTa
	8SjTDboXXP/af8UPkbUfMhP5UyhNLbMHBpgrmvtqVE/6IrILZSRyrXzHLRjPSTHvnh6m9WM80FK
	JlAY04TZphcB7eQAtaJlPd9qmmMqDzY1XoHDj71ApUUV8dNib8DhiEwRgc+oPacpzTXAs6UOc8M
	udxNIbVgDCKmyu1nVw==
X-Received: by 2002:a05:7022:b04f:b0:181:8948:f01f with SMTP id a92af1059eb24-19937309c99mr9745342c88.36.1793026784563;
        Mon, 26 Oct 2026 07:59:44 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a277b26csm28619817c88.18.2026.10.26.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:59:43 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com
Subject: [PATCH] fbcon: Avoid cancel_delayed_work_sync() in atomic context
Date: Mon, 26 Oct 2026 22:59:16 +0800
Message-ID: <20261026145916.414396-1-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_cursor() can be reached from the console printing path with
interrupts disabled, but it might sleep in two paths:

  console_unlock()                  <- IRQ disabled here
    vt_console_print()
      hide_cursor()
        con_cursor()
          fbcon_cursor()
            fbcon_del_cursor_work() <- this call may sleep

  console_unlock()                    <- IRQ disabled here
    vt_console_print()
      lf()
        con_scroll()
          fbcon_scroll()
            fbcon_cursor()
              fbcon_del_cursor_work() <- this call may sleep

When the VT software cursor is enabled (vc_cursor_type & CUR_SW),
fbcon_cursor() calls fbcon_del_cursor_work(), which uses
cancel_delayed_work_sync() and therefore may sleep.

With CONFIG_DEBUG_ATOMIC_SLEEP enabled, there are reports like this:

  BUG: sleeping function called from invalid context at kernel/workqueue.c:4722
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0
  ...
  __cancel_work_sync
  fbcon_del_cursor_work
  fbcon_cursor
  hide_cursor
  vt_console_print
  console_unlock
  ...

Use the non-synchronizing cancel when called with interrupts disabled or
from an interrupt context. We still keep the synchronizing cancel in
sleepable contexts, where it is needed to drain the work before
teardown.

Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 94abbb5ac766..f1dbf973e44b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -56,6 +56,9 @@
  *  more details.
  */
 
+#include "linux/irqflags.h"
+#include "linux/preempt.h"
+#include "linux/workqueue.h"
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -441,7 +444,14 @@ static void fbcon_del_cursor_work(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
 
-	cancel_delayed_work_sync(&par->cursor_work);
+	/*
+	 * fbcon_cursor() can be reached from the console printing path with 
+	 * interrupts disabled. Only synchronize when sleeping is allowed.
+	 */
+	if (in_interrupt() || irqs_disabled())
+		cancel_delayed_work(&par->cursor_work);
+	else
+		cancel_delayed_work_sync(&par->cursor_work);
 }
 
 unsigned char *fbcon_cursor_glyph(const struct vc_font *font, unsigned int cursor_type)
-- 
2.56.0

