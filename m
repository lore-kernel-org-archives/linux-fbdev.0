From: Mitch Bradley <wmb@firmworks.com>
Date: Mon, 01 Oct 2012 21:08:16 +0000
Subject: Re: [PATCH 1/2] of: add helper to parse display specs
Message-Id: <506A0640.50105@firmworks.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348500924-8551-1-git-send-email-s.trumtrar@pengutronix.de>
 <1348500924-8551-2-git-send-email-s.trumtrar@pengutronix.de>
 <5069CA74.7040409@wwwdotorg.org> <5069EC1C.2050506@firmworks.com>
 <5069FC20.8060708@wwwdotorg.org>
In-Reply-To: <5069FC20.8060708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/1/2012 10:25 AM, Stephen Warren wrote:
> On 10/01/2012 01:16 PM, Mitch Bradley wrote:
>> On 10/1/2012 6:53 AM, Stephen Warren wrote:
>>> On 09/24/2012 09:35 AM, Steffen Trumtrar wrote:
>>>> Parse a display-node with timings and hardware-specs from devictree.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/video/display b/Documentation/devicetree/bindings/video/display
>>>> new file mode 100644
>>>> index 0000000..722766a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/video/display
>>>
>>> This should be display.txt.
>>>
>>>> @@ -0,0 +1,208 @@
>>>> +display bindings
>>>> +=========
>>>> +
>>>> +display-node
>>>> +------------
>>>
>>> I'm not personally convinced about the direction this is going. While I
>>> think it's reasonable to define DT bindings for displays, and DT
>>> bindings for display modes, I'm not sure that it's reasonable to couple
>>> them together into a single binding.
>>>
>>> I think creating a well-defined timing binding first will be much
>>> simpler than doing so within the context of a display binding; the
>>> scope/content of a general display binding seems much less well-defined
>>> to me at least, for reasons I mentioned before.
>>>
>>>> +required properties:
>>>> + - none
>>>> +
>>>> +optional properties:
>>>> + - default-timing: the default timing value
>>>> + - width-mm, height-mm: Display dimensions in mm
>>>
>>>> + - hsync-active-high (bool): Hsync pulse is active high
>>>> + - vsync-active-high (bool): Vsync pulse is active high
>>>
>>> At least those two properties should exist in the display timing instead
>>> (or perhaps as well). There are certainly cases where different similar
>>> display modes are differentiated by hsync/vsync polarity more than
>>> anything else. This is probably more likely with analog display
>>> connectors than digital, but I see no reason why a DT binding for
>>> display timing shouldn't cover both.
>>>
>>>> + - de-active-high (bool): Data-Enable pulse is active high
>>>> + - pixelclk-inverted (bool): pixelclock is inverted
>>>
>>>> + - pixel-per-clk
>>>
>>> pixel-per-clk is probably something that should either be part of the
>>> timing definition, or something computed internally to the display
>>> driver based on rules for the signal type, rather than something
>>> represented in DT.
>>>
>>> The above comment assumes this property is intended to represent DVI's
>>> requirement for pixel clock doubling for low-pixel-clock-rate modes. If
>>> it's something to do with e.g. a single-data-rate vs. double-data-rate
>>> property of the underlying physical connection, that's most likely
>>> something that should be defined in a binding specific to e.g. LVDS,
>>> rather than something generic.
>>>
>>>> + - link-width: number of channels (e.g. LVDS)
>>>> + - bpp: bits-per-pixel
>>>> +
>>>> +timings-subnode
>>>> +---------------
>>>> +
>>>> +required properties:
>>>> +subnodes that specify
>>>> + - hactive, vactive: Display resolution
>>>> + - hfront-porch, hback-porch, hsync-len: Horizontal Display timing parameters
>>>> +   in pixels
>>>> +   vfront-porch, vback-porch, vsync-len: Vertical display timing parameters in
>>>> +   lines
>>>> + - clock: displayclock in Hz
>>>> +
>>>> +There are different ways of describing a display and its capabilities. The devicetree
>>>> +representation corresponds to the one commonly found in datasheets for displays.
>>>> +The description of the display and its timing is split in two parts: first the display
>>>> +properties like size in mm and (optionally) multiple subnodes with the supported timings.
>>>> +If a display supports multiple signal timings, the default-timing can be specified.
>>>> +
>>>> +Example:
>>>> +
>>>> +	display@0 {
>>>> +		width-mm = <800>;
>>>> +		height-mm = <480>;
>>>> +		default-timing = <&timing0>;
>>>> +		timings {
>>>> +			timing0: timing@0 {
>>>
>>> If you're going to use a unit address ("@0") to ensure that node names
>>> are unique (which is not mandatory), then each node also needs a reg
>>> property with matching value, and #address-cells/#size-cells in the
>>> parent. Instead, you could name the nodes something unique based on the
>>> mode name to avoid this, e.g. 1080p24 { ... }.
>>
>>
>> I'm concerned that numbered nodes are being misused as arrays.
>>
>> It's easy to make real arrays by including multiple cells in the value
>> of each timing parameter, and easy to choose a cell by saying the array
>> index instead of using the phandle.
> 
> In this case though, arrays don't work out so well in my opinion:
> 
> We want to describe a set of unrelated display modes that the display
> can handle. These are logically separate entities. I don't think
> combining the values that represent say 5 different modes into a single
> set of properties really makes sense here; a separate node or property
> per display mode really does make sense because they're separate objects.

That argument seems pretty dependent on how you choose to look at things.


> 
> Related, each display timing parameter (e.g. hsync length, position,
> ...) has a range, so min/typical/max values. These are already
> represented as a 3-cell property as I believe you're proposing.
> Combining that with a cell that represents n different modes in a single
> array seems like it'd end up with something rather hard to read, at
> least for humans even if it would be admittedly trivial for a CPU.


That argument is better.

> 
