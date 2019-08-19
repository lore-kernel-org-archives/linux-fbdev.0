From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 19 Aug 2019 14:02:15 +0000
Subject: Re: [PATCH] efifb: BGRT: Improve efifb_bgrt_sanity_check
Message-Id: <7a2f6fed-c059-6d56-52e5-326f0e44bc6f@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190721131918.10115-1-hdegoede@redhat.com>
 <CGME20190817084100epcas3p15bc1b42c02d8d86969a4a403896d6fee@epcas3p1.samsung.com>
 <a94c96de-16a5-7b52-a964-f8974e867a65@redhat.com>
 <9da1b656-4640-fe16-9def-fe6c069ed39e@samsung.com>
In-Reply-To: <9da1b656-4640-fe16-9def-fe6c069ed39e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Jones <pjones@redhat.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, stable@vger.kernel.org

Hi,

On 19-08-19 16:01, Bartlomiej Zolnierkiewicz wrote:
> 
> On 8/17/19 10:40 AM, Hans de Goede wrote:
>> Hi,
> 
> Hi Hans,
> 
>> On 21-07-19 15:19, Hans de Goede wrote:
>>> For various reasons, at least with x86 EFI firmwares, the xoffset and
>>> yoffset in the BGRT info are not always reliable.
>>>
>>> Extensive testing has shown that when the info is correct, the
>>> BGRT image is always exactly centered horizontally (the yoffset variable
>>> is more variable and not always predictable).
>>>
>>> This commit simplifies / improves the bgrt_sanity_check to simply
>>> check that the BGRT image is exactly centered horizontally and skips
>>> (re)drawing it when it is not.
>>>
>>> This fixes the BGRT image sometimes being drawn in the wrong place.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 88fe4ceb2447 ("efifb: BGRT: Do not copy the boot graphics for non native resolutions")
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> ping? I do not see this one in -next yet, what is the status of this
>> patch?
> Patch queued for v5.4, thanks and sorry for the delay.

No problem, thank you all the maintainer work you do on fbdev.

Regards,

Hans
