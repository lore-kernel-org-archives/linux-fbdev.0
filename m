From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: new radeon code and
	acquire/release_console_sem()
Date: Sun, 14 Sep 2003 02:29:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063499368.9720.40.camel@gaston>
References: <20030914002359.33381.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yKmM-0003Jm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 17:30:14 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19yKmL-0005mV-GH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Sep 2003 17:30:13 -0700
In-Reply-To: <20030914002359.33381.qmail@web14910.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Kronos <kronos@kronoz.cjb.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-09-14 at 02:23, Jon Smirl wrote:
> I don't run fb console on my system so I don't have acquire_console_sem() and
> release_console_sem(). Shouldn't these have an #ifdef CONFIG_FRAMEBUFFER_CONSOLE?

Those are in kernel/printk.c, you should probably have them.

We need some locking for the fbcon itself and so far, this is the best we
have at hand though it's still broken as the various ioctls should take
it as well.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
