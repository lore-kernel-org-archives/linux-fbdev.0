From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 02 Oct 2019 08:09:41 +0000
Subject: RE: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <PU1P153MB0169811097EA55DF795888B2BF9C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190918060227.6834-1-weh@microsoft.com>
 <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
 <20191001184828.GF8171@sasha-vm>
In-Reply-To: <20191001184828.GF8171@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>, Michael Kelley <mikelley@microsoft.com>
Cc: Wei Hu <weh@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Tuesday, October 1, 2019 11:48 AM
> 
> On Fri, Sep 20, 2019 at 05:26:34PM +0000, Michael Kelley wrote:
> >From: Michael Kelley <mikelley@microsoft.com>  Sent: Wednesday,
> September 18, 2019 2:48 PM
> >> >
> >> > Without deferred IO support, hyperv_fb driver informs the host to refresh
> >> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
> >> > is screen update or not. This patch supports deferred IO for screens in
> >> > graphics mode and also enables the frame buffer on-demand refresh. The
> >> > highest refresh rate is still set at 20Hz.
> >> >
> >> > Currently Hyper-V only takes a physical address from guest as the starting
> >> > address of frame buffer. This implies the guest must allocate contiguous
> >> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> >> > accept address from MMIO region as frame buffer address. Due to these
> >> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
> >> > in the guest. This means one more copy of the dirty rectangle inside
> >> > guest when doing the on-demand refresh. This can be optimized in the
> >> > future with help from host. For now the host performance gain from
> deferred
> >> > IO outweighs the shadow copy impact in the guest.
> >> >
> >> > Signed-off-by: Wei Hu <weh@microsoft.com>
> >
> >Sasha -- this patch and one other from Wei Hu for the Hyper-V frame buffer
> >driver should be ready.  Both patches affect only the Hyper-V frame buffer
> >driver so can go through the Hyper-V tree.  Can you pick these up?  Thx.
> 
> I can't get this to apply anywhere, what tree is it based on?
> 
> --
> Thanks,
> Sasha

Hi Sasha,
Today's hyperv/linux.git's hyperv-next branch's top commit is
    48b72a2697d5 ("hv_netvsc: Add the support of hibernation").

Please pick up two patches from Wei Hu:
#1: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
#2: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver

I can apply the 2 patches on the hyperv-next branch (the top commit is 48b72a2697d5):

[decui@localhost linux]$ patch -p1 < 1.diff
patching file drivers/video/fbdev/hyperv_fb.c
Hunk #2 succeeded at 53 (offset 1 line).
Hunk #3 succeeded at 95 (offset 1 line).
Hunk #4 succeeded at 124 (offset 1 line).
Hunk #5 succeeded at 222 (offset 1 line).
Hunk #6 succeeded at 262 (offset 2 lines).
Hunk #7 succeeded at 394 (offset 2 lines).
Hunk #8 succeeded at 441 (offset 2 lines).
Hunk #9 succeeded at 480 (offset 2 lines).
Hunk #10 succeeded at 558 (offset 2 lines).
Hunk #11 succeeded at 590 (offset 2 lines).
Hunk #12 succeeded at 785 (offset 2 lines).
Hunk #13 succeeded at 823 (offset 2 lines).

[decui@localhost linux]$ patch -p1 < 2.diff
patching file drivers/video/fbdev/Kconfig
Hunk #1 succeeded at 2214 (offset -27 lines).
patching file drivers/video/fbdev/hyperv_fb.c
Hunk #1 succeeded at 238 (offset 1 line).
Hunk #2 succeeded at 259 (offset 2 lines).
Hunk #3 succeeded at 277 (offset 2 lines).
Hunk #4 succeeded at 364 (offset 2 lines).
Hunk #5 succeeded at 692 (offset 2 lines).
Hunk #6 succeeded at 702 (offset 2 lines).
Hunk #7 succeeded at 719 (offset 2 lines).
Hunk #8 succeeded at 801 (offset 2 lines).
Hunk #9 succeeded at 863 (offset 2 lines).
Hunk #10 succeeded at 876 (offset 2 lines).
Hunk #11 succeeded at 889 (offset 2 lines).
Hunk #12 succeeded at 951 (offset 2 lines).
Hunk #13 succeeded at 988 (offset 2 lines).
Hunk #14 succeeded at 1007 (offset 2 lines).
Hunk #15 succeeded at 1041 (offset 2 lines).

Thanks,
-- Dexuan
