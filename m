From: Meelis Roos <mroos@linux.ee>
Subject: controlfb bug in 2.4
Date: Wed, 7 Aug 2002 20:34:00 +0300 (EEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.43.0208072026220.14939-100000@romulus.cs.ut.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from romulus.cs.ut.ee ([193.40.5.125])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cUhK-0001BH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 Aug 2002 10:34:15 -0700
Received: from localhost (mroos@localhost)
	by romulus.cs.ut.ee (8.11.6+Sun/8.11.6/romulus-1.10) with ESMTP id g77HY1p10060
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 7 Aug 2002 20:34:01 +0300 (EEST)
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
To: linux-fbdev-devel@lists.sourceforge.net

If this not the right place to ask, please redirect me to another list.

I use controlfb on a powermac. In 2.2.20 it works OK, modulo some
harware problem (half-broken bit in some video ram wire resulting in
vertical lines or color chanes depending on color depth). In 2.4 (tried
up to 2.4.19) there is a problem. Sometimes the display shifts right
half a screen after scrolling operations. The contents are of course
wrapped from left but it is more that 1 line so the last text line is
mostly shifted out of screen. The total vertical shift is about 1.5 text
lines in default mode (640x480). I first thought that it might be
because of the hardware problem but it works well with 2.2 kernels.

controlfb: VRAM Total = 2MB (0MB @ bank 1, 2MB @ bank 2)
controlfb: using video mode 6 and color mode 0.
Console: switching to colour frame buffer device 80x30
fb0: control display adapter

-- 
Meelis Roos (mroos@linux.ee)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
