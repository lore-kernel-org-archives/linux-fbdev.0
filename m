From: Antonino Daplas <adaplas@pol.net>
Subject: Re: clipping
Date: 10 Jan 2003 18:27:27 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042172016.933.136.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301092122450.5660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WwYA-0008Ru-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 02:38:06 -0800
In-Reply-To: <Pine.LNX.4.44.0301092122450.5660-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-01-10 at 05:24, James Simmons wrote:
> 
> > So perhaps, a function something like this:
> > 
> > void fb_clip(struct fb_fillrect *region, struct fb_fillrect *clip);
> > 
> > This should not be difficult to implement, and I'll code it if everyone
> > agrees.
>  
> I thought about this. Originally I did have this function but removed it.
> WHat do you think Geert?
> 
> > The other option (which I don't like) is just to check the passed
> > fb_var_screeninfo in the put_var ioctl against the current console
> > window size.  But this is not foolproof as we will not be sure of the
> > resulting window size _after_ the fb_set_var() call.
> 
> Yuck!!! The other way is better.
> 

Yes, I thought so too :-).

I think one scenario why we need clipping is changing bits_per_pixel,
ie, changing from 8->16 will drop your vyres by half and it's difficult
to determine this unless you do another check before the set_par(), as
Geert mentioned.  Worse still, there is little if no valid memory past
vyres but the console thinks there is.  That's where you will get a
segfault.

Whereas explicitly doing fbset -vyres 768 will not cause a segfault,
because you still have valid framebuffer memory past y=768.

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
