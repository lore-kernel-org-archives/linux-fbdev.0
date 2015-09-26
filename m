From: David Herrmann <dh.herrmann@gmail.com>
Date: Sat, 26 Sep 2015 18:13:05 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <CANq1E4TN4_NNs32LBcNWeDC2jUtT2TCYHfYeummEC5-TQn7BpA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
 <20150924144621.40e26f0a@free-electrons.com>
 <20150924152312.GV3383@phenom.ffwll.local>
 <CAMuHMdVAO8Ua4G1DRMxTKxqJaAb4xBTQie-nvOkYJ7sox-YCYw@mail.gmail.com>
 <CADnq5_NL5p+sRzOvVpr=JnZ-e-vGtDD-69qapQMKawWtfVRnCw@mail.gmail.com>
 <CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX0Jg9RSu9rm2-trtMCDpS16Zy8VLEnmjvW_vWVWvHdVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Arnaud Patard <apatard@mandriva.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Airlie <airlied@redhat.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi

On Sat, Sep 26, 2015 at 8:01 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Alex,
>
> On Sat, Sep 26, 2015 at 7:07 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Sat, Sep 26, 2015 at 4:28 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Thu, Sep 24, 2015 at 5:23 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>>> On Thu, Sep 24, 2015 at 02:46:21PM +0200, Thomas Petazzoni wrote:
>>>>> Or are there some plans to make the writing of DRM drivers for very
>>>>> simple/trivial devices a bit simpler?
>>>>
>>>> Since years I'm trying to sell someone on implementing support for
>>>> drm_simple_outputs which would collapse the crtc->encoder->connector
>>>> chain into 1 entity. Would be trivial to implement and then trivial to
>>>> write simple drivers on top of that. And besides that drm already has
>>>> piles of reallly simple drivers with just one output and one framebuffer.
>>>>
>>>> There's no reason not to use drm for gfx drivers at all.
>>>
>>> Good to hear that!
>>>
>>> For the (mailing list) record, can you please provide some explicit pointers
>>> to these existing really simple drivers?
>>
>> See the tilcdc, ast, mgag200, and udl drivers for example.
>
> Thanks for the list!
>
> The smallest of these (udl) still counts in at ca. 2800 LoC, while there are
> several fbdev drivers that have less than 200 LoC.
> Granted, these really small ones support a single fixed video mode only, but
> you can write a simple fbdev driver with mode setting in less than 1000 LoC.
>
> I'm sure DRM can do better?

Is counting lines really the level of the discussion to go here?

DRM is a big set of helpers, nothing else. If many trivial, small
drivers share common code, developers are more than welcome to
contribute them to drm-core and help making drivers less complex.

As Daniel mentioned, the connector+encoder+crtc combination is one of
those simplifications that would make sense if more such drivers are
added. Furthermore, the not-yet-merged SimpleDRM driver is one example
how to implement multiple of those dumb-fb drivers with a shared
code-base.

Thanks
David
