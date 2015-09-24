From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2015 15:38:29 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CADnq5_OzbGbXP74gPEf+2-2OxTzeXYA2uoLkkH=O198xYXOTrQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <560414EB.508@gmail.com>
In-Reply-To: <560414EB.508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Austin S Hemmelgarn <ahferroin7@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Arnaud Patard <apatard@mandriva.com>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Thu, Sep 24, 2015 at 11:21 AM, Austin S Hemmelgarn
<ahferroin7@gmail.com> wrote:
> On 2015-09-24 08:46, Thomas Petazzoni wrote:
>>
>> Hello,
>>
>> On Thu, 24 Sep 2015 15:27:01 +0300, Tomi Valkeinen wrote:
>>
>>> fbdev is (more or less) maintained, but it's a deprecated framework. All
>>> new Linux display drivers should be done on DRM.
>>>
>>> So let's not add any more new fbdev drivers.
>>>
>>> I will continue to maintain the current fbdev drivers, and I don't mind
>>> adding some new features to those current drivers, as long as the amount
>>> of code required to add the features stays sensible.
>>>
>>> I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
>>> and the question is what to do with those.
>>>
>>> xgifb was added in 2010, and is still in staging.
>>>
>>> fbtft looks like maybe some kind of framework on top of fbdev, with
>>> fbtft specific subdrivers... I didn't look at it in detail, but my gut
>>> says "never".
>>
>>
>> fbtft mainly drives some very simple I2C-based or SPI-based displays,
>> and DRM is I believe overkill for such displays. Last time I talked
>> with Laurent Pinchart about such drivers, I believe he said that such
>> simple drivers could probably continue to use the fbdev subsystem.
>
> I have to agree, using DRM _really_ doesn't make sense for these, the
> devices in question are (AFAIK) simple I2C or SPI connected frame-buffer
> chips that are hooked up to equally simple TFT displays.  There's no 3d
> acceleration at all from what I can tell, there's _very_ limited 2d
> acceleration, and most of the stuff that the DRM framework provides
> call-backs for would have to be done on the CPU anyway.

Just about all of the acceleration stuff is vendor specific so there's
really nothing you need to provide.  As Daniel noted there are several
drm drivers for simple devices that do not support any kind of 2D or
3D acceleration.  There are no requirements to provide any sort of
acceleration.

Alex
