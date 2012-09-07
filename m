From: Stephen Warren <swarren@wwwdotorg.org>
Date: Fri, 07 Sep 2012 16:36:02 +0000
Subject: Re: [PATCH v5 1/4] Runtime Interpreted Power Sequences
Message-Id: <504A2272.8040209@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346412846-17102-1-git-send-email-acourbot@nvidia.com>
 <201209061614.54022.heiko@sntech.de> <1887927.1deN8M9siP@percival>
 <201209071108.42083.heiko@sntech.de>
In-Reply-To: <201209071108.42083.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On 09/07/2012 03:08 AM, Heiko St=FCbner wrote:
> Am Freitag, 7. September 2012, 10:04:24 schrieb Alex Courbot:
>>> For your power_seq_run function you write that it simply returns an err=
or
>>> code on failure and looking through it I also just found the error retu=
rn
>>> statement. This would leave a device half turned on.
>>>
>>> So I'm wondering, if it shouldn't turn off all the things it turned on
>>> until the step that produced the error. All your possible step types
>>> (execpt the delay) are booleans, so it should be possible to simply
>>> negate them when backtracking through the previous steps.
>>
>> Indeed, I think you raised an important point. Right now all step types =
are
>> invertible, but we cannot rely on that statement to be true forever. For
>> instance, one short-term improvement will be to allow finer regulator
>> control, like voltage setting. In this case, how can we go back to the
>> initial state without recording it?
>>
>> If e.g. the power on sequence fails at step N (of M steps for that
>> sequence), one could try playing the corresponding power off sequence
>> (either completely of from step M - N), but then again we cannot rely on
>> sequences to be perfectly symetrical. Maybe this is more something for t=
he
>> calling driver to check for and control?
>=20
> Am Freitag, 7. September 2012, 10:15:03 schrieb Mark Brown:
>> On Fri, Sep 07, 2012 at 05:04:24PM +0900, Alex Courbot wrote:
>>> If e.g. the power on sequence fails at step N (of M steps for that
>>> sequence), one could try playing the corresponding power off sequence
>>> (either completely of from step M - N), but then again we cannot rely on
>>> sequences to be perfectly symetrical. Maybe this is more something for
>>> the calling driver to check for and control?
>>
>> That had been my thought too - depending on what the sequence is for it
>> may be that the corrective action is something very different to
>> reversing the sequence, for example a device reset may be required.
>=20
> If I understood the description correctly, the power sequence should be=20
> transparent to the driver, as it implements board specific actions and=20
> shouldn't bother the driver with it to much.

Well, the contents/implementation of the sequence should be transparent
to the driver. The fact that a sequence exists and needs to be executed
obviously can't be transparent to the driver, since the driver needs to
call an API to execute the sequence.

I'd assert that requiring the driver to get back to a sane state by
executing sequence (b) if sequence (a) fails is fairly reasonable, and
doesn't give the driver any more knowledge of what the sequences are
than what it already has.

But then I start to wonder: What if the "help something went wrong"
sequence gets an error...

> Therefore my thoughts went along
> the lines how gpio_request_array handles this, always producing a sane st=
ate=20
> at the end.
>=20
> Recording the previous state, could be done by making a copy of the curre=
nt=20
> sequence, and just noting the previous values (including voltages etc) in=
 the=20
> respective entries. And in the error case running this new sequence from =
the=20
> error point instead to power down again.
>=20
>=20
> As both Alex and Mark wrote, reversing the sequence might be the action o=
f=20
> choice only for some devices, but others might need to run a completely=20
> different powerdown sequence and still others would need special handling.
>=20
> Would it be possible to encode this in the sequence definition, something=
 like
> 	on-error =3D "reverse"
>=20
> 	on-error =3D "sequence"
> 	error-seq =3D <&other_sequence>
>=20
> 	on-error =3D "driver"
> with better names and types of course.
>=20
> This would keep the power sequence transparent to most drivers and only t=
he=20
> real esoteric ones would need to do their special handling on their own.

Yes, something like that sounds reasonable on the surface. I'm not sure
about the on-error=3D"driver" case though; if the driver knows nothing
about the content of the sequences, I'm not sure how the driver could
possibly do anything other than execute some sequence to recover.
