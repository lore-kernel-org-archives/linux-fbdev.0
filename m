From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
Subject: Re: [PATCH] restore framebuffer console after suspend
Date: Sat, 09 Nov 2002 03:16:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3DCC6FE9.60506@gmx.net>
References: <3DCC5DA4.2010707@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010906060804020302060701"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010906060804020302060701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,

please disregard my previous patch as it is needlessly invasive. I'm 
currently evaluating a smaller patch (attached) which does not require an 
audit of the low-level drivers and still fixes my problem.

Ben, can you please comment on this?

Thanks
Carl-Daniel

--------------010906060804020302060701
Content-Type: text/plain;
 name="patch-fbdev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fbdev.txt"

===== drivers/video/fbcon.c 1.12 vs edited =====
--- 1.12/drivers/video/fbcon.c	Thu Sep 12 17:22:35 2002
+++ edited/drivers/video/fbcon.c	Sat Nov  9 02:57:00 2002
@@ -1573,7 +1573,7 @@ static int fbcon_blank(struct vc_data *c
 	return 0;
 #ifdef CONFIG_PM
     if (fbcon_sleeping)
-    	return 0;
+    	return blank ? 0 : 1;
 #endif /* CONFIG_PM */
 
     fbcon_cursor(p->conp, blank ? CM_ERASE : CM_DRAW);

--------------010906060804020302060701--
