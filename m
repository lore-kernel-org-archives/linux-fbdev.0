From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Fri, 07 Jan 2011 19:24:37 +0000
Subject: Re: A query on frame buffers
Message-Id: <20110107192437.GD27871@dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
	<20101227153011.GD3728@dumpdata.com>
	<AANLkTim38gpvun=QwWcnwz719a2NYBcpiSvPYtgR6jMj@mail.gmail.com>
	<1294390835.6019.218.camel@thor.local>
	<20110107165813.GA24320@dumpdata.com>
	<AANLkTik_YENOcUioFFEN73i9ASZ7oZ80FZ_NXt-Ti5RV@mail.gmail.com>
In-Reply-To: <AANLkTik_YENOcUioFFEN73i9ASZ7oZ80FZ_NXt-Ti5RV@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Prasad Joshi <prasadjoshi124@gmail.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, Jan 07, 2011 at 05:47:59PM +0000, Prasad Joshi wrote:
> 2011/1/7 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
> >> > The errors
> >> >
> >> > [ =A0 =A03.778476] [drm:r100_ring_test] *ERROR* radeon: ring test fa=
iled
> >> > (sracth(0x15E4)=3D0xCAFEDEAD)
> >> > [ =A0 =A03.781010] [drm:r100_cp_init] *ERROR* radeon: cp isn't worki=
ng (-22).
> >> > [ =A0 =A03.782542] radeon 0000:00:04.0: failled initializing CP (-22=
).
> >> > [ =A0 =A03.784006] radeon 0000:00:04.0: Disabling GPU acceleration
> >> >
> >> > Seem to be disabling GPU functionality. For now, I am interested in
> >> > Graphics functionality of the ATI card and not GPGPU functionality.
> >> >
> >> > I will appreciate if you can help me with some information on solving
> >> > this problem. Let me know if I should be asking this question on
> >> > another forum. Please keep me in CC.
> >>
> >> Looks like dri-devel material, added to CC.
> >>
> >> As a first guess, maybe the system memory pages accessed by the GPU GA=
RT
> >> aren't the same ones intended for this by the VM.
> >
> > I actually have patches for that (sorry for the late reply).
> >
> > Try:
> > git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git devel/ttm.=
pci-api.v3
> >
> > But I am not sure if they would make any difference here. You said
> > you are using KVM-QEMU - you must also be using an IOMMU? Does the IOMMU
> > give you any errors?
> >
>=20
> Yes I want to pass-through the ATI Radeon card to VM in KVM. I have
> enabled the IOMMU support and it works perfectly alright. I tried
> passing through a network card it worked.
>=20
> Should I try the patch you suggested?

Go for it. I am still at lost why you would see those errors unless..
well, what is the DMA code that gets turned on when you run your guest?
What do you see for 'PCI-DMA' ? Is it bounce buffer or swiotlb?
How much memory do you pass to the guest? less than 4GB?
