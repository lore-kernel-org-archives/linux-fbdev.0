From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 08 Oct 2012 07:34:13 +0000
Subject: Re: [PATCH 1/2 v6] of: add helper to parse display timings
Message-Id: <20121008073413.GA20800@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349373560-11128-1-git-send-email-s.trumtrar@pengutronix.de>
 <506F0911.1050808@wwwdotorg.org>
 <20121005163858.GD2053@pengutronix.de>
 <9190603.vEUidl99Ca@avalon>
In-Reply-To: <9190603.vEUidl99Ca@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-media@vger.kernel.org

On Sun, Oct 07, 2012 at 03:38:25PM +0200, Laurent Pinchart wrote:
> Hi Steffen,
> 
> On Friday 05 October 2012 18:38:58 Steffen Trumtrar wrote:
> > On Fri, Oct 05, 2012 at 10:21:37AM -0600, Stephen Warren wrote:
> > > On 10/05/2012 10:16 AM, Steffen Trumtrar wrote:
> > > > On Thu, Oct 04, 2012 at 12:47:16PM -0600, Stephen Warren wrote:
> > > >> On 10/04/2012 11:59 AM, Steffen Trumtrar wrote:
> > > ...
> > > 
> > > >>> +	for_each_child_of_node(timings_np, entry) {
> > > >>> +		struct signal_timing *st;
> > > >>> +
> > > >>> +		st = of_get_display_timing(entry);
> > > >>> +
> > > >>> +		if (!st)
> > > >>> +			continue;
> > > >> 
> > > >> I wonder if that shouldn't be an error?
> > > > 
> > > > In the sense of a pr_err not a -EINVAL I presume?! It is a little bit
> > > > quiet in case of a faulty spec, that is right.
> > > 
> > > I did mean return an error; if we try to parse something and can't,
> > > shouldn't we return an error?
> > > 
> > > I suppose it may be possible to limp on and use whatever subset of modes
> > > could be parsed and drop the others, which is what this code does, but
> > > the code after the loop would definitely return an error if zero timings
> > > were parseable.
> > 
> > If a display supports multiple modes, I think it is better to have a working
> > mode (even if it is not the preferred one) than have none at all.
> > If there is no mode at all, that should be an error, right.
> 
> If we fail completely in case of an error, DT writers will notice their bugs. 
> If we ignore errors silently they won't, and we'll end up with buggy DTs (or, 
> to be accurate, even more buggy DTs :-)). I'd rather fail completely in the 
> first implementation and add workarounds later only if we need to.
> 

Okay, that is two against one. And if you say it like this, Stephen and you are
right I guess. Fail completely it is then.

Regards,

Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
