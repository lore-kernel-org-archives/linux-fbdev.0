From: Sasha Levin <sashal@kernel.org>
Date: Tue, 16 Jun 2020 16:00:19 +0000
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-Id: <20200616160019.GQ1931@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <55c57049-1869-7421-aa0f-3ce0b6a133cf@suse.de>
 <20200616105112.GC1718@bug> <20200616132819.GP1931@sasha-vm>
 <20200616144122.GA18447@duo.ucw.cz>
In-Reply-To: <20200616144122.GA18447@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@denx.de>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, tvrtko.ursulin@intel.com, gregkh@linuxfoundation.org, haiyangz@microsoft.com, spronovo@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, linux-fbdev@vger.kernel.org, wei.liu@kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, iourit@microsoft.com, alexander.deucher@amd.com, kys@microsoft.com, Hawking.Zhang@amd.com

On Tue, Jun 16, 2020 at 04:41:22PM +0200, Pavel Machek wrote:
>On Tue 2020-06-16 09:28:19, Sasha Levin wrote:
>> On Tue, Jun 16, 2020 at 12:51:13PM +0200, Pavel Machek wrote:
>> > Hi!
>> >
>> > > > The driver creates the /dev/dxg device, which can be opened by user mode
>> > > > application and handles their ioctls. The IOCTL interface to the driver
>> > > > is defined in dxgkmthk.h (Dxgkrnl Graphics Port Driver ioctl
>> > > > definitions). The interface matches the D3DKMT interface on Windows.
>> > > > Ioctls are implemented in ioctl.c.
>> > >
>> > > Echoing what others said, you're not making a DRM driver. The driver should live outside
>> > > of the DRM code.
>> > >
>> >
>> > Actually, this sounds to me like "this should not be merged into linux kernel". I mean,
>> > we already have DRM API on Linux. We don't want another one, do we?
>>
>> This driver doesn't have any display functionality.
>
>Graphics cards without displays connected are quite common. I may be
>wrong, but I believe we normally handle them using DRM...

This is more similar to the accelerators that live in drivers/misc/
right now.

>> > And at the very least... this misses API docs for /dev/dxg. Code can't really
>> > be reviewed without that.
>>
>> The docs live here: https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/
>
>I don't see "/dev/dxg" being metioned there. Plus, kernel API

Right, this is because this entire codebase is just a pipe to the API
I've linked, it doesn't implement anything new on it's own.

>documentation should really go to Documentation, and be suitably
>licensed.

While I don't mind copying the docs into Documentation, I'm concerned
that over time they will diverge from the docs on the website. This is
similar to how other documentation (such as the virtio spec) live out of
tree to avoid these issues.

w.r.t the licensing, again: this was sent under GPL2 (note the SPDX tags
in each file), and the patches carry a S-O-B by someone who was a
Microsoft employee at the time the patches were sent.

-- 
Thanks,
Sasha
