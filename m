From: Jon Smirl <jonsmirl@yahoo.com>
Subject: fb and multiple adapters
Date: Fri, 27 Dec 2002 16:39:19 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021228003919.27894.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14910.mail.yahoo.com ([216.136.225.62])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18S50Z-0003wG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Dec 2002 16:39:19 -0800
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
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

I'm looking into running framebuffers on multiple
video adapters. My current setup has an ATI AGP Radeon
9000 as the primary adapter and a ATI PCI Rage128 as
the secondary. 

The Rage128 driver won't load in this config. So the
first thing I did was to add my board's id to it, PD.
Now I'm at the point where the expansion ROM isn't
enabled and the adapter isn't initialized.

Should I add code to aty128fb to enable the ROM and
execute the initialization code (like X does)? What
the overall policy towards framebuffers initializing
secondary adapters? 

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
