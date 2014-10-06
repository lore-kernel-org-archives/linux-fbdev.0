From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 06 Oct 2014 12:12:08 +0000
Subject: Re: Fixing boot-time hiccups in your display
Message-Id: <54328718.8080306@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4OxRFCvMPMfZhxYNVaxscgAs5AX46YzK-4SU5o6E-iTD1w@mail.gmail.com>	<20141005200150.4379.28017@quantum>	<54324720.1040005@redhat.com>
 <CANq1E4S6g0vv7odeMQytefMKu3VQJyKfDz1t5DCP_gPiBTD+CQ@mail.gmail.com>
In-Reply-To: <CANq1E4S6g0vv7odeMQytefMKu3VQJyKfDz1t5DCP_gPiBTD+CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/06/2014 11:48 AM, David Herrmann wrote:
> Hi
> 
> On Mon, Oct 6, 2014 at 9:39 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/05/2014 10:01 PM, Mike Turquette wrote:
>>> Quoting jonsmirl@gmail.com (2014-10-05 10:09:52)
>>>> I edited the subject line to something more appropriate. This impacts
>>>> a lot of platforms and we should be getting more replies from people
>>>> on the ARM kernel list. This is likely something that deserves a
>>>> Kernel Summit discussion.
>>>
>>> ELC-E and LPC are just around the corner as well. I am attending both. I
>>> suppose some of the others interested in this topic will be present?
>>
>> Having a get together about this there sounds very good. I'm willing to
>> organize this. If you want to attend please reply to this thread (or drop
>> me a personal mail) with when you will be available to attend, then I'll
>> pick a time where hopefully we will all be available, and I'll try to get
>> a room for this, not sure if I'll be able to get a room, if not we will
>> just need to find a quiet spot in the lobby or some such.
>>
>> I'll be present for the entire week too. Monday I'll be at the u-boot
>> mini-conf. Thursday and Friday I'll be at the Linux Kernel Media mini-summit,
>> and Friday afternoon I'll be at the Wayland mini-conf.
>>
>> If this causes scheduling problems, I can miss parts of the media mini-summit,
>> and if I really have to I can maybe miss some parts of the u-boot mini-conf,
>> I cannot walk out of the Wayland track as I'm one of the session leaders
>> there.
> 
> I've been working on the gfx-device hand-over with SimpleDRM for some
> time now. I fully agree with Hans. This has to be a per-device
> hand-over. This works totally fine on x86 already and it should be
> easy to get done for other devices. I have ported SimpleDRM to
> non-VESA drivers and it works just fine, and I'm open to rename it to
> firmware-drm / fwdrm / whatever and add real hardware support.
> simplefb was meant to be hw-agnostic, so I understand that Stephen
> doesn't want to extend it. But before we start adding more fbdev
> drivers, I honestly think we should at least try pushing such a DRM
> driver upstream.
> 
> I will be talking about this at XDC this week, and in the
> Wayland-microconf at Plumbers. I am open for discussion. If people
> want this, I can refresh my sysfb+simpledrm series and send a pull
> request to Dave. He was already willing to merge it, but I wanted to
> cleanup the drm BKL first..

I'm very happy to hear that you're working on getting SimpleDRM ready
for merging into the mainline, I actually wanted to discuss this with
you at XDC and/or Plumbers, but I see that you're already on it, which
is great.

As for the whole discussion about adding resource management /
"real hw support" to the simplefb bindings (which I assume SimpleDRM
will support too), I too am fine with doing a new set of bindings for
this under a different compatible string if that is what people want.

Regards,

Hans
