From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Jul 2017 17:27:06 +0000
Subject: Re: [PATCH v2 1/2] video/hdmi: Introduce helpers for the HDMI audio infoframe payload
Message-Id: <CAD=FV=V=dG1=Zw_WnX_54ChA1kzVkPqHPWuVU4Qdx88Xx1jSLw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1500376842-6739-1-git-send-email-zyw@rock-chips.com>
 <CAD=FV=WNNa_V2PDyFve5gskpd0K2CTkkWatufWFeLjxrbbk_Vw@mail.gmail.com> <06a4828d-9a37-0918-9f33-43014468045d@rock-chips.com>
In-Reply-To: <06a4828d-9a37-0918-9f33-43014468045d@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Zhong <zyw@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>, Brian Norris <briannorris@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Mark yao <mark.yao@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shashank Sharma <shashank.sharma@intel.com>, Jose Abreu <joabreu@synopsys.com>, Jani Nikula <jani.nikula@intel.com>, Thierry Reding <treding@nvidia.com>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi

On Tue, Jul 18, 2017 at 5:49 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> Hi Doug
>
>
>
> On Tuesday, July 18, 2017 11:16 PM, Doug Anderson wrote:
>>
>> Hi,
>>
>> On Tue, Jul 18, 2017 at 4:20 AM, Chris Zhong <zyw@rock-chips.com> wrote:
>>>
>>> The DP is using the same audio infoframe payload as hdmi, per DP 1.3
>>> spec, but it has a different header. Provide a new interface here,
>>> it just packs the payload.
>>>
>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>> ---
>>>
>>> Changes in v2: None
>>>
>>>   drivers/video/hdmi.c | 66
>>> ++++++++++++++++++++++++++++++++++++++--------------
>>>   include/linux/hdmi.h |  3 ++-
>>>   2 files changed, 50 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
>>> index 1cf907e..e0b041e 100644
>>> --- a/drivers/video/hdmi.c
>>> +++ b/drivers/video/hdmi.c
>>> @@ -240,6 +240,49 @@ int hdmi_audio_infoframe_init(struct
>>> hdmi_audio_infoframe *frame)
>>>   EXPORT_SYMBOL(hdmi_audio_infoframe_init);
>>>
>>>   /**
>>> + * hdmi_audio_infoframe_pack_payload() - write HDMI audio infoframe
>>> payload to
>>> + * binary buffer
>>> + * @frame: HDMI audio infoframe
>>> + * @buffer: destination buffer
>>> + * @size: size of buffer
>>> + *
>>> + * Packs the information contained in the @frame structure into a binary
>>> + * representation that can be written into the corresponding controller
>>> + * registers.
>>> + *
>>> + * Returns 0 on success or a negative error code on failure.
>>> + */
>>> +ssize_t hdmi_audio_infoframe_pack_payload(struct hdmi_audio_infoframe
>>> *frame,
>>> +                                         void *buffer, size_t size)
>>> +{
>>> +       unsigned char channels;
>>> +       u8 *ptr = buffer;
>>> +
>>> +       if (size < frame->length)
>>
>> You also need to return -ENOSPC if (size < 5).  That's because below
>> you always write 5 elements into this array.  I'll leave it to someone
>> with actual DRM experience to say whether they want a #define of some
>> sort here.  Probably they do since someone made a #define for
>> "HDMI_INFOFRAME_HEADER_SIZE".
>>
>> Also: you don't use frame->length anywhere in this function and it
>> doesn't seem to be related with packing the payload.  Seems like you
>> shouldn't check it here.
>
> Actually, I think it should be "if (size < HDMI_AUDIO_INFOFRAME_SIZE)"

Ah, OK.  My main point was that this function needed to make sense on
its own.  ...and the function in your patch writes to [0] through [4]
without actually confirming that there are at least 5 elements.  I'd
be OK with:

  if ((size < frame->length || size < HDMI_AUDIO_INFOFRAME_SIZE)


>>> +               return -ENOSPC;
>>> +
>>> +       memset(buffer, 0, size);
>>
>> I don't think the memset belongs here.  It seems like all this
>> function is doing is setting up ptr[0] through ptr[4] and the memset()
>> doesn't belong with that, does it?
>>
> I think the length of payload is 10 Bytes(DB1~DB10), per audio infoframe
> Format,
> but we only use the front 5 Bytes, the back 5 bytes must be 0. If we take
> the 10
> bytes as a whole, it make sense.

OK, memset() here makes sense with what you say about the frame
needing to be 10 bytes big.

-Doug
