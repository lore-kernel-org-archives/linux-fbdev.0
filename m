From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Wed, 10 Sep 2003 00:08:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909220824.GA21055@dreamland.darkstar.lan>
References: <1062960554.647.34.camel@gaston> <Pine.LNX.4.44.0309090054470.23354-100000@phoenix.infradead.org> <20030909175404.GA8039@dreamland.darkstar.lan> <1063131198.642.5.camel@gaston> <20030909192430.GA10981@dreamland.darkstar.lan> <1063136237.639.42.camel@gaston> <20030909204544.GA16724@dreamland.darkstar.lan> <1063141651.20501.50.camel@gaston> <20030909215229.GA19113@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wqga-0000Vh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 15:10:08 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wqgZ-0005QD-6Z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 15:10:07 -0700
Content-Disposition: inline
In-Reply-To: <20030909215229.GA19113@dreamland.darkstar.lan>
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
Cc: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Tue, Sep 09, 2003 at 11:52:29PM +0200, Kronos ha scritto: 
> struct fb_info *framebuffer_alloc(size_t size, struct device *dev) {
> 
>         if (size)
>                 info->par = ret + align;

Ops, this should be:
                info->par = ret + sizeof(struct fb_info) + align;

> 
>         return info;
> }

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Recursion n.:
        See Recursion.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
