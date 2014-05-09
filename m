From: Tony Lindgren <tony@atomide.com>
Date: Fri, 09 May 2014 15:30:09 +0000
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Message-Id: <20140509153008.GC17814@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-4-git-send-email-tony@atomide.com>
 <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com>
 <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com>
 <20140508233300.GI2198@atomide.com> <536C924E.5000307@ti.com>
In-Reply-To: <536C924E.5000307@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 01:31]:
> On 09/05/14 02:33, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [140507 11:00]:
> >> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140507 09:03]:
> >>> On 07/05/14 18:03, Tony Lindgren wrote:
> >>>>
> >>>> BTW, I'm also personally fine with all five gpios showing in a single
> >>>> gpios property, I'm not too exited about naming anything in DT..
> >>>
> >>> I don't have a strong opinion here. I don't have much experience with
> >>> DT, especially with making bindings compatible with other ones.
> >>>
> >>> I'd just forget the simple-panel, and have single gpio array.
> >>
> >> Well if it's a don't care flag for both of us, let's try to use
> >> the existing standard for simple-panel.txt and add mode-gpios
> >> property. I'll post a patch for that.
> > 
> > Here's an updated version using enable-gpios, reset-gpios and
> > mode-gpios. So it follows simple-panel.txt and adds mode-gpios
> > that's currently specific to this panel only.
> > 
> > Also updated for -EPROBE_DEFER handling, tested that by changing
> > one of the GPIOs to be a twl4030 GPIO.
> 
> To speed things up a bit, I made the changes I suggested. Compile tested
> only.

OK thanks did not get the penguin with it so need to look at it a bit
more.

Regards,

Tony
