From: Prasad Joshi <prasadjoshi124@gmail.com>
Date: Mon, 10 Jan 2011 19:57:52 +0000
Subject: Re: A query on frame buffers
Message-Id: <AANLkTikRJvAeDB7JDx+5NrAt8Rct8AvTTY+9LoGTOaqy@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
	<20101227153011.GD3728@dumpdata.com>
	<AANLkTim38gpvun=QwWcnwz719a2NYBcpiSvPYtgR6jMj@mail.gmail.com>
	<1294390835.6019.218.camel@thor.local>
	<20110107165813.GA24320@dumpdata.com>
	<AANLkTik_YENOcUioFFEN73i9ASZ7oZ80FZ_NXt-Ti5RV@mail.gmail.com>
	<20110107192437.GD27871@dumpdata.com>
	<AANLkTim4Cm-3gWwpqa8YmPekoyariRXVrzB6Ayv-zHAi@mail.gmail.com>
	<20110110181716.GA9627@dumpdata.com>
In-Reply-To: <20110110181716.GA9627@dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Hello Konard,

Thanks a lot for your efforts and time.

On Mon, Jan 10, 2011 at 6:17 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>> Tried your patches on Guest machine, it did not help. I am attaching
>> the messages from guest machine.
>
> Ok, then the issue is not with the guest but the IOMMU.
>>
>> > well, what is the DMA code that gets turned on when you run your guest?
>>
>> Looking into the qemu-kvm code to find more information about DMA.
>>
>> > What do you see for 'PCI-DMA' ?
>>
>> > Is it bounce buffer or swiotlb?
>>
>> It is the default configuration. I did not pass swiotlb parameter on
>> kernel boot line.
>
> That is the nop one. So using virt_to_phys to get DMA address.
>
>>
>> The host kernel is booted with iommu=1.
>
> Is this a AMD or Intel chipset?

AMD chipset.

>>
>> > How much memory do you pass to the guest? less than 4GB?
>>
>> root@prasad-kvm:~/VMDisks# qemu-system-x86_64 -hda
>> Ubuntu-10.10-amd64.img -m 1024M -device pci-assign,host:00.0
>>
>> I am passing 1GB memory to the guest machine.
>
> Since you mentioned that you were able to passthrough other PCI devices
> that means the IOMMU is working. This narrows it down.

Yes I could pass-through a network card to VM. I also tried passing
through a old Sound Card to Windows 7 machine. It did not work as
expected, Windows 7 does not have the old drivers.

>
> The big difference between other PCI devices and the graphics card
> is that the graphic card has its own VMM and "radeon_gart_bind" ends
> up programming the bus address (so virt_to_phys of the pages, and
> you could put in a printk there to see what it is) in the graphic
> VMM. This means that when the graphic card is told to fetch the
> writeback data it ends up using the address that was programmed
> in there to look. Here the IOMMU should step in and see "oh, this
> DMA address is for this guest, let me patch it up and actually
> look where this would fall in the guest space. Oh OK, let me use
> this value real value which correspond the guests real value."

It will take some time for me to understand every thing you have written :)

>
> But the IOMMU has a couple of knobs. One of those is the passthrough
> code and the GFX mapping code. The first should be easy to spot (should
> tell you on bootup whether you got that enabled or not), while the other
> looks to be a bunch of workarounds when passing in GFX cards b/c they ..
> well, not sure what, but they look to not work correctly with the IOMMU.

By GFX Mapping,
Do you mean the code that maps VGA frame-buffers to Guest OS?

One more silly question on the frame-buffer mapping.

I was reading a paper on xen vga pass-though. It says "When applying
PCI pass-through, certain memory areas of the physical machine are
mapped to the VM. When the guest OS writes to one of those memory
addresses, Xen will make sure it is actually written at the
appropriate address. This implicates that no other VM is able to make
use of that device. The frame-buffer is mapped to the machine's main
memory at address 0xA0000 to 0xC0000. This memory range must be mapped
to the VM's memory in order for the OS to address the video adapter."

My question is....
In my case, the host machine is using Nvidia graphics card, so the
host frame-buffer memory 0xA0000 to 0xC0000 is being actively used by
host. Now if the ATI card maps it's framebuffer to this same address
wouldn't it cause any problem.

If the the machine has only 1 graphics card those statement make
sense, but I could not understand what will happen when there are two
graphics cards, each connected to different monitor and assigned to
different VM, where would each machines frame-buffer reside in the
host memory.

Does Xen allow passing-though multiple graphics cards, each to different VM?

I am really sorry if those questions does not make any sense.

>
> If you see 'identity map for device' where the device is your GFX
> then that looks to be the bug. It shouldn't set the identity mapping on it.
>

I guess the identity map is used only on the Intel chipset. Here are
msgs on host machine when addition debugging parameter
(amd_iommu_dump) was added.

prasad@prasad-kvm:~$ dmesg | grep -i -e iommu -e dmar -e amd
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.37-rc6+
root=/dev/sda1 ro iommu=1 amd_iommu_dump
[    0.000000] ACPI: SRAT 00000000bfe9f8b0 00108 (v01 AMD    FAM_F_10
00000002 AMD  00000001)
[    0.000000] ACPI: IVRS 00000000bfe9fa00 000D8 (v01  AMD     RD890S
00202031 AMD  00000000)
[    0.000000] ACPI: SSDT 00000000bfe9fae0 00DA4 (v01 A M I  POWERNOW
00000001 AMD  00000001)
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.37-rc6+
root=/dev/sda1 ro iommu=1 amd_iommu_dump
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.012918] Performance Events: AMD PMU driver.
[    0.137960] CPU0: AMD Phenom(tm) II X6 1090T Processor stepping 00
[    0.300011] System has AMD C1E enabled
[    2.680386] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e info 1300
[    2.680441] AMD-Vi:        mmio-addr: 00000000f6000000
[    2.680670] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:00.0 flags: 00
[    2.680726] AMD-Vi:   DEV_RANGE_END		 devid: 00:00.2
[    2.680776] AMD-Vi:   DEV_SELECT			 devid: 00:02.0 flags: 00
[    2.680827] AMD-Vi:   DEV_SELECT			 devid: 07:00.0 flags: 00
[    2.680883] AMD-Vi:   DEV_SELECT			 devid: 00:04.0 flags: 00
[    2.680934] AMD-Vi:   DEV_SELECT			 devid: 06:00.0 flags: 00
[    2.680984] AMD-Vi:   DEV_SELECT			 devid: 00:05.0 flags: 00
[    2.681035] AMD-Vi:   DEV_SELECT			 devid: 05:00.0 flags: 00
[    2.681086] AMD-Vi:   DEV_SELECT			 devid: 00:06.0 flags: 00
[    2.681137] AMD-Vi:   DEV_SELECT			 devid: 04:00.0 flags: 00
[    2.681187] AMD-Vi:   DEV_SELECT			 devid: 00:07.0 flags: 00
[    2.681238] AMD-Vi:   DEV_SELECT			 devid: 03:00.0 flags: 00
[    2.681289] AMD-Vi:   DEV_SELECT			 devid: 00:0b.0 flags: 00
[    2.681340] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 02:00.0 flags: 00
[    2.681391] AMD-Vi:   DEV_RANGE_END		 devid: 02:00.1
[    2.681441] AMD-Vi:   DEV_SELECT			 devid: 00:11.0 flags: 00
[    2.681492] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:12.0 flags: 00
[    2.681543] AMD-Vi:   DEV_RANGE_END		 devid: 00:12.2
[    2.681594] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:13.0 flags: 00
[    2.681645] AMD-Vi:   DEV_RANGE_END		 devid: 00:13.2
[    2.681695] AMD-Vi:   DEV_SELECT			 devid: 00:14.0 flags: d7
[    2.681746] AMD-Vi:   DEV_SELECT			 devid: 00:14.1 flags: 00
[    2.681797] AMD-Vi:   DEV_SELECT			 devid: 00:14.2 flags: 00
[    2.681847] AMD-Vi:   DEV_SELECT			 devid: 00:14.3 flags: 00
[    2.681898] AMD-Vi:   DEV_SELECT			 devid: 00:14.4 flags: 00
[    2.681949] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 01:00.0 flags: 00
devid_to: 00:14.4
[    2.682010] AMD-Vi:   DEV_RANGE_END		 devid: 01:1f.7
[    2.682855] AMD-Vi:   DEV_SELECT			 devid: 00:14.5 flags: 00
[    2.682906] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:16.0 flags: 00
[    2.682957] AMD-Vi:   DEV_RANGE_END		 devid: 00:16.2
[    2.683234] AMD-Vi: Enabling IOMMU at 0000:00:00.2 cap 0x40
[    2.692043] AMD-Vi: Lazy IO/TLB flushing enabled
[    4.360112] ehci_hcd 0000:00:12.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    4.380635] ehci_hcd 0000:00:13.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    4.400658] ehci_hcd 0000:00:16.2: applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    4.811320] powernow-k8: Found 1 AMD Phenom(tm) II X6 1090T
Processor (6 cpu cores) (version 2.20.00)
[   12.349919] EDAC amd64_edac:  Ver: 3.3.0 Dec 21 2010
[   12.350018] EDAC amd64: This node reports that Memory ECC is
currently disabled, set F3x44[22] (0000:00:18.3).
[   12.350030] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
[   12.350044] amd64_edac: probe of 0000:00:18.2 failed with error -22

prasad@prasad-kvm:~$ lspci | grep -i RV
02:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B64
[FireGL V3100 (PCIE)] (rev 80)
02:00.1 Display controller: ATI Technologies Inc RV370 5B64 [FireGL
V3100 (PCIE)] (Secondary) (rev 80)

> Look for 'DMAR GFX' on Google. Might shed some more light.
>

No DMAR for AMD. I think I should have a look at DMAR GFX.

I am really thankful to you for your support.

Thanks and Regards,
Prasad
