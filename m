From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: 2.5 fbdev & driver initial mode
Date: 08 Jan 2003 22:52:50 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042062770.551.9.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.33.0301081042070.9598-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-2-242.abo.wanadoo.fr ([193.253.217.242] helo=zion.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WOJR-0001VR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 14:04:37 -0800
In-Reply-To: <Pine.LNX.4.33.0301081042070.9598-100000@maxwell.earthlink.net>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James !

How is a driver supposed to set the default mode on init lately ?

Looking at rivafb, it fills info->var from fb_find_mode with the mode
option if any, but then does nothing with it (and does nothing if
no mode option is passed).

On radeonfb, I fill a var  with the default mode obtained
from EDID or the option if any. Then, I basically do

	info->var = var;
	var.activate = FB_ACTIVATE_NOW;
	fb_set_var(&var, info);

before calling register_framebuffer.

What is the right way to do ?

Ben.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
