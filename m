From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] acornfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 23:09:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915210924.GJ23294@dreamland.darkstar.lan>
References: <20030915193450.GC16370@dreamland.darkstar.lan> <20030915220511.F10328@flint.arm.linux.org.uk>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0c1-0002ua-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:10:21 -0700
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0c0-0002JY-OV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:10:20 -0700
Content-Disposition: inline
In-Reply-To: <20030915220511.F10328@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Il Mon, Sep 15, 2003 at 10:05:11PM +0100, Russell King ha scritto: 
> > this patch convert driver/video/acorn.c to framebuffer_alloc:
> 
> This is buggy in places - it looks like you used 'sed' to make many
> of these changes, and missed ones which crop up twice on one line.

No, it was done by hand. I'll recheck.

Thank you.
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Mi piace avere amici rispettabili;
Mi piace essere il peggiore della compagnia.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
