From: Vladimir Zapolskiy <vz@mleia.com>
Date: Thu, 12 Jan 2017 21:26:14 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <d1534f4b-e564-d87e-b408-9b7215a90de2@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <CACRpkdZE6VgJA27+Wh=Gxd7yOXpLMyT7yCB2PYA36y0gvosHFQ@mail.gmail.com>
 <20170102142228.GI14217@n2100.armlinux.org.uk>
 <252ad888-fa9d-695a-58ed-46806e4374fd@mleia.com>
 <50499352-fa14-64c4-1a74-db4827757a2d@arm.com>
 <CACRpkdYv87Tmp6i-vccVmtVD5NDk2y1=62sgP7VQgWctC+t3Tg@mail.gmail.com>
 <330598fa-d331-3695-b0a2-3590059e2be4@mleia.com>
 <CACRpkdZdzGq8Atk2YMa23ZLRjnVGYBYQjEzu_q__s-yYkWg5hA@mail.gmail.com>
In-Reply-To: <CACRpkdZdzGq8Atk2YMa23ZLRjnVGYBYQjEzu_q__s-yYkWg5hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/12/2017 10:27 AM, Linus Walleij wrote:
> On Thu, Jan 12, 2017 at 1:05 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>> On 01/11/2017 05:16 PM, Linus Walleij wrote:
>>> On Tue, Jan 10, 2017 at 2:47 PM, Vladimir Murzin
>>> <vladimir.murzin@arm.com> wrote:
>>>
>>>> In another thread Benjamin pointed at patch [1] in drm/kms part for noMMU.
>>>>
>>>> [1] https://cgit.freedesktop.org/drm/drm-misc/commit/?idba0d98a188cc4ebd8ea54b37d274ec20465e464
>>>
>>> Problem solved?
>>>
>>> Vladimir: I do not require in any way that you create a CLCD driver for DRM,
>>> I just think it would be very very nice...
>>>
>>
>> I have no other option, this series is unreviewed and thus unlikely it will
>> be applied, still a panel PCB on my board needs power management support.
> 
> Hm I can ACK it I guess, but mergeing it into an unmaintained subsystem
> is another issue, just not very optimal. 

+ Bartlomiej

Linus, your ack is always more than appreciated.

To all appearance Bartlomiej is a new honoured framebuffer layer maintainer.

Bartlomiej, do you have the changes under discussion in your mailbox or
should I resend them to you directly for review?

> If you get it working on your system I can look into migrating all the old
> users to DRM as well.
> 

Sure, I started development of a simple CLCD DRM driver as an own attractive
exercise, I'll keep you informed of the progress.

--
With best wishes,
Vladimir
