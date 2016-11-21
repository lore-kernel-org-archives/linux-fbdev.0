From: "Ong, Hean Loong" <hean.loong.ong@intel.com>
Date: Mon, 21 Nov 2016 02:41:24 +0000
Subject: Re: [PATCHv0 1/1] fbdev: add Intel FPGA FRAME BUFFER driver
Message-Id: <1479696084.2822.4.camel@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479287278-5192-1-git-send-email-hean.loong.ong@intel.com>
         <20161118140903.q33zx7bk5nergq45@rob-hp-laptop>
         <20161118141547.465c431e@lxorguk.ukuu.org.uk>
         <CAL_JsqK2Emqub_JKiXYQUPzxRbws5w=SGUTyZx+qaEExV9V3_A@mail.gmail.com>
In-Reply-To: <CAL_JsqK2Emqub_JKiXYQUPzxRbws5w=SGUTyZx+qaEExV9V3_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2016-11-18 at 12:56 -0600, Rob Herring wrote:
> On Fri, Nov 18, 2016 at 8:15 AM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
> > 
> > > 
> > > AIUI, we're not taking new FB drivers. This should be a DRM
> > > driver
> > > instead.
> > Yes - clone one of the dumb DRM drivers, or if you've got any
> > little bits
> > of acceleration (even rolling the display) then it's possibly worth
> > accelerating for text mode.
> > 
> > > 
> > > > 
> > > > +- max-width: The width of the framebuffer in pixels.
> > > > +- max-height: The height of the framebuffer in pixels.
> > > > +- bits-per-color: only "8" is currently supported
> > > These are not h/w properties.
> > How are the max ones not hardware properties ?
> Because the way they are used is setting the mode, not some check of
> the max when the mode is set. If this is synthesized for only one
> size, then that would be different, but we have bindings for modes.
> 
> Rob

Currently the idea is to just synthesize the display to just 1920 x
1080. Therefore we came to a conclusion that it should be part of the
HW properties.

HeanLoong
