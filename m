From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Fri, 07 Jan 2011 16:58:13 +0000
Subject: Re: A query on frame buffers
Message-Id: <20110107165813.GA24320@dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
	<20101227153011.GD3728@dumpdata.com>
	<AANLkTim38gpvun=QwWcnwz719a2NYBcpiSvPYtgR6jMj@mail.gmail.com>
	<1294390835.6019.218.camel@thor.local>
In-Reply-To: <1294390835.6019.218.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Prasad Joshi <prasadjoshi124@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

> > The errors
> > 
> > [    3.778476] [drm:r100_ring_test] *ERROR* radeon: ring test failed
> > (sracth(0x15E4)=0xCAFEDEAD)
> > [    3.781010] [drm:r100_cp_init] *ERROR* radeon: cp isn't working (-22).
> > [    3.782542] radeon 0000:00:04.0: failled initializing CP (-22).
> > [    3.784006] radeon 0000:00:04.0: Disabling GPU acceleration
> > 
> > Seem to be disabling GPU functionality. For now, I am interested in
> > Graphics functionality of the ATI card and not GPGPU functionality.
> > 
> > I will appreciate if you can help me with some information on solving
> > this problem. Let me know if I should be asking this question on
> > another forum. Please keep me in CC.
> 
> Looks like dri-devel material, added to CC.
> 
> As a first guess, maybe the system memory pages accessed by the GPU GART
> aren't the same ones intended for this by the VM.

I actually have patches for that (sorry for the late reply).

Try:
git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git devel/ttm.pci-api.v3

But I am not sure if they would make any difference here. You said
you are using KVM-QEMU - you must also be using an IOMMU? Does the IOMMU
give you any errors?

