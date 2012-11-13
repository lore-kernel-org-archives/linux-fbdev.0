From: Mitch Bradley <wmb@firmworks.com>
Date: Tue, 13 Nov 2012 18:13:31 +0000
Subject: Re: [PATCH v8 2/6] video: add of helper for videomode
Message-Id: <50A28DCB.7050707@firmworks.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352734626-27412-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352734626-27412-3-git-send-email-s.trumtrar@pengutronix.de>
 <20121113110837.GA30049@avionic-0098.mockup.avionic-design.de>
 <50A2878D.8020707@wwwdotorg.org>
 <20121113175147.GA2597@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121113175147.GA2597-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 11/13/2012 7:51 AM, Thierry Reding wrote:
> On Tue, Nov 13, 2012 at 10:46:53AM -0700, Stephen Warren wrote:
>> On 11/13/2012 04:08 AM, Thierry Reding wrote:
>>> On Mon, Nov 12, 2012 at 04:37:02PM +0100, Steffen Trumtrar wrote:
>>>> This adds support for reading display timings from DT or/and
>>>> convert one of those timings to a videomode. The
>>>> of_display_timing implementation supports multiple children where
>>>> each property can have up to 3 values. All children are read into
>>>> an array, that can be queried. of_get_videomode converts exactly
>>>> one of that timings to a struct videomode.
>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/video/display-timings.txt
>>>> b/Documentation/devicetree/bindings/video/display-timings.txt
>>
>>>> + - clock-frequency: displayclock in Hz
>>>
>>> "display clock"?
>>
>> I /think/ I had suggested naming this clock-frequency before so that
>> the property name would be more standardized; other bindings use that
>> same name. But I'm not too attached to the name I guess.
> 
> That's not what I meant. I think "displayclock" should be two words in
> the description of the property. The property name is fine.

Given that modern display engines often have numerous clocks, perhaps it
would be better to use a more specific name, like for example "pixel-clock".

> 
> Thierry
> 
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
