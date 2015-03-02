From: Rob Herring <robherring2@gmail.com>
Date: Mon, 02 Mar 2015 23:27:50 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added support for FBIO_WAITFORVSYNC
Message-Id: <CAL_Jsq+XKESfwU+UfkbDYW+-=3F723OjuqEtoBhbQZprWszvvA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1424898082-1522-3-git-send-email-arun.ramamurthy@broadcom.com> <1425312029.3092.1.camel@arm.com>
In-Reply-To: <1425312029.3092.1.camel-5wv7dgnIgG8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

On Mon, Mar 2, 2015 at 10:00 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> On Wed, 2015-02-25 at 21:01 +0000, Arun Ramamurthy wrote:
>> Added ioctl and interrupt handler functions to support FBIO_WAITFORVSYNC
>> Also corrected documentation to make interrupts and interrupt-names
>> optional as they are not required properties.
>
> You may not be aware of this fact, but its the "documentation" what
> defines what properties are required...

Except when docs are wrong. Then dts files win.

>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>0
>> ---
>>  .../devicetree/bindings/video/arm,pl11x.txt        | 11 +--
>>  drivers/video/fbdev/amba-clcd.c                    | 82 ++++++++++++++++++++++
>>  include/linux/amba/clcd.h                          |  4 ++
>>  3 files changed, 89 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
>> index 2262cdb..7d19024 100644
>> --- a/Documentation/devicetree/bindings/video/arm,pl11x.txt
>> +++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
>> @@ -10,14 +10,6 @@ Required properties:
>>
>>  - reg: base address and size of the control registers block
>>
>> -- interrupt-names: either the single entry "combined" representing a
>> -     combined interrupt output (CLCDINTR), or the four entries
>> -     "mbe", "vcomp", "lnbu", "fuf" representing the individual
>> -     CLCDMBEINTR, CLCDVCOMPINTR, CLCDLNBUINTR, CLCDFUFINTR interrupts
>> -
>> -- interrupts: contains an interrupt specifier for each entry in
>> -     interrupt-names
>> -
>>  - clock-names: should contain "clcdclk" and "apb_pclk"
>>
>>  - clocks: contains phandle and clock specifier pairs for the entries
>
> So no, you can't do that.

You can't do the other way around (making optional ones required), but
I think this is okay if the h/w interrupt lines are not physically
connected. However, if it is simply because the driver doesn't use
them, then I agree this should not be changed.

Rob
