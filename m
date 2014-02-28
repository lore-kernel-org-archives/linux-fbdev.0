From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Fri, 28 Feb 2014 13:51:22 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <5310945A.9040106@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <531087C0.1090501@gmail.com> <53108B9C.5000006@ti.com>
In-Reply-To: <53108B9C.5000006-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 02/28/14 14:14, Tomi Valkeinen wrote:
> On 28/02/14 14:57, Sebastian Hesselbarth wrote:
>
>> Out of curiosity, will there be DT nodes for pull-up resistors soon,
>> too? ;)
>
> If they don't work automatically, yes, we need DT nodes and drivers for
> them.
>
>> Honestly, TPD12S015 is a level shifter, there is nothing in it that
>> would justify a DT node nor a driver.
>
> TPD requires a power. Who turns that on? It also has two GPIOs, LS_OE
> and CT_CP_HPD, which need to be controlled based on what the user wants
> and the state of the HPD line. Who controls those?

Strictly speaking TPD12S015 has _no_ GPIO but only buffers. It
translates one voltage to another. The controlling instance is
your "video card" that is really interested in the actual state
of HPD signal.

Also the same for power, TPD12S015 doesn't decide to be powered up
or down but the "video card" does. We have GPIO regulators that
deal with that situation already.

Consider the same board but replace TPD12S015 with another level-
shifter, you still want OMAP video driver work with that out-of-the-box,
don't you? Fact is, OMAP IP requires GPIOs to sense HPD status hence
that GPIO is a property of the corresponding OMAP node. How level-
translation happens is irrelevant here.

>> Above you already note, that connector nodes should offer HPD in the
>> future, but I guess the binding should represent that now already.
>
> I think it can be added when somebody uses it. I don't see why that
> would cause trouble later to those that don't use it.

Thinking about it again, HPD gpio shouldn't be a property of the
connector at all but again the controlling instance. The connector
cannot deal with the information provided by HPD nor can it determine
if anyone is listening to HPD events.

>> I will be a DT stub anyway, the corresponding video sink driver will
>> have to look it up.
>
> I'm not sure what you mean with that. Yes, it's not the most complex DT
> nodes out there.
 >
>> Looking through the bindings for DVI and HDMI, I guess HPD gpio is
>> better kept in those nodes. From the relevant (DT) properties DVI and
>> HDMI connectors are in no way different.
>
> Well, I think the HPD gpio should be where it's most logical to have it.

Right, but this is usually the controlling instance and not the
consuming one. E.g. to detect presence of an MMC card by GPIO, you'd
put that into the MMC _controller_ not any card node.

> I mean, you could have a setup where you have the SoC HDMI encoder and
> and the HDMI connector, and the HPD pin goes directly to the HDMI
> encoder, which has HW support for it. In that case, the HDMI encoder
> node should contain the HPD, and the HDMI encoder should handle it.

I wonder, if in case of an dedicated HPD pin, you would ever expose that
in DT.

> Or, your HDMI encoder could not have any kind of support for HPD. In
> that case you could have the HDMI connector driver handle the hotplug
> event. You could of course make the HDMI encoder driver handle the HPD
> gpio, but I usually try to have the driver handle the hardware device in
> question.

Having a driver for a dumb connector seems to be a little exaggerated.
Consider your generic HDMI connector "driver" connected to dedicated HPD
case above. It is pretty useless then. OTOH video controllers with 
dedicated HPD know very well they can control HPD themselves, video 
controllers without dedicated HPD also know very well that they need
GPIO for it.

> In OMAP's case, we have the TPD chip between the HDMI encoder and the
> connector, and the logical place to handle HPD GPIO in that case is the
> TPD driver, as that's where the HPD is connected to and the TPD needs to
> be configured according to the state of the HPD.

Is it really the logical place to handle HPD? I'd have put it into the
HDMI encoder because it's the unit most interested in the state of HPD.

Please, don't get me wrong, I like all this to be baked into a binding -
just wondering if a level-shifter driver plus corresponding DT node
is too much detail in here.

Sebastian


