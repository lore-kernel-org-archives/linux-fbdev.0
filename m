From: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Compile Error with RivaFB in 2.5.44
Date: Mon, 28 Oct 2002 13:23:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021028122355.GA18064@debian>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net


Hi !

KERNEL : 2.5.44


Here is a compile error with the frame buffer and the rivafb.

 drivers/video/riva/fbdev.c: In function `riva_set_dispsw':
 drivers/video/riva/fbdev.c:665: structure has no member named `type'
 drivers/video/riva/fbdev.c:666: structure has no member named `type_aux'
 drivers/video/riva/fbdev.c:667: structure has no member named `ypanstep'
 drivers/video/riva/fbdev.c:668: structure has no member named `ywrapstep'
 drivers/video/riva/fbdev.c:686: structure has no member named `line_length'
 drivers/video/riva/fbdev.c:687: structure has no member named `visual'
 drivers/video/riva/fbdev.c:695: structure has no member named `line_length'
 drivers/video/riva/fbdev.c:696: structure has no member named `visual'
 drivers/video/riva/fbdev.c: In function `rivafb_setcolreg':
 drivers/video/riva/fbdev.c:1202: warning: unused variable `chip'
 drivers/video/riva/fbdev.c: In function `rivafb_get_fix':
 drivers/video/riva/fbdev.c:1294: structure has no member named `type'
 drivers/video/riva/fbdev.c:1295: structure has no member named `type_aux'
 drivers/video/riva/fbdev.c:1296: structure has no member named `visual'
 drivers/video/riva/fbdev.c:1302: structure has no member named `line_length'
 drivers/video/riva/fbdev.c: In function `rivafb_pan_display':
 drivers/video/riva/fbdev.c:1611: structure has no member named `line_length'
 drivers/video/riva/fbdev.c: At top level:
 drivers/video/riva/fbdev.c:1748: unknown field `fb_get_fix' specified in initializer
 drivers/video/riva/fbdev.c:1748: warning: initialization from incompatible pointer type
 drivers/video/riva/fbdev.c:1749: unknown field `fb_get_var' specified in initializer
 drivers/video/riva/fbdev.c:1749: warning: initialization from incompatible pointer type
 drivers/video/riva/fbdev.c:732: warning: `riva_wclut' defined but not used
 make[3]: *** [drivers/video/riva/fbdev.o] Error 1
 make[2]: *** [drivers/video/riva] Error 2
 make[1]: *** [drivers/video] Error 2
 make: *** [drivers] Error 2
 stef@stargate ~/kernel/linux-2.5.44 -- 13:26 
 
Best regards


Stephane Wirtel
 

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
GPG ID : 1024D/C9C16DA7 | 5331 0B5B 21F0 0363 EACD  B73E 3D11 E5BC C9C1 6DA7
