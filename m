From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 15:52:30 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916155230.B20141@flint.arm.linux.org.uk>
References: <20030915194329.GI16370@dreamland.darkstar.lan> <20030915224042.I10328@flint.arm.linux.org.uk> <20030915221742.GC27662@dreamland.darkstar.lan> <20030915235832.M10328@flint.arm.linux.org.uk> <20030916134009.GA1011@dreamland.darkstar.lan> <20030916144459.A20141@flint.arm.linux.org.uk> <20030916141713.GA1694@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zHC0-0003xC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 07:52:36 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19zHBz-00074N-Mz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 07:52:36 -0700
Content-Disposition: inline
In-Reply-To: <20030916141713.GA1694@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Tue, Sep 16, 2003 at 04:17:13PM +0200
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

On Tue, Sep 16, 2003 at 04:17:13PM +0200, Kronos wrote:
> Good point. I  was thinking  at files  created by  the driver  itself, I
> forgot about  dev attribute. I  can overwrite  .owner of  dev attribute,
> fbmem can't be built as module. Sounds good?

How about we do the job properly first time around?

- fbmem.c is responsible for managing the lifetime of the fb_info structure,
  and the lifetime of the driver-private data is equal to the lifetime
  of the fb_info structure.

- framebuffer_alloc() creates the fb_info and the driver-private data
  in one object, as per your patch.
- fb_add_class_device creates the class device, as per your patch
  (don't you think it'd be a good idea to return the error to the
  driver if class_device_register() fails?)
- fb_remove_class_device unregisters the class device, as per your
  patch.  This should not cause the fb_info structures to be released.
- framebuffer_free() marks the structure available for freeing.
- at some point later, once all references have done, release_fb_info()
  is called.  This releases the memory space allocated by
  framebuffer_alloc().  This callback should _not_ call the driver
  code.

So far, this fits fairly nicely.  Now on to the driver.

- bus-specific ->probe function
  driver calls framebuffer_alloc(), initialises whatever it needs to.
  Driver then calls register_fb() which in turn eventually calls
  fb_add_class_device().

- bus-specific ->remove function
  driver calls unregister_framebuffer() which eventually calls
  fb_remove_class_device().  driver releases its resources, shuts down
  hardware, and generally cleans up.  The very last step that it does
  is call framebuffer_free().

I believe there was an issue concerning EDID stuff with the above method.
If this requires data from the fb_info or another structure whose lifetime
is directly connected to fb_info, then there isn't a problem.  If it
requires something from the driver module, things get a little more
complicated, and there is a solution to this.  I don't see any instances
of this from looking at your fbdev-class_dev-all patch though.

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
