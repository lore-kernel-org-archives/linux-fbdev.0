From: "Clark, Rob" <rob@ti.com>
Date: Thu, 17 Feb 2011 01:08:48 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <AANLkTimMBLhopNq0L-NuJLdX08SrA078VF3tWf9TcEom@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
	<AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
	<201102161322.08126.arnd@arndb.de>
	<AANLkTik+ounqcTJ6rhiUqKPGkwcCOKGXdsVADs6zHfPU@mail.gmail.com>
In-Reply-To: <AANLkTik+ounqcTJ6rhiUqKPGkwcCOKGXdsVADs6zHfPU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

I'm still in the learning-as-I-go phase here, so definitely not ready
to propose a solution, but it does seem to me like there is room for
some sort of kms-helper library here to handle more of the boilerplate
xf86-video-* stuff..  I guess I'll have a better picture once I have a
chance to add support for the various multi-monitor configurations.
But certainly would be interested if anyone already has some ideas.

BR,
-R

On Wed, Feb 16, 2011 at 8:42 AM, Jesse Barker <jesse.barker@linaro.org> wro=
te:
> Speaking for the Linaro graphics working group, I think it's great.=A0 An=
d, I
> think you're right, that if enough of the KMS support in xf86-video-* is
> similar enough (I was only aware of intel and nouveau supporting it prope=
rly
> at current), pulling it out into a common layer would make it easier to
> support in new drivers (including fbdev).
>
> cheers,
> Jesse
>
> On Wed, Feb 16, 2011 at 4:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tuesday 15 February 2011, Clark, Rob wrote:
>> > I'd been experimenting a bit on the side w/ the DRM driver framework (
>> >
>> > http://gitorious.com/~robclark/pandaboard/robclarks-kernel-omap4/commi=
ts/omap_gpu
>> > ), but had to add a good chunk of mostly boilerplate code to our xorg
>> > driver in order just to test it. =A0Maybe some generic support for KMS
>> > in xf86-video-fbdev would have made this easier to develop the kernel
>> > part without in parallel having to implement the userspace part. =A0I'm
>> > not sure if this is the sort of thing the linaro-wg has in mind?
>>
>> I'm not sure what the the linaro multimedia wg thinks of this, but the
>> kernel code you linked looks like it's doing exactly the right thing.
>>
>> =A0 =A0 =A0 =A0Arnd
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev@lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
>
