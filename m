From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 25 Sep 2020 14:39:37 +0000
Subject: Re: [PATCH 0/3] fbdev: stop using compat_alloc_user_space
Message-Id: <20200925143937.GA1929717@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200918100812.1447443-1-arnd@arndb.de>
 <20200918124808.GD438822@phenom.ffwll.local>
 <20200924205436.GP1223313@ravnborg.org>
 <CAK8P3a1P=oY9XexnXjk6F_wcbm8OnZ=70rXPTRED+Z6LjU9_QA@mail.gmail.com>
In-Reply-To: <CAK8P3a1P=oY9XexnXjk6F_wcbm8OnZ=70rXPTRED+Z6LjU9_QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>, "David S . Miller" <davem@davemloft.net>

On Fri, Sep 25, 2020 at 01:31:51PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 24, 2020 at 10:54 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Daniel/Arnd.
> >
> > On Fri, Sep 18, 2020 at 02:48:08PM +0200, Daniel Vetter wrote:
> > > On Fri, Sep 18, 2020 at 12:08:10PM +0200, Arnd Bergmann wrote:
> > > > The fbdev code uses compat_alloc_user_space in a few of its
> > > > compat_ioctl handlers, which tends to be a bit more complicated
> > > > and error-prone than calling the underlying handlers directly,
> > > > so I would like to remove it completely.
> > > >
> > > > This modifies two such functions in fbdev, and removes another
> > > > one that is completely unused.
> > > >
> > > >     Arnd
> > > >
> > > > Arnd Bergmann (3):
> > > >   fbdev: simplify fb_getput_cmap()
> > > >   fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
> > > >   fbdev: sbuslib: remove compat_alloc_user_space usage
> > >
> > > Looks all good, but we're also kinda looking for a new volunteer for
> > > handling fbdev patches ... drm-misc commit rights, still not interested?
> >
> > Hi Daniel - I read the above as an a-b. And Arnd did not take the bait
> > it seems.
> 
> Ah right, I meant to reply but then forgot about it.
> 
> I don't really want commit access, thanks for the offer.
> 
> > Hi Arnd. checkpatch complained about some whitespace, which I fixed
> > while applying.
> > Will push to drm-misc-next tomorrow unless I hear anything else.
> 
> Great, thanks!
Pushed now.

	Sam
