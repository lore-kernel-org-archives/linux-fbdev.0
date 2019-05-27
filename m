From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 27 May 2019 10:59:38 +0000
Subject: Re: [PATCH 24/33] Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
Message-Id: <ee90a071-74b4-e9f0-03f9-2e959c333b1f@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
        <20190524085354.27411-25-daniel.vetter@ffwll.ch>
        <20190524131453.e6mefygqyg46jeuf@holly.lan>
        <CGME20190524152910epcas2p30be74545e6e0570ea42cef8e0b5b7da4@epcas2p3.samsung.com>
        <CAKMK7uHWOY97FqyJ6FU1SYTgegKxm2A+R+X6Vjs0_zn1QGN3KQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHWOY97FqyJ6FU1SYTgegKxm2A+R+X6Vjs0_zn1QGN3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, Richard Purdie <rpurdie@rpsys.net>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>


On 5/24/19 5:28 PM, Daniel Vetter wrote:
> Hi Daniel,
> 
> On Fri, May 24, 2019 at 3:14 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>>
>> On Fri, May 24, 2019 at 10:53:45AM +0200, Daniel Vetter wrote:
>>> This reverts commit 994efacdf9a087b52f71e620b58dfa526b0cf928.
>>>
>>> The justification is that if hw blanking fails (i.e. fbops->fb_blank)
>>> fails, then we still want to shut down the backlight. Which is exactly
>>> _not_ what fb_blank() does and so rather inconsistent if we end up
>>> with different behaviour between fbcon and direct fbdev usage. Given
>>> that the entire notifier maze is getting in the way anyway I figured
>>> it's simplest to revert this not well justified commit.
>>>
>>> v2: Add static inline to the dummy version.
>>>
>>> Cc: Richard Purdie <rpurdie@rpsys.net>
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>>> Cc: Jingoo Han <jingoohan1@gmail.com>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Yisheng Xie <ysxie@foxmail.com>
>>> Cc: linux-fbdev@vger.kernel.org
>>
>> Hi Daniel
>>
>> When this goes round again could you add me to the covering letter?
>>
>> I looked at all three of the patches and no objections on my side but
>> I'm reluctant to send out acks because I'm not sure I understood the
>> wider picture well enough.
> 
> It's one of these patch series with some many different subsystems and
> people you can't cc the cover to all of them or mailing lists start
> rejecting you because too many recipients. I tried to spam sufficient
> mailng lists, but I guess not enough.

BTW Not all relevant patches were posted to linux-fbdev and me (i.e.
"[PATCH 05/33] fbdev/sa1100fb: Remove dead code") - I found them on
other mailing lists but it requires some additional work from me to
find / process them. If possible please Cc: linux-fbdev & me on all
patches in the patchset. Thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
