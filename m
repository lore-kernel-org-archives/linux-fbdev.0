From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 10 Nov 2017 16:53:42 +0000
Subject: Re: [RFC 00/14] Kernel based bootsplash
Message-Id: <s5hshdmaxd5.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
        <20171109115655.GA18436@atrey.karlin.mff.cuni.cz>
        <1510230976.2975.10.camel@suse.com>
        <20171109184523.GA32246@amd>
In-Reply-To: <20171109184523.GA32246@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Oliver Neukum <ONeukum@suse.com>, michal@markovi.net, b.zolnierkie@samsung.com, Michal Srb <MSrb@suse.com>, Stefan Dirsch <sndirsch@suse.com>, Max Staudt <mstaudt@suse.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 09 Nov 2017 19:45:23 +0100,
Pavel Machek wrote:
> 
> On Thu 2017-11-09 13:36:16, Oliver Neukum wrote:
> > Am Donnerstag, den 09.11.2017, 12:56 +0100 schrieb Pavel Machek:
> > > 
> > > "More reliable bootsplash" seems like an anti-goal. More reliable boot
> > > should be the goal...
> > > 
> > > You should be able to display nice splash screen from initrd...
> > > 
> > > We may want to fix the blinking cursor.
> > > 
> > > But if there are warnings, it is better to see the warnings then to
> > > hide them. If root filesystem can't be mounted (for example) it is
> > > good to know the reason, not to stare at the blank screen (or at boot splash).
> > 
> > Hi,
> > 
> > well you are not required to use a boot splash. Though I note that
> > many people want a boot splash. However, if you use a boot splash
> > at all, you will not see the messages, so how does it matter to you
> > if it comes out of the initrd?
> 
> Of course I'm not required to use it.
> 
> OTOH you don't need to patch kernel to get nice bootsplash. If it
> means improving "quiet" option to hide the cursor, so be it.

We can achieve this even now by passing vt.global_cursor_default=0
boot option.  But you'd need to reset the cursor explicitly before
starting the login prompt, though.

Also, the whole kernel messages can be suppressed by passing
console_loglevel=1 option, too.

So far, so good.  However...

> You
> should be able to do the rest, already.

... the devils are in details.  We have lots of issues with the most
commonly used bootsplash, plymouth, which should have been "nice".

The most notable one is that it blocks the switching to KMS driver.
It's basically a long-standing kernel bug, and you can see it easily
on your machine, even on VM.

- Boot with VESA or EFI FB.  DRM driver isn't loaded yet.
- Run some app (splash) to open /dev/fb0 and keep it opened.
- Load the native DRM driver (i915, cirrus and whatever) now.
  At this point, your screen freezes.  It's because the KMS driver
  load fails due to the process opening /dev/fb* of the old FB to be
  kicked out.

For avoiding such a situation, many distros disable the bootsplash on
FB but only run on DRM mode (so the splash on the first FB is
skipped).  But it means you'll have no splash for non-KMS systems.

Also, when plymouth runs DRM mode, this itself conflicts with the
invocation of X, which requires the DRM exclusively again.  Such a DRM
device management mechanism is missing in the whole picture.  Maybe we
need some helper along with logind or such...

Last but not least, plymouth grabs the whole input because it needs to
capture the input for turning on/off splash and for allowing the
decrypt password prompt; this often leads to a stall at boot when
plymouth doesn't react properly.


That said, quite lots of issues come from plymouth itself, but yet
some fundamental issues need to be addressed in the kernel, too.


Takashi
