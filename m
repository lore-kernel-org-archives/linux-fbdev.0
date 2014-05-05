From: Olof Johansson <olof@lixom.net>
Date: Mon, 05 May 2014 05:06:24 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <20140505050624.GB16022@quad.lixom.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Wed, Apr 30, 2014 at 04:36:29PM +0400, Alexander Shiyan wrote:
> Wed, 30 Apr 2014 14:14:36 +0300 от Tomi Valkeinen <tomi.valkeinen@ti.com>:
> > On 24/04/14 19:35, Alexander Shiyan wrote:
> 
> Hello.
> 
> I'm a reorder quotes a bit for convenience.
> 
> > >> The right way to do it is, as I wrote above, by gradually changing the
> > >> old driver with a patch series. And my question is, why not do it that
> > >> way? Then it would be possible to review the patches one by one, seeing
> > >> what has changed.
> > > 
> > > "gradually changing"...
> > > I repeat that this is not an old modified driver, but written new.
> > 
> > Yes, I understand that. Again, my question is, why didn't you modify the
> > old driver? That's how things should normally be done. Instead, you made
> > a totally new one, making proper review against the old driver impossible.
> ...
> > Hmm what? So is the old driver totally broken, and cannot be used at the
> > moment? Or why you can't test on real hardware?
> 
> Firstly, the driver uses a fixed values for xres, yres, pixclock and specific
> variable ac_precale.
> Secondly, the driver uses a fixed value for the physical address of the buffer.
> Totally, it does not give me the ability to use the driver in the current state.
> Unlikely that this will look good if I make these two significant changes in
> a single patch...
> 
> At this time the driver has three user.
> Only one of them should theoretically work.
> clps711x-autcpu12 should not work in the absence of memblock_reserve().
> clps711x-p720t should not work due to physical address limitation as i
> noticed before. Board means to use SRAM instead of SDRAM.
> Only clps711x-edb7211 should work fine (in theory).
> Is this a good reason to replace the driver? I think yes.
> 
> > Note that I don't know anything about the fb hardware in question, nor
> > the driver. Maybe there's a valid reason to write a new driver from
> > scratch. But there very rarely is.
> > 
> > And "because I already wrote a new driver, and it's a waste of time for
> > me to throw away my work and patch the old one", is not a very good reason.
> 
> > > if you imagine a new file as a diff to the old, this can be clearly seen.
> > > 
> > > There is no reason to waste time on a series of changes since I
> > > can not even check these changes on real hardware, but only in the
> > > last stage when the driver will be the current version.
> 
> Summing up, I want to ask why the driver can not be reviewed as a
> new and not compared to the old?
> And yes, the time can be spent on more productive things to do than
> to create a series, leading eventually to the same result.
> As far as I know, guide to creating kernel patches allows such cases.

We've definitely had cases like that in the past. Sometimes it's easier
to first post a patch that removes the old driver, then one that submits
the new one as a new piece of work. That, of course, assumes that the
driver indeed was a rewrite and not just a bunch of incremental changes
all squashed into one.


-Olof
