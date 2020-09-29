From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 29 Sep 2020 09:09:45 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200929090945.GH438822@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200925153509.GA895804@PWN>
In-Reply-To: <20200925153509.GA895804@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peilin Ye <yepeilin.cs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jiri Slaby <jirislaby@kernel.org>, linux-kernel-mentees@lists.linuxfoundation.org

On Fri, Sep 25, 2020 at 11:35:09AM -0400, Peilin Ye wrote:
> On Fri, Sep 25, 2020 at 03:25:51PM +0200, Daniel Vetter wrote:
> > I think the only way to make this work is that we have one place which
> > takes in the userspace uapi struct, and then converts it once into a
> > kernel_console_font. With all the error checking.
> 
> Ah, I didn't think of that! When trying to introduce
> `kernel_console_font` I ended up using the uapi version and the kernel
> version in parallel...
> 
> > Then all internal code deals in terms of kernel_console_font, with
> > properly typed and named struct members and helper functions and
> > everything. And we might need a gradual conversion for this, so that first
> > we can convert over invidual console drivers, then subsystems, until at
> > the end we've pushed the conversion from uapi array to kernel_console_font
> > all the way to the ioctl entry points.
> > 
> > But that's indeed a huge pile of work, and fair warning: fbcon is
> > semi-orphaned, so by doing this you'll pretty much volunteer for
> > maintainership :-)
> >
> > But I'd be very happy to help get this done and throw some maintainership
> > credentials at you in the proces ...
> 
> Sounds exciting, I will be glad to do this! I'm just a beginner, but I
> will try to do what I can do.

If you want to follow along a bit I think would be good to subscribe to
the dri-devel mailing list. At least for all the fbcon/fbdev/gpu stuff.

I don't think there's a dedicated list for vt/console stuff, aside from
Greg's inbox :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
