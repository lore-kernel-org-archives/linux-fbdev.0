From: Prasad Joshi <prasadjoshi124@gmail.com>
Date: Sat, 08 Jan 2011 02:12:31 +0000
Subject: Re: A query on frame buffers
Message-Id: <AANLkTi=K29GE6cyz+VayBOjh8QTcNv3phnSAPxPhSC=L@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
	<20101227153011.GD3728@dumpdata.com>
	<AANLkTim38gpvun=QwWcnwz719a2NYBcpiSvPYtgR6jMj@mail.gmail.com>
	<1294390835.6019.218.camel@thor.local>
	<20110107165813.GA24320@dumpdata.com>
	<AANLkTik_YENOcUioFFEN73i9ASZ7oZ80FZ_NXt-Ti5RV@mail.gmail.com>
	<20110107192437.GD27871@dumpdata.com>
In-Reply-To: <20110107192437.GD27871@dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, Jan 7, 2011 at 7:24 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Fri, Jan 07, 2011 at 05:47:59PM +0000, Prasad Joshi wrote:
>> 2011/1/7 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
>> >> > The errors
>> >> >
>> >> > [ =A0 =A03.778476] [drm:r100_ring_test] *ERROR* radeon: ring test f=
ailed
>> >> > (sracth(0x15E4)=3D0xCAFEDEAD)
>> >> > [ =A0 =A03.781010] [drm:r100_cp_init] *ERROR* radeon: cp isn't work=
ing (-22).
>> >> > [ =A0 =A03.782542] radeon 0000:00:04.0: failled initializing CP (-2=
2).
>> >> > [ =A0 =A03.784006] radeon 0000:00:04.0: Disabling GPU acceleration
>> >> >
>> >> > Seem to be disabling GPU functionality. For now, I am interested in
>> >> > Graphics functionality of the ATI card and not GPGPU functionality.
>> >> >
>> >> > I will appreciate if you can help me with some information on solvi=
ng
>> >> > this problem. Let me know if I should be asking this question on
>> >> > another forum. Please keep me in CC.
>> >>
>> >> Looks like dri-devel material, added to CC.
>> >>
>> >> As a first guess, maybe the system memory pages accessed by the GPU G=
ART
>> >> aren't the same ones intended for this by the VM.
>> >
>> > I actually have patches for that (sorry for the late reply).
>> >
>> > Try:
>> > git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git devel/ttm=
.pci-api.v3

I could access the git repository, but was not able to get those
patches form the repository. Frankly speaking, I don't know how to get
those patches.

>> >
>> > But I am not sure if they would make any difference here. You said
>> > you are using KVM-QEMU - you must also be using an IOMMU? Does the IOM=
MU
>> > give you any errors?
>> >
>>
>> Yes I want to pass-through the ATI Radeon card to VM in KVM. I have
>> enabled the IOMMU support and it works perfectly alright. I tried
>> passing through a network card it worked.
>>
>> Should I try the patch you suggested?
>
> Go for it. I am still at lost why you would see those errors unless..
> well, what is the DMA code that gets turned on when you run your guest?
> What do you see for 'PCI-DMA' ? Is it bounce buffer or swiotlb?
> How much memory do you pass to the guest? less than 4GB?
>
I am trying these things on Uni server, I will let you know the
answers by tomorrow.

Thanks and Regards,
Prasad
