From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Wed, 30 Sep 2020 12:58:55 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200930125855.GA1155358@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
 <CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com>
 <20200930071151.GA1152145@PWN>
 <20200930095317.GX438822@phenom.ffwll.local>
 <20200930105553.GA1154238@PWN>
 <CAKMK7uFzWZgs4rvqSXqn_ifr8utG_rNw54+y6CWjdV=Epak-iQ@mail.gmail.com>
 <20200930115211.GC1603625@kroah.com>
In-Reply-To: <20200930115211.GC1603625@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jirislaby@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel-mentees@lists.linuxfoundation.org

On Wed, Sep 30, 2020 at 01:52:11PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2020 at 01:25:14PM +0200, Daniel Vetter wrote:
> > On Wed, Sep 30, 2020 at 12:56 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > > Yes, and built-in fonts don't use refcount. Or maybe we can let
> > > find_font() and get_default_font() kmalloc() a copy of built-in font
> > > data, then keep track of refcount for both user and built-in fonts, but
> > > that will waste a few K of memory for each built-in font we use...
> > 
> > A possible trick for this would be to make sure built-in fonts start
> > out with a refcount of 1. So never get freed. Plus maybe a check that
> > if the name is set, then it's a built-in font and if we ever underflow
> > the refcount we just WARN, but don't free anything.
> > 
> > Another trick would be kern_font_get/put wrappers (we'd want those
> > anyway if the userspace fonts are refcounted) and if kern_font->name
> > != NULL (i.e. built-in font with name) then we simply don't call
> > kref_get/put.
> 
> Ick, don't do that, the first trick of having them start out with an
> increased reference count is the best way here.  Makes the code simpler
> and no special cases for the tear-down path.

I see, I'll just let them start out with 1, and only check `->name !NULL` in kern_font_put(). Thank you!

Peilin Ye
