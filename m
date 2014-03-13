From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 13 Mar 2014 13:12:48 +0000
Subject: Re: [PATCH v5 1/2] video: ARM CLCD: Add DT support
Message-Id: <1394716368.32336.16.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
 <53184C2E.3000807@ti.com> <1394119431.4160.84.camel@hornet>
 <5319AF00.5030602@ti.com> <1394453382.3853.6.camel@hornet>
 <531DAEB9.3020502@ti.com>
In-Reply-To: <531DAEB9.3020502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 2014-03-10 at 12:23 +0000, Tomi Valkeinen wrote:
> The DT describes the hardware, and there should be only one description
> of it, no matter what the used SW is. I see compatible = "arm,pl111" in
> the dts. PL111 is the LCD controller, right? 

Correct.

> What will the DRM driver
> use, then, 

Exactly the same properties, plus (hopefully) the generic display data,
when (if) ready.

> if the "arm,pl111" DT data is designed to work only for the
> fbdev?

The binding I proposed is *not* designed to work only with the fbdev
driver, no. That's what I was trying to say all way long, if I failed -
apologies.

So let me say it again: with the exception display timings subnode, all
other properties will be important for the DRM scan out driver as well.
As to the display timings, being optional can be easily marked as
deprecated and replaced with the proper solution.

Now, if you find any other property I proposed being non generic enough
(ie. fbdev-specific), I will happily discuss it. Once you get generic
display bindings in place, I will gladly do all that will be required to
make CLCD driver(s) use them. But I will rather drop and forget this
patch completely that get dragged into another
"display/video/CDF/DRM/whatever" discussion. Hope I made myself clear.

Pawel

