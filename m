From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] fix endian problem in
	color_imageblit
Date: 21 Dec 2002 11:45:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1040442194.1294.9.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0212201932150.6471-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37] helo=vhost.compass.com.ph)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18PakY-0006QA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Dec 2002 19:56:30 -0800
In-Reply-To: <Pine.LNX.4.44.0212201932150.6471-100000@phoenix.infradead.org>
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
Cc: Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-12-21 at 03:54, James Simmons wrote:
> 
> > Nice catch :-)  We also need a similar fix for slow_imageblit(), so
> > James can you apply the attached patch also:
> 
> Applied.
> 
> > Also, I noticed that some drivers load the pseudo_palette with entries
> > whose length matches the length of the pixel.  The cfb_* functions
> > always assume that each pseudo_palette entry is an "unsigned long", so
> > bpp16 will segfault, and so will bpp24/32 for 64-bit machines.
> 
> I just noticed that as well. Russell King pointed to it too. I fixed
> the unsigned long problem in color_imageblit. All the pseudo_palette
> in cfb_* are assumed u32. Is this safe for 16bpp or 8 bpp modes? I will

The pseudopalette will only matter for truecolor and directcolor as the
rest of the visuals bypasses the pseudopalette.  Typecasting to
"unsigned long" rather than "u32" is also safer (even for bpp16) since
in 64-bit machines, the drawing functions use fb_writeq instead of
fb_writel.  So, all drivers using the cfb_* functions should change from
"u32" to "unsigned long" _whatever_ the bit depth when loading the
pseudopalette.

Of course, drivers with their own drawing functions can use whatever
they want.

Tony 

PS:  cfb_fillrect is still limited to u32 though which can hopefully be
fixed in the future.




-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
