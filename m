From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Fri, 25 Sep 2020 15:35:09 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200925153509.GA895804@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
In-Reply-To: <20200925132551.GF438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jiri Slaby <jirislaby@kernel.org>, linux-kernel-mentees@lists.linuxfoundation.org

On Fri, Sep 25, 2020 at 03:25:51PM +0200, Daniel Vetter wrote:
> I think the only way to make this work is that we have one place which
> takes in the userspace uapi struct, and then converts it once into a
> kernel_console_font. With all the error checking.

Ah, I didn't think of that! When trying to introduce
`kernel_console_font` I ended up using the uapi version and the kernel
version in parallel...

> Then all internal code deals in terms of kernel_console_font, with
> properly typed and named struct members and helper functions and
> everything. And we might need a gradual conversion for this, so that first
> we can convert over invidual console drivers, then subsystems, until at
> the end we've pushed the conversion from uapi array to kernel_console_font
> all the way to the ioctl entry points.
> 
> But that's indeed a huge pile of work, and fair warning: fbcon is
> semi-orphaned, so by doing this you'll pretty much volunteer for
> maintainership :-)
>
> But I'd be very happy to help get this done and throw some maintainership
> credentials at you in the proces ...

Sounds exciting, I will be glad to do this! I'm just a beginner, but I
will try to do what I can do.

Thank you,
Peilin Ye
