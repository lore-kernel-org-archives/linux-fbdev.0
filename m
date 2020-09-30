From: Peilin Ye <yepeilin.cs@gmail.com>
Date: Wed, 30 Sep 2020 10:55:53 +0000
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
Message-Id: <20200930105553.GA1154238@PWN>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
 <CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com>
 <20200930071151.GA1152145@PWN>
 <20200930095317.GX438822@phenom.ffwll.local>
In-Reply-To: <20200930095317.GX438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Jiri Slaby <jirislaby@kernel.org>, linux-kernel-mentees@lists.linuxfoundation.org

On Wed, Sep 30, 2020 at 11:53:17AM +0200, Daniel Vetter wrote:
> On Wed, Sep 30, 2020 at 03:11:51AM -0400, Peilin Ye wrote:
> > On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> > > On Tue, Sep 29, 2020 at 2:34 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > > > Ah, and speaking of built-in fonts, see fbcon_startup():
> > > >
> > > >         /* Setup default font */
> > > >                 [...]
> > > >                 vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
> > > >                             ^^^^^^^^^^^^^^^
> > > >
> > > > This is because find_font() and get_default_font() return a `struct
> > > > font_desc *`, but `struct font_desc` doesn't contain `charcount`. I
> > > > think we also need to add a `charcount` field to `struct font_desc`.
> > > 
> > > Hm yeah ... I guess maybe struct font_desc should be the starting
> > > point for the kernel internal font structure. It's at least there
> > > already ...
> > 
> > I see, that will also make handling built-in fonts much easier!
> 
> I think the only downside with starting with font_desc as the internal
> font represenation is that there's a few fields we don't need/have for
> userspace fonts (like the id/name stuff). So any helpers to e.g. print out
> font information need to make sure they don't trip over that
> 
> But otherwise I don't see a problem with this, I think.

Yes, and built-in fonts don't use refcount. Or maybe we can let
find_font() and get_default_font() kmalloc() a copy of built-in font
data, then keep track of refcount for both user and built-in fonts, but
that will waste a few K of memory for each built-in font we use...

> > > I think for vc_date->vc_font we might need a multi-step approach:
> > > - first add a new helper function which sets the font for a vc using
> > > an uapi console_font struct (and probably hard-coded assumes cnt =
> > > 256.
> > 
> > But user fonts may have a charcount different to 256... But yes I'll try
> > to figure out how.
> 
> Hm yeah, maybe we need a helper to give us the charcount then, which by
> default is using the magic negative offset.

Ah, I see! :)

> Then once we've converted everything over to explicitly passing charcount
> around, we can switch that helper. So something like
> 
> int kern_font_charcount(struct kern_font *font);
> 
> Feel free to bikeshed the struct name however you see fit :-)

I think both `kern_font` and `font_desc` makes sense, naming is so
hard...

> > > For first steps I'd start with demidlayering some of the internal
> > > users of uapi structs, like the console_font_op really shouldn't be
> > > used anywhere in any function, except in the ioctl handler that
> > > converts it into the right function call. You'll probably discover a
> > > few other places like this on the go.
> > 
> > Sure, I'll start from this, then cleaning up these dummy functions, then
> > `vc_data`. Thank you for the insights!
> 
> Please don't take this rough plan as fixed, it's just where I'd start from
> browsing the code and your analysis a bit. We'll probably have to adapt as
> we go and more nasty things turn up ...

Sure, I'll first give it a try and see. Thank you!

Peilin Ye
