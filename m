From: tmika@t-online.de (Thorsten Mika)
Subject: contrast on a fixed frequency monitor
Date: Fri, 12 Jul 2002 22:45:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020712224542.6ca24472.tmika@t-online.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17T7IY-0000Om-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Jul 2002 13:45:54 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

hi list,

i am a newbie to linux-fbdev and got a problem:

i am trying to use the fbdev stuff from 2.4.18 on a ati rage lt (mach 64) chipset to make it sync the textmode on my hitachi hm4419-d fixed frequency monitor. everything runs fine so far, i can load the atyfb module and make fbset switch the video settings to a readable image, buit obviously the contrast and brightness of the image are very high. switching over to the restarted (non-xvfb-)x-server reveals an image that is a bit scrambled in some parts (like being doubled in parts, but not completely messed up) which is also equipped with far too much contrast. turning down the contrast on the monitor makes things a bit better, but it still is very high making me fear for my monitor's health :-)

any hint?

thx in advance,

  thorsten
-- 
Thorsten Mika                                mailto:tmika@t-online.de
Hamm / Germany                                            TM5173-RIPE


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Gadgets, caffeine, t-shirts, fun stuff.
http://thinkgeek.com/sf
