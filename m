From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev
 changes
Date: Wed, 17 Sep 2003 20:37:29 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309172035100.1730-100000@phoenix.infradead.org>
References: <20030916155230.B20141@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zi7N-0000Sb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 12:37:38 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19zi7N-0007as-7g
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Sep 2003 12:37:37 -0700
In-Reply-To: <20030916155230.B20141@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Kronos <kronos@kronoz.cjb.net>, linux-fbdev-devel@lists.sourceforge.net


> - fbmem.c is responsible for managing the lifetime of the fb_info structure,
>   and the lifetime of the driver-private data is equal to the lifetime
>   of the fb_info structure.

This is not always the case. For dual headed graphics cards you can have 
two struct fb_info and one driver-private data. If the fbdev driver
releases one framebuffer you still have one framebuffer left that is using 
the driver-private data.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
