From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2020 11:52:11 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200930115211.GC1603625@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
 <CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com>
 <20200930071151.GA1152145@PWN>
 <20200930095317.GX438822@phenom.ffwll.local>
 <20200930105553.GA1154238@PWN>
 <CAKMK7uFzWZgs4rvqSXqn_ifr8utG_rNw54+y6CWjdV=Epak-iQ@mail.gmail.com>
In-Reply-To: <CAKMK7uFzWZgs4rvqSXqn_ifr8utG_rNw54+y6CWjdV=Epak-iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jirislaby@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel-mentees@lists.linuxfoundation.org, Peilin Ye <yepeilin.cs@gmail.com>

On Wed, Sep 30, 2020 at 01:25:14PM +0200, Daniel Vetter wrote:
> On Wed, Sep 30, 2020 at 12:56 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 11:53:17AM +0200, Daniel Vetter wrote:
> > > On Wed, Sep 30, 2020 at 03:11:51AM -0400, Peilin Ye wrote:
> > > > On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> > > > > On Tue, Sep 29, 2020 at 2:34 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > > > > > Ah, and speaking of built-in fonts, see fbcon_startup():
> > > > > >
> > > > > >         /* Setup default font */
> > > > > >                 [...]
> > > > > >                 vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
> > > > > >                             ^^^^^^^^^^^^^^^
> > > > > >
> > > > > > This is because find_font() and get_default_font() return a `struct
> > > > > > font_desc *`, but `struct font_desc` doesn't contain `charcount`. I
> > > > > > think we also need to add a `charcount` field to `struct font_desc`.
> > > > >
> > > > > Hm yeah ... I guess maybe struct font_desc should be the starting
> > > > > point for the kernel internal font structure. It's at least there
> > > > > already ...
> > > >
> > > > I see, that will also make handling built-in fonts much easier!
> > >
> > > I think the only downside with starting with font_desc as the internal
> > > font represenation is that there's a few fields we don't need/have for
> > > userspace fonts (like the id/name stuff). So any helpers to e.g. print out
> > > font information need to make sure they don't trip over that
> > >
> > > But otherwise I don't see a problem with this, I think.
> >
> > Yes, and built-in fonts don't use refcount. Or maybe we can let
> > find_font() and get_default_font() kmalloc() a copy of built-in font
> > data, then keep track of refcount for both user and built-in fonts, but
> > that will waste a few K of memory for each built-in font we use...
> 
> A possible trick for this would be to make sure built-in fonts start
> out with a refcount of 1. So never get freed. Plus maybe a check that
> if the name is set, then it's a built-in font and if we ever underflow
> the refcount we just WARN, but don't free anything.
> 
> Another trick would be kern_font_get/put wrappers (we'd want those
> anyway if the userspace fonts are refcounted) and if kern_font->name
> != NULL (i.e. built-in font with name) then we simply don't call
> kref_get/put.

Ick, don't do that, the first trick of having them start out with an
increased reference count is the best way here.  Makes the code simpler
and no special cases for the tear-down path.

thanks,

greg k-h
