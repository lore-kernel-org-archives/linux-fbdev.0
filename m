From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [announce 0/7] fbsplash - The Framebuffer Splash
Date: Wed, 9 Mar 2005 01:02:25 -0500
Message-ID: <9e473391050308220218cc26a3@mail.gmail.com>
References: <20050308015731.GA26249@spock.one.pl>
	 <200503091301.15832.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8uH5-0005Wh-Pw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 22:02:27 -0800
Received: from rproxy.gmail.com ([64.233.170.198])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8uH4-0003JA-Cf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 22:02:27 -0800
Received: by rproxy.gmail.com with SMTP id i8so113806rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 08 Mar 2005 22:02:25 -0800 (PST)
In-Reply-To: <200503091301.15832.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@hotpop.com>

On Wed, 9 Mar 2005 13:01:15 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> On Tuesday 08 March 2005 09:57, Michal Januszewski wrote:
> > Fbsplash - The Framebuffer Splash - is a feature that allows displaying
> > images in the background of consoles that use fbcon. The project is
> > partially descended from bootsplash.
> >
> > Unlike bootsplash, fbsplash has no in-kernel image decoder. Picture
> > decompression is handled by a userspace helper which provides raw image
> > data to the kernel. There is also no support for things like the silent
> > mode and progress bars, as these are best handled by userspace programs.
> >
> 
> If splash support is really, really, really wanted in the kernel, it's probably better
> to just add minimal Overlay support for the framebuffer.  If overlay is added, it
> won't be necessary to modify fbcon and the drivers, just core fb.
> 
> We can have 3 levels of support.  In it's most basic form, we have the display
> layer (what get's shown in your monitor) plus 2 buffers in system ram, the
> primary layer (where the console output is written) and the overlay, the
> static image in raw framebuffer format.  Then we replace the basic
> framebuffer operations (imageblit, fillrect and copyarea) with ones that
> will read the contents of both buffers, do basic raster ops (colorkey, alpha
> blend, etc) before writing to the actual display buffer.
> 
> The next level is both buffers are in video ram. This will need basic driver
> support, at least to subdivide the framebuffer memory to display, primary,
> and overlay.  We can use the drivers accelerated drawing functions to
> write to the primary layer, then use software to write the processed
> contents to the display layer.
> 
> Finally, we can enable full hardware video overlay.

Another idea would be to build a console is user space. Think of it as
a full screen xterm. A user space console has access to full hardware
acceleration using the DRM interface.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
