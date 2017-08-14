From: Michal Simek <michal.simek@xilinx.com>
Date: Mon, 14 Aug 2017 13:50:56 +0000
Subject: Re: [PATCH 2/2] video: fbdev: Enable Xilinx FB for ZynqMP
Message-Id: <994f5b9f-9ba7-ad80-84c4-de1edd9e56d0@xilinx.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b07b143769ed5dccf44e9de4cb0d5c6203b3eca0.1502179820.git.michal.simek@xilinx.com>
 <b10c4df7c5ac10d9290c3b9d2f113fb2f337b110.1502179820.git.michal.simek@xilinx.com>
 <CACRpkdZkppxer7KBdnb+G=7j1tK4EkQjT8ZDf7iPt7AgvQ_hCA@mail.gmail.com>
 <757d86d1-cca5-3a99-a371-a4c7e1c76f9b@xilinx.com>
 <CAKMK7uEKQMRFGdGqrPo-i0Z9ht6-zC6G8hsVW7FKr9cxbpwuPQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEKQMRFGdGqrPo-i0Z9ht6-zC6G8hsVW7FKr9cxbpwuPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Michal Simek <michal.simek@xilinx.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Arnd Bergmann <arnd@arndb.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Paul Burton <paul.burton@imgtec.com>

On 14.8.2017 15:49, Daniel Vetter wrote:
> On Mon, Aug 14, 2017 at 3:46 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 14.8.2017 15:42, Linus Walleij wrote:
>>> On Tue, Aug 8, 2017 at 10:10 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>
>>>> Enable this driver for Xilinx ZynqMP.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>
>>> Not a comment on the patch per se, but I would advice you to look into
>>> migrating the Xilinx frame buffer to DRI/DRM/KMS.
>>>
>>> The recent CMA helpers has made it very simple and focused to write
>>> DRM drivers. See for example drivers/gpu/drm/pl111
>>
>> There is a lot of work done by xilinx in this area gpu/drm/kms. I am
>> trying to upstream what xilinx has in soc tree and this change is there.
>> Maybe in this case it is useless and none is using it but it is there
>> and I don't want to break user. There shouldn't be any technical problem
>> to run this old fb driver in pl on arm64.
> 
> A proper drm kms driver gives you backwards compat for fbdev for free.
> And we're taking in patches to fill feature gaps in our fbdev
> emulation as people hit them. There no reason nowadays at all to merge
> new fbdev native drivers, your users will be taken care of by a drm
> kms driver fully.

You can look at xilinx work in this area.
https://github.com/Xilinx/linux-xlnx
Unfortunately they haven't started to upstream it.

In this particular case I am not aware about anybody who is going to
write new driver for this soft IP.

Thanks,
Michal


