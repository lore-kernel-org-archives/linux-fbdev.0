From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: clipping
Date: Thu, 9 Jan 2003 22:46:52 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301092242210.8148-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0301092122450.5660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WkX8-00005w-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 13:48:14 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 9 Jan 2003, James Simmons wrote:
> > So perhaps, a function something like this:
> > 
> > void fb_clip(struct fb_fillrect *region, struct fb_fillrect *clip);
> > 
> > This should not be difficult to implement, and I'll code it if everyone
> > agrees.
>  
> I thought about this. Originally I did have this function but removed it.
> WHat do you think Geert?

Yes, that's OK.

But I was most concerned about fb_ops.fb_imageblit(), since clipping impacts
fb_image.data as well. IIRC, all (most?) current clipping implementations
modify fb_image.{dx,dy,width,height} only, without updating fb_image.data.

> > The other option (which I don't like) is just to check the passed
> > fb_var_screeninfo in the put_var ioctl against the current console
> > window size.  But this is not foolproof as we will not be sure of the
> > resulting window size _after_ the fb_set_var() call.
> 
> Yuck!!! The other way is better.

Well, in between the calls to fb_ops.fb_check_var() and fb_ops.set_par() you
can still perform that check. But it's indeed ugly.

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
