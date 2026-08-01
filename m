Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACEF3A254D;
	Sat,  1 Aug 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611430; cv=none; b=G10YHJdlLfZEkFakCPzgQW8HMzRfCcs7Ga7gBK+IPPLjY1IYZ4JodRuD6qvqh5kK1Dj0gQnWKmGg/+Zr1sA9pDq6xjhp1LR+8wdn6lLaoJD2k9igcNcu5CmDKi2VeoPVaKuMeWDUbot1xXcnMQK0HrxYlHe7+j20NkdhnA/0FPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611430; c=relaxed/simple;
	bh=nLxkyXOVH77n4UIw8DlmeUNyLMAGobPDCY21NNsP5+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kqMxHUrX7id3nZHLFXqBamN5hCaLRYEpFB4PoNr0yqG4HoB6JeZm1GDB6wvTw3zaoU4+xFPACvq19wp5mgYF28IQb+huVDkrvGS7rCcStt790UGuBCt1+wjtMcDsjvKQ8W/ycs3yMBbGdukaj3YgFprCwXfT4iyElIz7kNUFOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=PvW93Bdv; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="PvW93Bdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Obf+OAwdCbGTMg5s8OMIUCRXXMLFg7TjgwLzcmwd1Hk=;
  b=PvW93Bdv2aVz7I9Ur0XKzFex8YvgHW7R30T5j8keacmHsr5vdbh5Y00W
   bVET7D0PbHpLZCN1h5CsOsrnACHouyovfMsQOZJIfWM6tn+LLowD1nyL7
   5LC+NofowRfjUCE+BwKn9SQmAJSNGz9tAt7jv6D5L/si4k6h+f3yXLyHW
   U=;
X-CSE-ConnectionGUID: 8JUcfgo3QPuyUUTvvQfNYA==
X-CSE-MsgGUID: OlJOKjkRQ/exrGUcgFwTEg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="288769004"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:08 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Helge Deller <deller@gmx.de>
Cc: kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: au1100fb: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:49 +0200
Message-Id: <20260801191002.1383835-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/video/fbdev/au1100fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index c54cfcd83..39f86ffb1 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -393,7 +393,7 @@ static struct au1100fb_panel known_lcd_panels[] =
 #define DRIVER_DESC "LCD controller driver for AU1100 processors"
 
 #define to_au1100fb_device(_info) \
-	  (_info ? container_of(_info, struct au1100fb_device, info) : NULL);
+	  (_info ? container_of(_info, struct au1100fb_device, info) : NULL)
 
 /* Bitfields format supported by the controller. Note that the order of formats
  * SHOULD be the same as in the LCD_CONTROL_SBPPF field, so we can retrieve the

