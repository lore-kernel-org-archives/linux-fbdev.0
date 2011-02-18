From: "Clark, Rob" <rob@ti.com>
Date: Fri, 18 Feb 2011 04:32:24 +0000
Subject: Re: [PATCH] i.MX23/28 framebuffer driver
Message-Id: <AANLkTimFBSJ04o29GFFqtwp32k_EfHGemE-h35O4xx7B@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
	<AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
	<201102161322.08126.arnd@arndb.de>
	<AANLkTik+ounqcTJ6rhiUqKPGkwcCOKGXdsVADs6zHfPU@mail.gmail.com>
	<AANLkTimMBLhopNq0L-NuJLdX08SrA078VF3tWf9TcEom@mail.gmail.com>
	<alpine.LFD.2.00.1102171545470.21278@casper.infradead.org>
	<AANLkTimcwr4vpycSQCH9vMaB+umh+yHD_+WD2MJNqMOB@mail.gmail.com>
In-Reply-To: <AANLkTimcwr4vpycSQCH9vMaB+umh+yHD_+WD2MJNqMOB-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jammy Zhou <jammy.zhou-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, DRI development list <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, James Simmons <jsimmons-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jakob Bornecrantz <wallbraker-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

I'm all for a more modular drm, although I think the framework of
CRTCs, encoders, and connectors is a nice fit, at least for our hw.
It would be nice to have a better way to expose overlays.  And I'm
still thinking about how/if GEM fits in with our various video and
2/3d accelerators.

BR,
-R

On Thu, Feb 17, 2011 at 8:19 PM, Jammy Zhou <jammy.zhou@linaro.org> wrote:
> To accommodate the fact of independent display controller and GPU compone=
nts
> in ARM SOC, it will be better if we can separate KMS from DRM both in ker=
nel
> space and user space (i.e, create a new drivers/video/kms directory for
> kernel side, move KMS related code in libdrm to libkms in user space). Th=
en
> we can build xrandr1.2+ support based on KMS for ARM platforms, even if D=
RM
> is still not supported. Besides, for buffer management part (GEM) in DRM,=
 if
> possible, we can also make it an independent module leaving DRM just a
> wrapper, so that the GEM stuff can be used more flexibly.
>
> Regards,
> Jammy
>
> On Fri, Feb 18, 2011 at 12:14 AM, James Simmons <jsimmons@infradead.org>
> wrote:
>>
>> > I'm still in the learning-as-I-go phase here, so definitely not ready
>> > to propose a solution, but it does seem to me like there is room for
>> > some sort of kms-helper library here to handle more of the boilerplate
>> > xf86-video-* stuff.. =A0I guess I'll have a better picture once I have=
 a
>> > chance to add support for the various multi-monitor configurations.
>> > But certainly would be interested if anyone already has some ideas.
>>
>> I have been thinking about this as well. One of the short coming for DRM
>> on embedded platforms is the lack of a small well defined library that o=
ne
>> could use. Right now libkms only handles buffer allocation. The mode
>> setting is currently tied to the libdrm library. It would be nice to
>> seperate the two out more. Move the mode setting code to libkms and then
>> have libdrm be a wrapper around this. This way libdrm can both support
>> the legacy drm drivers and the new kms drivers at the same time. It also
>> makes a clear seperation. Jakob if you are willing to take this work I
>> will gladly seen you patches.
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev@lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
>
