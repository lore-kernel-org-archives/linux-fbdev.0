From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5 offb breakage
Date: Wed, 31 Jul 2002 10:18:45 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207311018150.13905-100000@www.transvirtual.com>
References: <20020731124905.12781@192.168.4.1>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Zx7Z-0006OR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 Jul 2002 10:18:49 -0700
In-Reply-To: <20020731124905.12781@192.168.4.1>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Oops. Here is the patch. Let me know if it works.

--- /usr/src/linus-2.5/drivers/video/Makefile	Tue Jul 30 22:55:21 2002
+++ Makefile	Wed Jul 31 10:08:02 2002
@@ -60,7 +60,7 @@
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_OF)               += offb.o
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblit.o cfbcopyarea.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_CLGEN)            += clgenfb.o



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
