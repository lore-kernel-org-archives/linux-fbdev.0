From: James Simmons <jsimmons@infradead.org>
Subject: Re: clipping
Date: Tue, 7 Jan 2003 22:13:02 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072211310.17129-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301072207170.21057-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W1yc-0007BI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 14:13:38 -0800
In-Reply-To: <Pine.GSO.4.21.0301072207170.21057-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > > BTW, do we really need clipping in fb_ops.fb_{fillrect,copyarea,imageblit}()?
> > Personally, I don't think we need clipping.  I tried removing it before
> > (circa linux-2.5.30+), but the console segfaults whenever I decrease
> > var->yres_virtual.  I haven't tried this again with the newest
> > framebuffer framework though.
> 
> Any definitive answer on this?
> 
> What happens if you resize the VT to such a large size that columns*fontwidth >
> xres_virtual or rows*fontheight > yres_virtual? I guess clipping prevents a
> crash there?

Correct. Actually fbcon_resize checks to make sure the user doesn't do 
something stupid like this. So we might not needed. Hm.




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
