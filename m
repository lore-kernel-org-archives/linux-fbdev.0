From: Prasad Joshi <prasadjoshi124@gmail.com>
Date: Fri, 07 Jan 2011 02:42:06 +0000
Subject: Re: A query on frame buffers
Message-Id: <AANLkTim38gpvun=QwWcnwz719a2NYBcpiSvPYtgR6jMj@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
In-Reply-To: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Dec 27, 2010 at 3:30 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Tue, Dec 21, 2010 at 04:51:04AM +0000, Prasad Joshi wrote:
>> Hello All,
>>
>> This is probably my first mail on this mailing list. I am working on a
>> university project on Nvidia or any GPU Pass-through in KVM. I have a
>
> You picking the hard ones first, eh? I would suggest you do Intel
> or ATI as they have actually posted patches for this.

Thanks a lot for your reply.

Yes indeed, I started with the ATI Radeon RV370 card. Passing the
Nvidia card is the ultimate aim of the project.

>
>> question related to framebuffer.
>>
>> I was reading few documents on XEN VGA pass-through, the document says
>> the first step for pass-through is mapping the framebuffers in the VM
>> at specific address, specifically speaking 0xA0000 till 0xC0000.
>
> I would suggest you look at the code - there have been some patches
> posted by AMD engineers on xen-devel for this.
>

Yes I am looking at those patches as well, including some research
papers on the same topic.

Here is what I have tried so far.
I have 2 graphics cards connected to my machine
1. Nvidia: This is being used by host machine.
2. ATI: Want to pass-through this card to the VM.

I tried to pass-through the ATI card to VM. First, there was a problem
with ROM BIOS. Then I passed a correct ROM BIOS to QEMU-KVM. Now when
I start the VM with ATI card in pass-through mode.

I see some garbage output on the monitor attached to the ATI card. I
also saw following messages in the system log.

[    2.162294] [drm] Initialized drm 1.1.0 20060810
[    2.459594] [drm] radeon defaulting to kernel modesetting.
[    2.459596] [drm] radeon kernel modesetting enabled.
[    2.766698] radeon 0000:00:04.0: PCI INT A -> Link[LNKD] -> GSI 10
(level, high) -> IRQ 10
[    2.766734] radeon 0000:00:04.0: setting latency timer to 64
[    2.783512] [drm] initializing kernel modesetting (RV380 0x1002:0x5B64).
[    2.792407] [drm] register mmio base: 0x40000000
[    2.792408] [drm] register mmio size: 65536
[    2.797177] [drm] Generation 2 PCI interface, using max accessible memory
[    2.797275] radeon 0000:00:04.0: VRAM: 128M 0x00000000F8000000 -
0x00000000FFFFFFFF (128M used)
[    2.797284] radeon 0000:00:04.0: GTT: 512M 0x00000000D8000000 -
0x00000000F7FFFFFF
[    2.798370] radeon 0000:00:04.0: irq 40 for MSI/MSI-X
[    2.870703] radeon 0000:00:04.0: radeon: using MSI.
[    3.151162] [drm] radeon: irq initialized.
[    3.151539] [drm] Detected VRAM RAM8M, BAR8M
[    3.151541] [drm] RAM width 128bits DDR
[    3.151610] [drm] radeon: 128M of VRAM memory ready
[    3.151611] [drm] radeon: 512M of GTT memory ready.
[    3.151627] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    3.152701] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
[    3.544943] [drm] PCIE GART of 512M enabled (table at 0xF8040000).
[    3.548479] radeon 0000:00:04.0: WB enabled
[    3.549020] [drm] Loading R300 Microcode
[    3.554278] [drm] radeon: ring at 0x00000000D8001000
[    3.778476] [drm:r100_ring_test] *ERROR* radeon: ring test failed
(sracth(0x15E4)=0xCAFEDEAD)
[    3.781010] [drm:r100_cp_init] *ERROR* radeon: cp isn't working (-22).
[    3.782542] radeon 0000:00:04.0: failled initializing CP (-22).
[    3.784006] radeon 0000:00:04.0: Disabling GPU acceleration
[    3.793709] [drm] radeon: cp finalized
[    3.834875] radeon 0000:00:04.0: ffff8800320b4c00 unpin not necessary
[    3.841759] [drm] Radeon Display Connectors
[    3.841766] [drm] Connector 0:
[    3.841771] [drm]   VGA
[    3.841777] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[    3.841781] [drm]   Encoders:
[    3.841785] [drm]     CRT1: INTERNAL_DAC1
[    3.841788] [drm] Connector 1:
[    3.841791] [drm]   DVI-I
[    3.841794] [drm]   HPD1
[    3.841799] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[    3.841803] [drm]   Encoders:
[    3.841806] [drm]     CRT2: INTERNAL_DAC2
[    3.841809] [drm]     DFP1: INTERNAL_TMDS1
[    6.158753] [drm] fb mappable at 0xF8040000
[    6.158756] [drm] vram apper at 0xF8000000
[    6.158757] [drm] size 5242880
[    6.158758] [drm] fb depth is 24
[    6.158759] [drm]    pitch is 5120
[   13.914196] fb0: radeondrmfb frame buffer device
[   13.914198] drm: registered panic notifier
[   13.914683] [drm] Initialized radeon 2.7.0 20080528 for
0000:00:04.0 on minor 0

The errors

[    3.778476] [drm:r100_ring_test] *ERROR* radeon: ring test failed
(sracth(0x15E4)=0xCAFEDEAD)
[    3.781010] [drm:r100_cp_init] *ERROR* radeon: cp isn't working (-22).
[    3.782542] radeon 0000:00:04.0: failled initializing CP (-22).
[    3.784006] radeon 0000:00:04.0: Disabling GPU acceleration

Seem to be disabling GPU functionality. For now, I am interested in
Graphics functionality of the ATI card and not GPGPU functionality.

I will appreciate if you can help me with some information on solving
this problem. Let me know if I should be asking this question on
another forum. Please keep me in CC.

Thanks and Regards,
Prasad
