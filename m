From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: /usr/src/linux/Documentation/fb/aty128fb.txt (fwd)
Date: Mon, 4 Oct 2004 21:19:43 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410042119240.19047@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEYNQ-0005Hb-Sg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 12:20:04 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEYN8-0007Os-7O
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 12:20:04 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Eric Pretorious <eric@pretorious.net>

---------- Forwarded message ----------
Date: Mon, 4 Oct 2004 11:59:47 -0700
From: Eric Pretorious <eric@pretorious.net>
To: Brad Douglas <brad@neruo.com>
Cc: geert@linux-m68k.org
Subject: /usr/src/linux/Documentation/fb/aty128fb.txt

Hi, Brad:

One other nitpick: In the "Configuration" section you wrote...

>Accepted options:
>
><XxX@X>  - selects startup videomode. See modedb.txt for detailed
>           explanation. Default is 640x480x8bpp.

Should the values be enclosed - as illustrated - in brackets? (I've been 
passing the value using the "vga=0x317".) The framebuffer.txt file describes 
it like this...

>To specify a video mode at bootup, use the following boot options:
>    video=<driver>:<xres>x<yres>[-<bpp>][@refresh]

-- 
Eric P.,
Sunnyvale, CA


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
