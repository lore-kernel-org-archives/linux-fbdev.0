From: <torn@autistici.org>
Subject: Re: [PATCH] New radeonfb fork
Date: Wed, 9 Apr 2003 14:38:58 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <56639.80.180.244.42.1049891938.squirrel@squirrel.autistici.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns.investici.org ([213.140.29.37] helo=astio.investici.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 193ErQ-00075a-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Apr 2003 05:39:28 -0700
Received: from autistici.org (localhost [127.0.0.1])
	by astio.investici.org (Postfix) with SMTP id 4F8B533691
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  9 Apr 2003 14:38:58 +0200 (CEST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi Ben, I'm trying your patch on a toshiba notebook (satellite 1900-303)
with an ati radeon mobility m6. It's a bit early to say that (almost)
everything works good, but at the moment it seems so.

During the kernel compilation  I encountered some problems due tu missing
#defines. In detail, the probles was in the replacement of
PCI_DEVICE_ID_PDC_1841 in .._PDC_ADMA100 and of .._CMD_680 in .._SII_680.
Adding the old lines solved the problem. Maybe you are using a kernel
patch that modifies that code, and you did the diff against that sources.
Or (more probably) there is another logic reason I don't see.

Another thing I must tell you is that with your driver, but also with the
old radeonfb and with the xfree86 driver, some strange screen flicker
occours sometimes. When this happens I see several undefined horizontal
lines all over the LCD screen. Changing video mode a couple of times makes
the screen return to normality. I guessed that this behavoir is linked to
pixclock changes (changing the pixclock value via fbset 2 or 3 times makes
the screen flicker, another couple of pixclock changes make everyting
return to normality). Many people with notebooks with mobility M6s graphic
cards reported this problem. With windows this never happens. This is VERY
annoying.
I hope I can help the driver developement, if you want me to try something
in particular, just tell me.

Paride
torn@autistici.org





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
