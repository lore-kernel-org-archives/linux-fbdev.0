From: Olliver Schinagl <oliver@schinagl.nl>
Date: Wed, 25 Mar 2015 10:56:38 +0000
Subject: Re: [PATCH 5/8] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <55129466.4060000@schinagl.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de> <20150207112043.GO2079@lukather> <20150207170503.045490aa@maestro.intranet> <20150214155415.GC25269@lukather> <54FECB5D.1020908@ti.com>
In-Reply-To: <54FECB5D.1020908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com

Hey all,

On 10-03-15 11:45, Tomi Valkeinen wrote:
> On 14/02/15 17:54, Maxime Ripard wrote:
>> On Sat, Feb 07, 2015 at 05:05:03PM +0100, Thomas Niederpr=FCm wrote:
>>> Am Sat, 7 Feb 2015 12:20:43 +0100
>>> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>>>
>>>> On Fri, Feb 06, 2015 at 11:28:11PM +0100, niederp@physik.uni-kl.de
>>>> wrote:
>>>>> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>>>>>
>>>>> This patch adds a module parameter 'bitsperpixel' to adjust the
>>>>> colordepth of the framebuffer. All values >1 will result in memory
>>>>> map of the requested color depth. However only the MSB of each
>>>>> pixel will be sent to the device. The framebuffer identifies itself
>>>>> as a grayscale display with the specified depth.
>>>>
>>>> I'm not sure this is the right thing to do.
>>>>
>>>> The bits per pixel for this display is rightfully defined, used and
>>>> reported to the userspace, why would you want to change that?
>>>
>>> You are right of course. The display is 1bpp and it reports to be 1
>>> bpp. The problem is that there is almost no userspace library that can
>>> handle 1 bit framebuffers correctly. So it is nice if the framebuffer
>>> (optionally) can expose itself as 8 bits per pixel grayscale to the
>>> userspace program. As an example this allows to run DirectFB on the
>>> framebuffer, which is not possible out of the box for 1bpp.
>>>
>>> Also note that if do not set the module parameter at load time
>>> the framebuffer will be 1bpp. So you have to actively set that module
>>> parameter to make the framebuffer pretend to be more than 1bpp.
>>>
>>> In any case I don't cling to that patch, I just thought it was a nice
>>> feature.
>>
>> I'd say that the right fix would be to patch DirectFB, instead of
>> faking that in the kernel.
>>
>> But again, that's probably Tomi's call, not mine.
>
> Right, I'm not thrilled =3D). I don't think it's a good idea to lie to the
> userspace (except when fixing regressions).

I've done the same thing actually in a local patchset and while you are=20
right, we shouldn't lie to userspace, my choice was a performance one.

Right now, in the driver we already have to convert from a regular=20
packed pixel framebuffer, to the format that supports the page layout of=20
the actual chip. Especially on slow hardware, doing the math within this=20
conversion just adds a few multiplications.

Also, there is indeed a lot of userspace out there which doesn't expect=20
single bit displays.

Having said that, what about actually faking grayscale? If we toggle a=20
pixel fast enough (we can achieve 40ish fps right now with a 400 kHz I2C=20
bus) it appears to a user as gray. This can't easily be done in user=20
space, would that be acceptable?

Olliver

>
>   Tomi
>
>

