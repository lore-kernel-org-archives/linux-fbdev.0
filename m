From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 16:29:22 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916162922.C20141@flint.arm.linux.org.uk>
References: <20030915194329.GI16370@dreamland.darkstar.lan> <20030915224042.I10328@flint.arm.linux.org.uk> <20030915221742.GC27662@dreamland.darkstar.lan> <20030915235832.M10328@flint.arm.linux.org.uk> <20030916134009.GA1011@dreamland.darkstar.lan> <20030916144459.A20141@flint.arm.linux.org.uk> <20030916141713.GA1694@dreamland.darkstar.lan> <20030916155230.B20141@flint.arm.linux.org.uk> <20030916151701.GA3073@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zHlh-0007dv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 08:29:29 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19zHlf-0002FA-O1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 08:29:28 -0700
Content-Disposition: inline
In-Reply-To: <20030916151701.GA3073@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Tue, Sep 16, 2003 at 05:17:01PM +0200
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Tue, Sep 16, 2003 at 05:17:01PM +0200, Kronos wrote:
> Il Tue, Sep 16, 2003 at 03:52:30PM +0100, Russell King ha scritto: 
> > - framebuffer_alloc() creates the fb_info and the driver-private data
> >   in one object, as per your patch.
> 
> > - framebuffer_free() marks the structure available for freeing.
> 
> 
> So framebuffer_alloc calls class_device_get and framebuffer_free calls
> class_device_put. Ok, I'll rework the patch.

You could call class_device_del() instead of class_device_unregister()
from unregister_framebuffer(), and call class_device_put() in
framebuffer_free().

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
