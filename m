From: Rob Herring <robherring2@gmail.com>
Date: Mon, 10 Mar 2014 20:32:41 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <CAL_Jsq+cwWXCmFDK7b+YVo5vYKqxtN6ym=YbOqYnJwCPf2JpWQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
	<20140228162752.GU21483@n2100.arm.linux.org.uk>
	<5310BDE3.60603@ti.com>
	<20140228165628.GX21483@n2100.arm.linux.org.uk>
	<53143796.2050309@ti.com>
	<CAL_JsqLppZHjND_LFMxscR0WCD4Ox7vF0fDbQFoYg=TENXxY8Q@mail.gmail.com>
	<531DEB1A.5090509@ti.com>
In-Reply-To: <531DEB1A.5090509-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Mon, Mar 10, 2014 at 11:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Rob,
>
> On 10/03/14 18:05, Rob Herring wrote:
>
>>> Russell's point was that these connector bindings are very generic, i.e.
>>> they are not for any particular chip from a particular vendor, but for
>>> any connector for DVI, HDMI or analog-tv. And he's worried that maybe we
>>> shouldn't define such generic bindings without consulting the whole
>>> device-tree community (i.e including non-linux users).
>>
>> So re-work it to be generic and send it out. DT maintainers would
>> rarely disagree that something shouldn't be made generic.
>
> They (in this series) are already designed to be generic.
>
> I should perhaps re-word the question: we are concerned whether these
> bindings are good for all the users, not just us, and whether there
> already exists something that overlaps.

Given this is tied into the rest of video description with endpoints
and such, you really have to look at the whole picture to answer that
question. I'd guess Linux well ahead of other OSs in terms of dealing
with the plethora of video and graphics h/w. I'd be more concerned
that the bindings are good for all h/w rather than all OS's.

> Afaik, there's nothing overlapping. And I don't see why they wouldn't be
> good for all users (with the few minor modifications that have been
> discussed in this thread). But, if I gathered right, Russell would like
> some kind of ack from someone who might know better than us.
>
> So is it enough to have posted these, and gotten acks from the people
> involved, or should we get acks from DT maintainers also?

We really leave it up to the subsystem maintainers to decide, but for
new common/generic bindings it is a good idea to get DT maintainers
ack. I'll go thru the individual patches.

> Is there a way to get the attention of, say, BSD people, or should we
> just presume they'll follow the list?

devicetree-spec was created specifically to have a lower volume list
without a bunch of Linux driver patches which aren't relevant to
people from other OSs.

>>> So the question is, is there such a community and a forum to bring up
>>> this kind of things? If yes, should we bring this up there? If yes, what
>>> kind of things in general should be brought into the attention of
>>> non-linux users?
>>
>> devicetree list is just that. It is not just for Linux. There is the
>> newly created devicetree-spec@vger.kernel.org which is for more
>> core/common binding discussion.
>
> Ok.
>
>>> What I wonder here is that while a thing like DVI connector is, of
>>> course, more generic than, say, "ti,tfp410" encoder chip, but isn't the
>>> case still the same: we're defining global bindings for hardware that
>>> should work for everyone, not only Linux users?
>>
>> Defining the connectors in DT is a useful thing although mainly when
>> you have multiple connectors of the same type. Labels for composite,
>> SVideo, VGA, DVI, HDMI seem less useful to me. Describing position or
>> printed label (like front vs. rear connections) seem more useful to
>> me.
>
> My point above was that it feels mentally easier to define bindings for
> one particular IP block or chip, than defining bindings for a more
> generic thing like "HDMI connector". But, in the end, I believe they
> both should go through similar review, and there's no such difference.

Unless you need to describe different types of HDMI connectors, I
don't see any issue with it being generic. I certainly don't see the
need for prepending with "linux," in this case.

Rob
