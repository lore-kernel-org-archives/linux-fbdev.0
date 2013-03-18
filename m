From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 18 Mar 2013 07:58:15 +0000
Subject: Re: [PATCH 5/5] videomode: rename fields
Message-Id: <20130318080057.GL9021@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
	<1363083578-17062-5-git-send-email-tomi.valkeinen@ti.com>
	<16625567.P7GdYge43z@avalon> <513F303E.5000007@ti.com>
In-Reply-To: <513F303E.5000007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org

On Tue, Mar 12, 2013 at 03:40:14PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 2013-03-12 15:37, Laurent Pinchart wrote:
> > Hi Tomi,
> > 
> > Thanks for the patch.
> > 
> > On Tuesday 12 March 2013 12:19:38 Tomi Valkeinen wrote:
> >> Structs videomode and display_timing have rather long field names for
> >> the timing values. Nothing wrong with that as such, but this patch
> >> changes them to abbreviations for the following reasons:
> >>
> >> * The timing values often need to be used in calculations, and long
> >>   field names makes their direct use clumsier.
> >>
> >> * The current names are a bit of a mishmash: some words are used as
> >>   such, some are shortened, and for some only first letter is used. Some
> >>   names use underscode, some don't. All this makes it difficult to
> >>   remember what the field names are.
> >>
> >> * The abbreviations used in this patch are very common, and there
> >>   shouldn't be any misunderstanding about their meaning.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >> ---
> > 
> > I have no strong opinion on this, but I find the existing names easier to 
> > read. I might be biased by having read them often though.
> 
> Yes, the last patch was a bit of a "teaser" =). I found myself typoing
> them a lot, using helper local variables to shorten the code lines, and
> as I mention in the description, I find them a bit of a mishmash. So,
> while they're not used in any drivers yet, I thought it'd be worth a
> shot to change them.

Imo the new names look quite a bit more ugly and less readable, for very
few saved chars. And at least for i915.ko development it's been a long
time since I've last had to type them ... Maybe the real problem is that
we have a few too many video mode structures and can't properly share
them?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
