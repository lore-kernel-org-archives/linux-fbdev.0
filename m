From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Wed, 17 Sep 2003 20:41:20 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030917204120.F16045@flint.arm.linux.org.uk>
References: <20030916155230.B20141@flint.arm.linux.org.uk> <Pine.LNX.4.44.0309172035100.1730-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ziB6-0001dQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 12:41:28 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19ziB5-0001Bq-4v
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Sep 2003 12:41:27 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309172035100.1730-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Wed, Sep 17, 2003 at 08:37:29PM +0100
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
To: James Simmons <jsimmons@infradead.org>
Cc: Kronos <kronos@kronoz.cjb.net>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Sep 17, 2003 at 08:37:29PM +0100, James Simmons wrote:
> 
> > - fbmem.c is responsible for managing the lifetime of the fb_info structure,
> >   and the lifetime of the driver-private data is equal to the lifetime
> >   of the fb_info structure.
> 
> This is not always the case. For dual headed graphics cards you can have 
> two struct fb_info and one driver-private data. If the fbdev driver
> releases one framebuffer you still have one framebuffer left that is using 
> the driver-private data.

If this is not true, then how can anyone even be thinking about applying
the sysfs / driver model to the framebuffer drivers.

Unless this sort of data lifetime rules are clearly and unabiguously
defined, there is no way that a sysfs / driver model "port" will ever
come anywhere near being stable.

You can't get around these problems with module usage counting - module
usage refcounting is solely about code lifetimes.  This is all about data
lifetimes - when is the data created, when can it be safely destroyed,
etc.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
