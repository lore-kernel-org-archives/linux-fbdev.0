From: Vladimir Zapolskiy <vz@mleia.com>
Date: Tue, 17 Jan 2017 01:57:33 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <ae187f91-ca9b-c51a-d7cb-14fd99baa434@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <CGME20170112212713epcas2p108e55dc682911981f750f197f30c7d5f@epcas2p1.samsung.com>
 <d1534f4b-e564-d87e-b408-9b7215a90de2@mleia.com>
 <3057141.7Vn8X5ONyT@amdc3058>
In-Reply-To: <3057141.7Vn8X5ONyT@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/13/2017 01:08 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Thursday, January 12, 2017 11:26:14 PM Vladimir Zapolskiy wrote:
>> On 01/12/2017 10:27 AM, Linus Walleij wrote:
>>> On Thu, Jan 12, 2017 at 1:05 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>> On 01/11/2017 05:16 PM, Linus Walleij wrote:
>>>>> On Tue, Jan 10, 2017 at 2:47 PM, Vladimir Murzin
>>>>> <vladimir.murzin@arm.com> wrote:
>>>>>
>>>>>> In another thread Benjamin pointed at patch [1] in drm/kms part for noMMU.
>>>>>>
>>>>>> [1] https://cgit.freedesktop.org/drm/drm-misc/commit/?idba0d98a188cc4ebd8ea54b37d274ec20465e464
>>>>>
>>>>> Problem solved?
>>>>>
>>>>> Vladimir: I do not require in any way that you create a CLCD driver for DRM,
>>>>> I just think it would be very very nice...
>>>>>
>>>>
>>>> I have no other option, this series is unreviewed and thus unlikely it will
>>>> be applied, still a panel PCB on my board needs power management support.
>>>
>>> Hm I can ACK it I guess, but mergeing it into an unmaintained subsystem
>>> is another issue, just not very optimal. 
>>
>> + Bartlomiej
>>
>> Linus, your ack is always more than appreciated.
> 
> +1
> 
>> To all appearance Bartlomiej is a new honoured framebuffer layer maintainer.
>>
>> Bartlomiej, do you have the changes under discussion in your mailbox or
>> should I resend them to you directly for review?
> 
> No need for resend, I picked them from the list and they are on TODO.
> 

Bartlomiej, Linus,

I've noticed that 4/4 requires special attention due to the anticipated
change of devm_get_gpiod_from_child() interface.

If you have any concerns regarding 4/4, please review and consider to
apply the first three clean-up patches in the series, basically I've
achieved my goal of describing a power supply for a panel in DTS by
introducing a DRM driver (see a note below), however support of
"enable-gpios" property mentioned in the "panel-dpi" device tree binding
documentation still is seen as beneficial for the CLCD fbdev driver.

> 
>>> If you get it working on your system I can look into migrating all the old
>>> users to DRM as well.
>>>
>>
>> Sure, I started development of a simple CLCD DRM driver as an own attractive
>> exercise, I'll keep you informed of the progress.
>>

Some updates, now I've developed a simple CLCD DRM driver which works
nicely on one of my boards powered by LPC3250 (has MMU), but I still
have to find enough time and check that the driver works on MMU-less
LPC4357 with the applied DRM core change referenced by Vladimir earlier.

Most probably I'll complete polishing the driver on this weekend and
send it for review on the next week.

One more comment, I've found a discussion when DT support to the CLCD
fbdev driver was added [1], there are some comments about panel device
node and endpoints incompatibility in comparison to the common layout
for Linux-ish DRM devices, and I do confirm that this incompatibility
exists. I have both versions though, but you guess that DRM flavour
is cleaner, and for CLCD DRM driver I'm going to use it.

The legacy DT layout can be supported in the same driver in parallel,
but unfortunately it makes the driver not so cute, and I decide to
drop it in the initial version. It implies that CLCD fbdev users with
the controller and panel descriptions in DT and who want to switch to
CLCD DRM driver should update DTS. Sorry, I know it is inconvenient...

[1] https://patchwork.kernel.org/patch/3777391/

--
With best wishes,
Vladimir

