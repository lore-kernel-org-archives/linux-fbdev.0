From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 16 Nov 2015 16:28:24 +0000
Subject: Re: [PATCH] [media] hdmi: added functions for MPEG InfoFrames
Message-Id: <CAFqH_514hjjgPHbP=u1nQ2FPoQe2zLuK5L2R6JcLXjOQdpqZ9g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447526299-4222-1-git-send-email-enric.balletbo@collabora.com>
 <20151116115037.GF31033@ulmo.nvidia.com>
In-Reply-To: <20151116115037.GF31033@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <treding@nvidia.com>
Cc: linux-fbdev@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hans.verkuil@cisco.com>, Martin Bugge <marbugge@cisco.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hello Thierry,

Many thanks for your comments.

2015-11-16 12:50 GMT+01:00 Thierry Reding <treding@nvidia.com>:
> On Sat, Nov 14, 2015 at 07:38:19PM +0100, Enric Balletbo i Serra wrote:
>> The MPEG Source (MS) InfoFrame is in EIA/CEA-861B. It describes aspects of
>> the compressed video stream that were used to produce the uncompressed
>> video.
>>
>> The patch adds functions to work with MPEG InfoFrames.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  drivers/video/hdmi.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/hdmi.h |  24 ++++++++
>>  2 files changed, 180 insertions(+)
>
> According to the CEA specification a source is expected to send this
> type of infoframe once per video frame. I'm curious how you envision
> this to be ensured. Would hardware provide a mechanism to store this
> data and send the infoframe automatically? How would you ensure that
> updates sent to the hardware match the upcoming frame?
>

To be honest I'm not sure if I have the full picture. In the use case
I'm trying there is a hardware mechanism to store the data and send
the infoframe through a "Packet Send Control Register".

>> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> [...]
>> @@ -435,6 +510,8 @@ hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer, size_t size)
>>               length = hdmi_vendor_any_infoframe_pack(&frame->vendor,
>>                                                       buffer, size);
>>               break;
>> +     case HDMI_INFOFRAME_TYPE_MPEG:
>> +             length = hdmi_mpeg_infoframe_pack(&frame->mpeg, buffer, size);
>
> Missing "break;"?
>

Ack.

>> @@ -899,6 +978,41 @@ static void hdmi_audio_infoframe_log(const char *level,
>>                       frame->downmix_inhibit ? "Yes" : "No");
>>  }
>>
>> +static const char *hdmi_mpeg_picture_get_name(enum hdmi_mpeg_picture_type type)
>> +{
>> +     switch (type) {
>> +     case HDMI_MPEG_PICTURE_TYPE_UNKNOWN:
>> +             return "Unknown";
>> +     case HDMI_MPEG_PICTURE_TYPE_I:
>> +             return "Intra-coded picture";
>> +     case HDMI_MPEG_PICTURE_TYPE_B:
>> +             return "Bi-predictive picture";
>> +     case HDMI_MPEG_PICTURE_TYPE_P:
>> +             return "Predicted picture";
>> +     }
>
> I'd have chosen the slightly more canonical "I-Frame", "P-Frame",
> "B-Frame" here, but that's not a strong objection.
>

I don't have any inconvenient to change, are the following names more
canonical ?

       HDMI_MPEG_UNKNOWN_FRAME = 0x00,
       HDMI_MPEG_I_FRAME = 0x01,
       HDMI_MPEG_B_FRAME = 0x02,
       HDMI_MPEG_P_FRAME = 0x03,



>> +     return "Reserved";
>
> There really can't be another value here, so I think this should either
> return NULL or even go as far as let it crash. There should be no way
> for the invalid value to make it this far.
>

Ok.

>> +static int hdmi_mpeg_infoframe_unpack(struct hdmi_mpeg_infoframe *frame,
>> +                                  void *buffer)
>> +{
>> +     u8 *ptr = buffer;
>> +
>> +     if (ptr[0] != HDMI_INFOFRAME_TYPE_MPEG ||
>> +         ptr[1] != 1 ||
>> +         ptr[2] != HDMI_MPEG_INFOFRAME_SIZE) {
>> +             return -EINVAL;
>> +     }
>
> There's no need for the braces here.
>
>> @@ -314,6 +336,7 @@ union hdmi_vendor_any_infoframe {
>>   * @spd: spd infoframe
>>   * @vendor: union of all vendor infoframes
>>   * @audio: audio infoframe
>> + * @mpeg: mpeg infoframe
>
> s/mpeg/MPEG/
>

Ok.

> Thierry

I will send v2 after receiving your feedback again.

Best regards,
Enric
