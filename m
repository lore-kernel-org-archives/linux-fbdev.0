From: James Simmons <jsimmons@infradead.org>
Subject: Re: framebuffer_{alloc,release}
Date: Mon, 22 Sep 2003 22:24:04 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309222223310.6431-100000@phoenix.infradead.org>
References: <20030918160142.GA2280@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1YAD-0005HI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 14:24:09 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1YAB-0000ve-0q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 14:24:07 -0700
In-Reply-To: <20030918160142.GA2280@dreamland.darkstar.lan>
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
Cc: linux-fbdev-devel@lists.sourceforge.net


> framebuffer_alloc doesn't assume anything. It allocates fb_info->par iff
> it's  told to. For  dual  head you  can allocate  par  yourself (and  do
> whatever you want with it) or do something like this (matrox fb is doing
> something similar):
> 
> if (seconday) {
>         fb_info = framebuffer_alloc(0, NULL);
>         fb_info->par = primary->par;
> } else
>         fb_info = framebuffer_alloc(sizeof(struct foo_par), NULL);
> 
> release_fb_info  won't  touch  fb_info->par  unless it  was  created  by
> framebuffer_alloc. If  secondary driver  can work  even when  primary is
> unloaded  then you  can  use  class_device_get (or  a  wrapper) to  keep
> primary fb data around:
> 
> if (secondary) {
>         if (!primary_fb_info)
>                 secondary_fb_info = framebuffer_alloc(sizeof(struct foo_par), NULL);
>         else {
>                 if (!class_device_get(&primary_fb_info->class_dev))
>                         /* primary is going away */
>                 else {
>                         secondary_fb_info = framebuffer_alloc(0, NULL);
>                         secondary_fb_info->par = primary_fb_info->par;
>                 }
>         }
> }

This is acceptable. I applied your changes.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
