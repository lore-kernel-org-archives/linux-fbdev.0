From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 23 Sep 2013 16:03:18 +0000
Subject: Re: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <52406646.709@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
 <52376180.1090001@wwwdotorg.org> <1379435799.9205.16.camel@hornet>
 <5238CBE9.2060800@wwwdotorg.org> <1379522363.9244.12.camel@hornet>
In-Reply-To: <1379522363.9244.12.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/18/2013 10:39 AM, Pawel Moll wrote:
> On Tue, 2013-09-17 at 22:34 +0100, Stephen Warren wrote:
>>> On Tue, 2013-09-17 at 17:36 +0100, Pawel Moll wrote:
>>>> On Mon, 2013-09-16 at 20:52 +0100, Stephen Warren wrote:
>>>>>> +- arm,pl11x,panel-data-pads: array of 24 cells, each of them describing
>>>>>> +				a function of one of the CLD pads,
>>>>>> +				starting from 0 up to 23; each pad can
>>>>>> +				be described by one of the following values:
>>>>>> +	- 0: reserved (not connected)
>>>>>> +	- 0x100-0x107: color upper STN panel data 0 to 7
>>>>> ...
>>>>>
>>>>> I assume those are the raw values that go into the HW?
>>>
>>> No, they can be considered "labels", defining the way pads are used
>>> (wired). Then, basing on this information, the driver is configuring the
>>> cell, eg. selecting STN or TFT mode (thus switching the output between
>>> panel formatter and raw RGB data source).
>>
>> Oh, why not just use the raw values from the HW registers for this?
> 
> How do you mean? Based on the the way the "LCD data" lines are wired up,
> the driver has to decide whether to select STN (LCDControl &= ~(1<<5))
> or TFT mode (LCDControl |= 1<<5), then figures out what memory pixel
> formats are possible (based on this will set LCDControl[3..1] in
> runtime, depending on the mode selected by the user). There isn't a
> separate register as such configuring output pads. It's just the way
> they can used depends on the way they're wired up.

It sounds like you could just put LCDControl & 0x2e in the DT rather
than using values such as 0x100..0x107, which don't appear to match the
register format you mentioned above.

