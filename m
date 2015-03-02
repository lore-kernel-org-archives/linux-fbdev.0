From: Rob Herring <robherring2@gmail.com>
Date: Mon, 02 Mar 2015 23:22:02 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added support for FBIOPAN_DISPLAY and virtual y resolution
Message-Id: <CAL_JsqKMP4JxQ-Q5V1skcaKPdhC4v-joOrNyn++tMfat8arMKA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1424898082-1522-2-git-send-email-arun.ramamurthy@broadcom.com>
 <1425312509.3092.7.camel@arm.com> <20150302161122.GP8656@n2100.arm.linux.org.uk>
 <54F4B57F.3030306@broadcom.com>
In-Reply-To: <54F4B57F.3030306-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

On Mon, Mar 2, 2015 at 1:09 PM, Arun Ramamurthy
<arun.ramamurthy@broadcom.com> wrote:
>
>
> On 15-03-02 08:11 AM, Russell King - ARM Linux wrote:
>>
>> On Mon, Mar 02, 2015 at 04:08:29PM +0000, Pawel Moll wrote:
>>>
>>> I'm not sure about this... The word "virtual" never works well with
>>> device tree nodes defined as "hardware description".
>>>
>>> I understand what you're doing, but adding this property to the display
>>> controller's node doesn't sound right. How does this describe hardware?
>>> If anywhere, it's more like a job for the panel node?
>>
>>
> I see what you are saying Pawel, I can follow Russell's recommendation of
> adding a RAM size node called max-memory-available or something similar

We've already got a binding for reserved memory regions for this
purpose. And there is also simplefb binding.

Rob
