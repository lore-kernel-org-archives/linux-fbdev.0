From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 13:34:57 +0000
Subject: Re: [PATCH][RESEND] video: hyperv_fb: Fix hibernation for the deferred IO feature
Message-Id: <9fbc3d79-d825-c8be-b9fa-74cc79b30f56@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1578350511-130150-1-git-send-email-decui@microsoft.com>
 <CGME20200111163007eucas1p2e1a121270ec036ba444e3a363d3f7fed@eucas1p2.samsung.com>
 <20200111162957.GK1706@sasha-vm>
In-Reply-To: <20200111162957.GK1706@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, haiyangz@microsoft.com, Dexuan Cui <decui@microsoft.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, weh@microsoft.com, kys@microsoft.com, Alexander.Levin@microsoft.co, mikelley@microsoft.com


On 1/11/20 5:29 PM, Sasha Levin wrote:
> On Mon, Jan 06, 2020 at 02:41:51PM -0800, Dexuan Cui wrote:
>> fb_deferred_io_work() can access the vmbus ringbuffer by calling
>> fbdefio->deferred_io() -> synthvid_deferred_io() -> synthvid_update().
>>
>> Because the vmbus ringbuffer is inaccessible between hvfb_suspend()
>> and hvfb_resume(), we must cancel info->deferred_work before calling
>> vmbus_close() and then reschedule it after we reopen the channel
>> in hvfb_resume().
>>
>> Fixes: a4ddb11d297e ("video: hyperv: hyperv_fb: Support deferred IO for =
Hyper-V frame buffer driver")
>> Fixes: 824946a8b6fb ("video: hyperv_fb: Add the support of hibernation")
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> Reviewed-by: Wei Hu <weh@microsoft.com>
>> ---
>>
>> This is a RESEND of https://protect2.fireeye.com/url?k=A9db9902-f41598d1=
-a9da124d-000babff317b-c1ee475745c278a5&u=3Dhttps://lkml.org/lkml/2019/11/2=
0/73 .
>>
>> The only change is the addition of Wei's Review-ed-by.
>>
>> Please review.
>>
>> If it looks good, Sasha Levin, can you please pick it up via the
>> hyperv/linux.git tree, as you did last time for this driver?
>=20
> Like with the input driver, if the relevant maintainers here are okay
> with this type of patches going through the hyperv tree I'll be happy to
> do it, otherwise I need an explicit ack from them on this patch.

Yes, I'm fine with hyperv_fb driver patches going through hyperv tree.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
