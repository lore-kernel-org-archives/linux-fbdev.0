From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: When is the Linux Logo ( penguin ) drawn on startup in 2.4.20 ?
Date: Tue, 8 Jul 2003 16:45:30 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030708234530.9697.qmail@web11905.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web11905.mail.yahoo.com ([216.136.172.189])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19a29K-0004HQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 08 Jul 2003 16:45:30 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

Dear List,

I am trying to debug a Xpert98 PCI graphics card on a
mips system with a 2.4.20 kernel. I am using vga
emulation to read the gfx card's ROM and initialize
the card. I know the card is being somewhat
initialized because after the vga emulation has
completed, the vga monitor shows lots of colored
squares / random colors etc. I have single stepped
into the code and noticed that within aty_init() the
call to fb_memset() clears the screen to black. But
after that nothing else happens - ie nothing else is
output to the screen.

Single stepping is proving to be very slow, and I
don't really know the framebuffer code, so I would be
very grateful if someone on the list could suggest
which routines I need to set breakpoints in and / or
what may be the cause of my non-existent penguin.

Please Note, I have successfully used a cirrus logic
PCI gfx card in the same system and it outputs the
penguin to the vga monitor, so i know the system is
capable of it.

TIA

Wayne

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
