From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 04 Jan 2016 07:08:14 +0000
Subject: Re: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
Message-Id: <20160104070814.GC8076@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <56828767.4050302@laposte.net>
 <CAH6sp9NrvapSMnPq5aagUFG2upf6-H9QJL1bkhMSscDL21Q-EQ@mail.gmail.com>
 <5682936E.2040904@laposte.net>
 <CAH6sp9OvJB+OPDPMWkEyNADcwO19N2=8U-5q49GrCmQTYObb_A@mail.gmail.com>
 <5682BA0B.9060001@laposte.net> <5683908C.5040001@ti.com>
 <5683A48C.80203@laposte.net> <5683B2A0.9090901@ti.com>
In-Reply-To: <5683B2A0.9090901@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Frias <sf84@laposte.net>, linux-fbdev@vger.kernel.org, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, mason <slash.tmp@free.fr>, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, laurent.pinchart@ideasonboard.com, Frans Klaver <fransklaver@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Wed, Dec 30, 2015 at 12:32:00PM +0200, Tomi Valkeinen wrote:
> 
> 
> On 30/12/15 11:31, Sebastian Frias wrote:
> > Hi,
> > 
> > On 12/30/2015 09:06 AM, Tomi Valkeinen wrote:
> >>
> >> Also note that I don't want new fbdev drivers into the mainline kernel.
> >> You should implement a DRM based driver instead.
> >>
> > 
> > Thanks, is there a porting guide to go from fbdev to DRM?
> 
> I don't think you should "port" the driver from fbdev to DRM, as the
> frameworks are just so different. You should implement the driver from
> scratch. Of course, the bits of code that actually touch the hardware
> can possibly be copied directly.
> 
> Kernel docs contain documentation about DRM, but I don't know if there's
> really a "how to write a DRM driver" style documentation. There's an
> active mailing list and irc channel, though.

Laurent Pinchart has a presentation which gives a good overview over drm
for display drivers:

https://www.youtube.com/watch?v=5uHMpjz68HE

DRM docs are at http://dri.freedesktop.org/docs/drm/ (this version is
using asciidoc for more pretties, but you can also build it locally with
make htmldocs and then look at it in
Documentation/DocBook/drm/index.html).

> > Does DRM provides a "fbdev" backward compatible API? Would that be
> > feasible?
> 
> DRM provides an fbdev "emulation". I think it's mainly aimed at
> providing fb console, but many fbdev applications should work fine on
> top of it.

Modeset side should be full featured out of the box (i.e. you can change
modes), drivers have the option to overallocate (to allow the fake page
flipping using set_par) and adding 2d accel is possible.

> > I did not find much about that.
> > 
> > Currently our stack is something like:
> > 
> >    Qt -> eglfs -> Mali -> fbdev -> mem -> output
> >                   (HW)                     (HW)
> > 
> > We don't control the eglfs/Mali (GPU) part.
> > From what I could see, Mali uses DRM with X11 which we do not need
> > (note: I'm not a Mali expert and just took a quick look at the code so I
> > may be wrong), which could be a problem.
> 
> I'm not familiar with Mali, so I have no idea.
> 
> > If "implement a DRM driver" is a lot of work, it would end up as a
> > business decision and probably would not happen.
> 
> True. It's, of course, up to you. If the fbdev driver works fine for you
> and provides all the features, and you're happy with it, and there's no
> requirement to get the driver to the mainline Linux, there's not much
> point in going for a DRM driver.
> 
> > Would you say there are good solid arguments to shake our current stack
> > (other than for dusting it off)?
> 
> Fbdev is the legacy framework, hopefully deprecated at some point, and
> DRM is the current display framework. So DRM has much more features, is
> actively developed, has a community that may help you with your issues, etc.
> 
> From purely technical point of view, it depends on the hardware in
> question. If the HW supports hardware overlays and multiple outputs, DRM
> supports those fully, whereas fbdev does not.
> 
> I'm not that familiar with the 3D side, but I think that can be
> implemented properly with DRM, whereas on fbdev supporting 3D is always
> more or less a hack.
> 
> > By the way, does DRM improves 2D acceleration support over fbdev?
> 
> I don't know enough about 2D acceleration to answer that.

We've tried in-kernel accel of 2d fbdev ops in i915 and realized it's too
much work and pretty pointless. But it's definitely possible to do that,
on top of the provided fbdev emulation (e.g. gma500 has some scrolling
accel tricks). Otherwise same as 3D really, using the split
kernel/userspace driver approach.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
