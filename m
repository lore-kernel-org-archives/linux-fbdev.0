From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Tue, 15 Mar 2005 17:58:12 +1100
Message-ID: <1110869892.29138.86.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
	<1110774523.4003.511.camel@localhost>
	<1110784327.5787.288.camel@gaston>
	<1110817205.4004.527.camel@localhost>
	<1110837171.5863.16.camel@gaston> <1110838356.4003.548.camel@localhost>
	<1110839873.5673.41.camel@gaston>
	<9e473391050314213075ce0e47@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050314213075ce0e47@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Tue, 2005-03-15 at 00:30 -0500, Jon Smirl wrote:

> I agree that X has to be fixed to work cooperatively in this environment. 
> The alternative is to just leave X alone and make all of this work for XGL.
> The user would then choose which environment they want to run.
> 
> I'm leaning toward just leaving X alone and spending the resources on 
> making XGL work. After all XGL is a complete X replacement.
> 
> If you want to run existing X load an old fbdev driver.  We can keep both
> fbdev drivers in the kernel until it is clear if XGL is going mainstream.
> 
> One thing that does need to get fixed is mesa support for non-accelerated
> fbdev drivers but mesa can add all of the appropriate locking.

No, that isn't realistic. I want a smooth transition, and XGL won't be
the only player in the field anyway.
 
> > I think that Jon's dream of having totally independant heads that can
> > run 2 separate applications is a long way away and we have sort-of to
> > tie /dev/fb's together, though I don't know how to acheive that in
> > practice, unless we switch to a new API that can enforce it. The current
> > fbdev API cannot.
> 
> This is definitely something to works towards. There is a lot of
> application for this in schools, libraries, internet cafe, etc. There
> are several companies selling variations on this.
> 
> I don't expect an immediate solution but I want to make sure the
> redesign allows it to be built.

Yes. But I think that we should basically consider that anybody
openng /dev/fb also "locks out" write access to the other heads. That
is, the other head can be opened, but nothing done (mmap etc... on it)
unless both opener's have done the right ioctl telling us they know how
to do arbitration or that kind of thing. No ?

The fbdev API needs a mirror of the vga arbitration API. The later is
for use only by applications directly tapping vga legacy stuff. But
something using fbdev also need a lock/unlock API to enclose any
hardware access, at the very least. And when you think about it, what
you end up needing is ... the DRM lock.

So there might be some need to have fbdev be capable of taking the DRM
lock now. Unless that's done, I'll have to impose severe restrictions on
accesses to radeonfb's second head.

> Can we put in our own fault handler for the mmap, trap the directfb
> accesses and do the proper locking?

Gack. First that's "lazy locking" and something I'd like to avoid, but
if directfb API doesn't provide any other option ... then, it also
requires regulary un-mapping them back from the process using directfb
or the stuff will remain locked forever, and unmapping things behind a
process back isn't cool (some interesting locking issues). Overall
rather complicated and inefficient performance wise. And part of that
infrastructure already exist, somewhat, in the DRM ...

If a directFB client uses a /dev/fb, I think it should own both heads.
We simply can't do anything else. And we might even still need
arbitration because of the VGA stuff in case the card we are using has
legacy decoding enabled _anyway_. So ....


Ben.
