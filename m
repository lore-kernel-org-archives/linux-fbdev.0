From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: fbcon scrolling madness + fbset
	corruption
Date: 05 Feb 2003 15:15:51 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1044428966.1170.25.camel@localhost.localdomain>
References: <20030119200340.A13758@flint.arm.linux.org.uk>
	<1043026112.988.4.camel@localhost.localdomain> 
	<20030202195744.C32007@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ggVj-0006vI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 23:31:51 -0800
In-Reply-To: <20030202195744.C32007@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Mon, 2003-02-03 at 03:57, Russell King wrote:
> On Mon, Jan 20, 2003 at 09:29:38AM +0800, Antonino Daplas wrote:
> > fb_pan_display() does not test for YWRAP.  Can you try this?
> 
> This doesn't appear to solve the ywrap problem - I still get
> places where the screen doesn't scroll.  I decided to write a
> small program to dump out the contents of fb_var_screeninfo, and
> where stuff goes horribly wrong:
> 
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+2352
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+2392
> 
> Up to the point where it goes wrong:
> 
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+528
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+568
> bash-2.04# ./tst
> Visible: 1280x1024	<--- this is the last line on the screen
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+608
> bash-2.04#
> 
> So it looks like something isn't limiting the yoffset in the generic
> console layer; an xoffset of 2392 when the maximum virtual Y is 1632
> is just nonsense.

It might be a problem with display.vrows not being updated during
fbcon_resize().  I think I sent James some patches before that added
that.

Can you try adding this at the end of fbcon_resize() in
drivers/video/fbcon.c?

p->vrows = info->var.yres_virtual/vc->vc_font.height;

Tony

PS:  I never encountered your problem, but I don't have hardware that's
capable of ywrap.






-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
