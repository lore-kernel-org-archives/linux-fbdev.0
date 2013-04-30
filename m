From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Apr 2013 15:07:57 +0000
Subject: Re: Re[2]: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <201304301707.57197.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <517F753F.5090909@ti.com> <1367332685.945287573@f287.mail.ru>
In-Reply-To: <1367332685.945287573@f287.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 30 April 2013, Alexander Shiyan wrote:
> > On 04/04/2013 05:39 AM, Stephen Warren wrote:
> > > A simple frame-buffer describes a raw memory region that may be rendered
> > > to, with the assumption that the display hardware has already been set
> > > up to scan out from that buffer.
> > > 
> > > This is useful in cases where a bootloader exists and has set up the
> > > display hardware, but a Linux driver doesn't yet exist for the display
> > > hardware.
> > > 
> > > Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ...
> > > +   framebuffer {
> > > +           compatible = "simple-framebuffer";
> > > +           reg = <0x1d385000 (1600 * 1200 * 2)>;
> > > +           width = <1600>;
> > > +           height = <1200>;
> > > +           stride = <(1600 * 2)>;
> > > +           format = "r5g6b5";
> > > +   };
> > 
> > I'm not an expert on DT, but I think the point of DT is to describe the
> > hardware. This doesn't describe the hardware at all.
> 
> On my incompetent opinion, "bpp" parameter can replace size of
> framebuffer and "stride". Is not it?

Not necessarily: you could have a stride that is larger than a line.

	Arnd
