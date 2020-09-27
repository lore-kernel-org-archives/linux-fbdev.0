From: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 27 Sep 2020 12:06:58 +0000
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
Message-Id: <20200927120658.GA107433@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
In-Reply-To: <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>, linux-fbdev@vger.kernel.org, George Kennedy <george.kennedy@oracle.com>, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, deller@gmx.de, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Linus Torvalds <torvalds@linux-foundation.org>, jirislaby@kernel.org, Peilin Ye <yepeilin.cs@gmail.com>

On Sun, Sep 27, 2020 at 08:46:30PM +0900, Tetsuo Handa wrote:
> syzbot is reporting UAF/OOB read at bit_putcs()/soft_cursor() [1][2], for
> vt_resizex() from ioctl(VT_RESIZEX) allows setting font height larger than
> actual font height calculated by con_font_set() from ioctl(PIO_FONT).
> Since fbcon_set_font() from con_font_set() allocates minimal amount of
> memory based on actual font height calculated by con_font_set(),
> use of vt_resizex() can cause UAF/OOB read for font data.
> 
> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
> 
>   #define VT_RESIZE   0x5609 /* set kernel's idea of screensize */
>   #define VT_RESIZEX  0x560A /* set kernel's idea of screensize + more */
> 
> So far we are not aware of syzbot reports caused by setting non-zero value
> to v_vlin parameter. But given that it is possible that nobody is using
> VT_RESIZEX, we can try removing support for v_clin and v_vlin parameters.

Debian code search doesn't show any users, and that's usually a good
indication of what userspace ioctls for old things like this, are being
used for.

So this makes sense to me, I'll queue it up, thanks!

greg k-h
