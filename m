From: Sasha Levin <sashal@kernel.org>
Date: Tue, 01 Oct 2019 18:48:28 +0000
Subject: Re: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <20191001184828.GF8171@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190918060227.6834-1-weh@microsoft.com>
 <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Kelley <mikelley@microsoft.com>
Cc: "info@metux.net" <info@metux.net>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, Wei Hu <weh@microsoft.com>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, Dexuan Cui <decui@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, KY Srinivasan <kys@microsoft.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>

On Fri, Sep 20, 2019 at 05:26:34PM +0000, Michael Kelley wrote:
>From: Michael Kelley <mikelley@microsoft.com>  Sent: Wednesday, September 18, 2019 2:48 PM
>> >
>> > Without deferred IO support, hyperv_fb driver informs the host to refresh
>> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
>> > is screen update or not. This patch supports deferred IO for screens in
>> > graphics mode and also enables the frame buffer on-demand refresh. The
>> > highest refresh rate is still set at 20Hz.
>> >
>> > Currently Hyper-V only takes a physical address from guest as the starting
>> > address of frame buffer. This implies the guest must allocate contiguous
>> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
>> > accept address from MMIO region as frame buffer address. Due to these
>> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
>> > in the guest. This means one more copy of the dirty rectangle inside
>> > guest when doing the on-demand refresh. This can be optimized in the
>> > future with help from host. For now the host performance gain from deferred
>> > IO outweighs the shadow copy impact in the guest.
>> >
>> > Signed-off-by: Wei Hu <weh@microsoft.com>
>
>Sasha -- this patch and one other from Wei Hu for the Hyper-V frame buffer
>driver should be ready.  Both patches affect only the Hyper-V frame buffer
>driver so can go through the Hyper-V tree.  Can you pick these up?  Thx.

I can't get this to apply anywhere, what tree is it based on?

--
Thanks,
Sasha
