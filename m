From: Warner Losh <bsdimp@gmail.com>
Date: Fri, 28 Feb 2014 16:28:22 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <E2528116-7208-48EB-ADCF-D91B2C6DA0DB@bsdimp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com> <20140228155937.GQ21483@n2100.arm.linux.org.uk> <5310B567.7040605@ti.com> <20140228162327.GT21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228162327.GT21483-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


On Feb 28, 2014, at 9:23 AM, Russell King - ARM Linux <linux@arm.linux.org.=
uk> wrote:

> On Fri, Feb 28, 2014 at 06:12:23PM +0200, Tomi Valkeinen wrote:
>> On 28/02/14 17:59, Russell King - ARM Linux wrote:
>>=20
>>>> +dvi0: connector@0 {
>>>> +	compatible =3D "dvi-connector";
>>>> +	label =3D "dvi";
>>>> +
>>>> +	i2c-bus =3D <&i2c3>;
>>>> +
>>>> +	dvi_connector_in: endpoint {
>>>> +		remote-endpoint =3D <&tfp410_out>;
>>>> +	};
>>>> +};
>>>=20
>>> This looks far too simplistic.  There are different classes of DVI
>>> connector - there is:
>>>=20
>>> DVI A - analogue only
>>> DVI D - digital only (single and dual link)
>>> DVI I - both (single and dual digital link)
>>>=20
>>> DRM at least makes a distinction between these three classes, and this
>>> disctinction is part of the user API.  How would a display system know
>>> which kind of DVI connector is wired up on the board from this DT
>>> description?
>>=20
>> Yes, I think that's a valid change. But do we also need to specify
>> single/dual link, in addition to the three types?
>=20
> I would argue that as it's a difference in physical hardware, then it
> should be described in DT, even if we don't use it.  The reasoning is
> that although we may not use it today, we may need to use it in the
> future, and as we're describing what the hardware actually is - and
> even in this case what pins may be present or missing on the connector,
> it's unlikely to be problematical (the only problem is when someone
> omits it...)

And the =93we=94 that uses the DT files is larger than just the Linux, and =
one of
those systems may use it.

Warner

