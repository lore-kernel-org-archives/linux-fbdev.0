From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 17:17:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916151701.GA3073@dreamland.darkstar.lan>
References: <20030915194329.GI16370@dreamland.darkstar.lan> <20030915224042.I10328@flint.arm.linux.org.uk> <20030915221742.GC27662@dreamland.darkstar.lan> <20030915235832.M10328@flint.arm.linux.org.uk> <20030916134009.GA1011@dreamland.darkstar.lan> <20030916144459.A20141@flint.arm.linux.org.uk> <20030916141713.GA1694@dreamland.darkstar.lan> <20030916155230.B20141@flint.arm.linux.org.uk>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zHao-0006W0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 08:18:14 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zHao-0001Up-3a
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 08:18:14 -0700
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Il Tue, Sep 16, 2003 at 03:52:30PM +0100, Russell King ha scritto: 
> - framebuffer_alloc() creates the fb_info and the driver-private data
>   in one object, as per your patch.

> - framebuffer_free() marks the structure available for freeing.


So framebuffer_alloc calls class_device_get and framebuffer_free calls
class_device_put. Ok, I'll rework the patch.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Porc i' mond che cio' sott i piedi!
V. Catozzo


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
