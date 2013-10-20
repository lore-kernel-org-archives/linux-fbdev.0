From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Sun, 20 Oct 2013 19:29:10 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <52642F06.8010102@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <4885946.7Zgjf9zNXx@avalon> <525FD12D.3000200@ti.com> <3768216.eiA2v5KI6a@avalon> <525FD8DD.3090509@ti.com>
In-Reply-To: <525FD8DD.3090509-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 10/17/2013 02:32 PM, Tomi Valkeinen wrote:
> On 17/10/13 15:17, Laurent Pinchart wrote:
>> On Thursday 17 October 2013 14:59:41 Tomi Valkeinen wrote:
>>> On 17/10/13 14:51, Laurent Pinchart wrote:
>>>>> I'm not sure if there's a specific need for the port or endpoint nodes
>>>>> in cases like the above. Even if we have common properties describing
>>>>> the endpoint, I guess they could just be in the parent node.
>>>>>
>>>>> panel {
>>>>> 	remote =<&dc>;
>>>>> 	common-video-property =<asd>;
>>>>> };
>>>>>
>>>>> The above would imply one port and one endpoint. Would that work? If we
>>>>> had a function like parse_endpoint(node), we could just point it to
>>>>> either a real endpoint node, or to the device's node.
>>>>
>>>> You reference the display controller here, not a specific display
>>>> controller output. Don't most display controllers have several outputs ?
>>>
>>> Sure. Then the display controller could have more verbose description.
>>> But the panel could still have what I wrote above, except the 'remote'
>>> property would point to a real endpoint node inside the dispc node, not
>>> to the dispc node.
>>>
>>> This would, of course, need some extra code to handle the different
>>> cases, but just from DT point of view, I think all the relevant
>>> information is there.
>>
>> There's many ways to describe the same information in DT. While we could have
>> DT bindings that use different descriptions for different devices and still
>> support all of them in our code, why should we opt for that option that will
>> make the implementation much more complex when we can describe connections in
>> a simple and generic way ?
>
> My suggestion was simple and generic. I'm not proposing per-device
> custom bindings.
>
> My point was, if we can describe the connections as I described above,
> which to me sounds possible, we can simplify the panel DT data for 99.9%
> of the cases.
>
> To me, the first of these looks much nicer:
>
> panel {
> 	remote =<&remote-endpoint>;
> 	common-video-property =<asd>;
> };
>
> panel {
> 	port {
> 		endpoint {
> 			remote =<&remote-endpoint>;
> 			common-video-property =<asd>;
> 		};
> 	};
> };
>
> If that can be supported in the SW by adding complexity to a few
> functions, and it covers practically all the panels, isn't it worth it?
>
> Note that I have not tried this, so I don't know if there are issues.
> It's just a thought. Even if there's need for a endpoint node, perhaps
> the port node can be made optional.

Each endpoint node was originally supposed to contain the port configuration
properties specific to a single remote device. So there would be more than
one endpoint sub-mode of a port node only if, e.g. a display controller 
could
output data through a single port to more than one panel (not necessarily
simultaneously).

If it is known in the display subsystems there is no use case where single
data output (port) is being switched between (connected to) multiple data
sinks we could probably omit the endpoint nodes in order to simplify the
bindings a bit.

We could have something like:

dispc {
	disp_port: port {
		remote-port = <&p_port>;
		common-video-property = <>;
	};
};

panel {
	p_port: port {
		remote-port = <&disp_port>;
		common-video-property = <>;
	};
};

Alternatively we could say, that for only one endpoint node needed such an
endpoint node can be omitted and the common video properties can be 
specified
directly in the port node.

This would require introducing 'remote-port' phandle property, as
remote-endpoint is supposed to point to an endpoint, not a port node.

Regarding the reverse link phandle, I was wondering if it shouldn't be made
optional. We would have to think twice about such a change though, since
making an optional property back mandatory wouldn't be possible.

--
Thanks,
Sylwester
