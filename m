From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Sun, 27 Sep 2015 16:08:58 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CACvgo50PpEG3CVBQdMuXEg9TG+mY_Kxnp3OOHMdZ-hxr3Mok5Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
	<5607EA9C.7040909@tronnes.org>
In-Reply-To: <5607EA9C.7040909@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi all,

On 27 September 2015 at 14:09, Noralf Tr=C3=B8nnes <noralf@tronnes.org> wro=
te:
>
> Den 24.09.2015 14:27, skrev Tomi Valkeinen:
>>
>> Hi all,
>>
>> fbdev is (more or less) maintained, but it's a deprecated framework. All
>> new Linux display drivers should be done on DRM.
>>
>> So let's not add any more new fbdev drivers.
>>
>> I will continue to maintain the current fbdev drivers, and I don't mind
>> adding some new features to those current drivers, as long as the amount
>> of code required to add the features stays sensible.
>>
>> I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
>> and the question is what to do with those.
>>
>> xgifb was added in 2010, and is still in staging.
>>
>> fbtft looks like maybe some kind of framework on top of fbdev, with
>> fbtft specific subdrivers... I didn't look at it in detail, but my gut
>> says "never".
>
>
> I have done some work [1] to try and make fbtft look more like the rest
> of the kernel (doc [2]), but that work will result in an almost complete
> rewrite of fbtft.
From a very quick skim fbtft looks pretty much like drm/panel. We
presently have 30+ 'simple' dsi panels, plus a bunch of spi ones. Have
you had a look at these ?

Cheers,
Emil
