From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 12 Sep 2013 22:19:45 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <52323E01.2070902@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com> <1378725559.4082.28.camel@hornet>
 <522F91F8.6010207@gmail.com> <1378907036.4082.105.camel@hornet>
 <5230DD1C.6060606@gmail.com> <1378999425.13571.54.camel@hornet>
 <1379009416.13571.68.camel@hornet>
In-Reply-To: <1379009416.13571.68.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/12/2013 12:10 PM, Pawel Moll wrote:
> On Thu, 2013-09-12 at 16:23 +0100, Pawel Moll wrote:
>> Anyway, I think I've got an idea how to render the problem custom panel
>> properties invalid. If so, I'll send another version of the patch.
> 
> So, instead of describing the panel I thought I'd go lower level and try
> to describe the CLCD's signal functions. It gets down to something like
> this:
> 
> 8<----
> - arm,pl11x,panel-data-pads: array of 24 cells, each of them describing
> 				a function of one of the CLD pads,
> 				starting from 0 up to 23; each pad can
> 				be described by one of the following values:
> 	- 0: reserved (not connected)
> 	- 0x100-0x107: color upper STN panel data 0 to 7
...
> Such approach would also solve problem with bizarre cases like the
> Versatile's (not Express ;-) muxer Russell mentioned (where there is a
> de-facto custom wiring used). And no, I had a look at pinmux bindings
> and I don't think they fit here at all...
> 
> Thoughts?

I think pinctrl would work just fine here. However, I suspect there's
little need for pinctrl. pinctrl is required when one module may impose
requirements on another module's muxable pins. I assume that the
configuration for pins on CLCD is only relevant for CLCD itself, so
there's no need to export an interface by which something else can
configure the pins. Now, if any of the pins could be e.g. "GPIO", then
this argument might not apply. Hence, I think pinctrl is only "possible"
here, not "required", and the approach above seems fine to me.
