From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: New radeonfb, mostly untested
Date: Mon, 08 Sep 2003 08:06:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063000866.659.9.camel@gaston>
References: <1062952639.655.6.camel@gaston>
	 <20030907230334.GA847@dreamland.darkstar.lan>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wFAt-0004L5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Sep 2003 23:06:55 -0700
Received: from smtp6.wanadoo.fr ([193.252.22.28] helo=mwinf0302.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wFAt-00054B-B0
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Sep 2003 23:06:55 -0700
In-Reply-To: <20030907230334.GA847@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> We are in  modedb.c:411, and info->fbops is NULL. info->fbops  is set in
> radeon_set_fbinfo, which is called after radeon_probe_screens. Moving
> radeon_set_fbinfo up should fix this:

Well... radeon_set_fbinfo relies on the screens beeing probed,
at least a couple of lines in it (the depth things) though they
may not be that important... (copied from the old driver, I may
just rip them off, I need to verify something relative to the
call to engine_init, I will probably rip it off too, it has to
be done in set_par only).

strangely enough it works here, I have to check what's wrong, I
suspect fb_find_mode isn't getting called for me but is for you
and it's trying to call check_var.

I'll fix that and send a new patch.

Ben.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
