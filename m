From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: clipping
Date: Fri, 10 Jan 2003 11:45:21 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301101144090.9440-100000@vervain.sonytel.be>
References: <1042172016.933.136.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WwgT-0001e7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 02:46:42 -0800
In-Reply-To: <1042172016.933.136.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 10 Jan 2003, Antonino Daplas wrote:
> On Fri, 2003-01-10 at 05:24, James Simmons wrote:
> > > So perhaps, a function something like this:
> > > 
> > > void fb_clip(struct fb_fillrect *region, struct fb_fillrect *clip);
> > > 
> > > This should not be difficult to implement, and I'll code it if everyone
> > > agrees.
> >  
> > I thought about this. Originally I did have this function but removed it.
> > WHat do you think Geert?
> > 
> > > The other option (which I don't like) is just to check the passed
> > > fb_var_screeninfo in the put_var ioctl against the current console
> > > window size.  But this is not foolproof as we will not be sure of the
> > > resulting window size _after_ the fb_set_var() call.
> > 
> > Yuck!!! The other way is better.
> > 
> 
> Yes, I thought so too :-).
> 
> I think one scenario why we need clipping is changing bits_per_pixel,
> ie, changing from 8->16 will drop your vyres by half and it's difficult
> to determine this unless you do another check before the set_par(), as
> Geert mentioned.  Worse still, there is little if no valid memory past
> vyres but the console thinks there is.  That's where you will get a
> segfault.
> 
> Whereas explicitly doing fbset -vyres 768 will not cause a segfault,
> because you still have valid framebuffer memory past y=768.

That depends. On unified memory architectures or if the graphics memory is
shared by two heads, you may still corrupt someone's memory.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
