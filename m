From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] cyber2000fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 23:58:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915235832.M10328@flint.arm.linux.org.uk>
References: <20030915194329.GI16370@dreamland.darkstar.lan> <20030915224042.I10328@flint.arm.linux.org.uk> <20030915221742.GC27662@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z2Ir-0002z2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 15:58:41 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19z2Iq-0000Ub-9n
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 15:58:40 -0700
Content-Disposition: inline
In-Reply-To: <20030915221742.GC27662@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Tue, Sep 16, 2003 at 12:17:42AM +0200
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

On Tue, Sep 16, 2003 at 12:17:42AM +0200, Kronos wrote:
> Il Mon, Sep 15, 2003 at 10:40:42PM +0100, Russell King ha scritto: 
> > There is another reason why the above is fundamentally flawed - who says
> > that "release_cfb_info" will still be in module space by the time you
> > need to call it?
> > 
> > Eg, you unload your framebuffer driver module immediately after the device
> > has gone away, but someone is keeping the sysfs files associated with
> > the fb_info open.
> 
> I'm quite sure that this can't happen. If someone is keeping a sysfs
> file open module use count won't be zero. Right?

Where are you handling the module use count of the framebuffer driver?

I'm also confused why you want to keep the device IO regions around
until all sysfs files have been closed.  I hope you're not thinking
of touching the hardware after you've returned from the drivers
->remove method?

Is there somewhere I can view the core changes?

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
