From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: new radeon code and acquire/release_console_sem()
Date: Sat, 13 Sep 2003 17:34:06 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030914003406.4373.qmail@web14903.mail.yahoo.com>
References: <1063499368.9720.40.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yKq9-00047G-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 17:34:09 -0700
Received: from web14903.mail.yahoo.com ([216.136.225.55])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yKq6-0000j5-HY
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Sep 2003 17:34:06 -0700
In-Reply-To: <1063499368.9720.40.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

I get this from insmod:
radeonfb: Unknown symbol release_console_sem

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sun, 2003-09-14 at 02:23, Jon Smirl wrote:
> > I don't run fb console on my system so I don't have acquire_console_sem()
> and
> > release_console_sem(). Shouldn't these have an #ifdef
> CONFIG_FRAMEBUFFER_CONSOLE?
> 
> Those are in kernel/printk.c, you should probably have them.
> 
> We need some locking for the fbcon itself and so far, this is the best we
> have at hand though it's still broken as the various ioctls should take
> it as well.
> 
> Ben.
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
