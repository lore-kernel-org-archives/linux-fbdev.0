From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Fri, 12 Sep 2003 18:44:30 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121844120.5017-100000@phoenix.infradead.org>
References: <20030909220824.GA21055@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xryG-0002Ls-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 10:44:36 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xryF-00040y-B9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 10:44:35 -0700
In-Reply-To: <20030909220824.GA21055@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Yucky!!! 

On Wed, 10 Sep 2003, Kronos wrote:

> Il Tue, Sep 09, 2003 at 11:52:29PM +0200, Kronos ha scritto: 
> > struct fb_info *framebuffer_alloc(size_t size, struct device *dev) {
> > 
> >         if (size)
> >                 info->par = ret + align;
> 
> Ops, this should be:
>                 info->par = ret + sizeof(struct fb_info) + align;
> 
> > 
> >         return info;
> > }
> 
> Luca
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
