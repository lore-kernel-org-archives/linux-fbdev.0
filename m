From: Sasha Levin <sashal@kernel.org>
Date: Tue, 16 Jun 2020 13:21:30 +0000
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-Id: <20200616132130.GO1931@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <CAPM=9txZpiCGkv3jiBC1F8pTe4A2pqWpQDyjRBXk2roFqw+0+Q@mail.gmail.com>
 <CAPM=9tx4wh-Lk6Dffsdh-7mYvXx+GX2AxhrGqFgyN8-AWJvP6A@mail.gmail.com>
 <20200616105156.GE1718@bug>
In-Reply-To: <20200616105156.GE1718@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, "Ursulin,
 Tvrtko" <tvrtko.ursulin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, haiyangz@microsoft.com, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Chris Wilson <chris@chris-wilson.co.uk>, spronovo@microsoft.com, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, iourit@microsoft.com, "Deucher, Alexander" <alexander.deucher@amd.com>, kys@microsoft.com, wei.liu@kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>

On Tue, Jun 16, 2020 at 12:51:56PM +0200, Pavel Machek wrote:
>> > Having said that, I hit one stumbling block:
>> > "Further, at this time there are no presentation integration. "
>> >
>> > If we upstream this driver as-is into some hyperv specific place, and
>> > you decide to add presentation integration this is more than likely
>> > going to mean you will want to interact with dma-bufs and dma-fences.
>> > If the driver is hidden away in a hyperv place it's likely we won't
>> > even notice that feature landing until it's too late.
>> >
>> > I would like to see a coherent plan for presentation support (not
>> > code, just an architectural diagram), because I think when you
>> > contemplate how that works it will change the picture of how this
>> > driver looks and intergrates into the rest of the Linux graphics
>> > ecosystem.
>> >
>> > As-is I'd rather this didn't land under my purview, since I don't see
>> > the value this adds to the Linux ecosystem at all, and I think it's
>> > important when putting a burden on upstream that you provide some
>> > value.
>>
>> I also have another concern from a legal standpoint I'd rather not
>> review the ioctl part of this. I'd probably request under DRI
>> developers abstain as well.
>>
>> This is a Windows kernel API being smashed into a Linux driver. I don't want to be
>> tainted by knowledge of an API that I've no idea of the legal status of derived works.
>> (it this all covered patent wise under OIN?)
>
>If you can't look onto it, perhaps it is not suitable to merge into kernel...?
>
>What would be legal requirements so this is "safe to look at"? We should really
>require submitter to meet them...

Could you walk me through your view on what the function of the
"Signed-off-by" tag is?

-- 
Thanks,
Sasha
