From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Jan 2011 17:10:03 +0000
Subject: Re: A query on frame buffers
Message-Id: <AANLkTik4a8-i_fk8O+-1zmYasvUo4=+2mjG1Ez6=uFk_@mail.gmail.com>
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
	<AANLkTikRJvAeDB7JDx+5NrAt8Rct8AvTTY+9LoGTOaqy@mail.gmail.com>
	<20110110202451.GA14293@dumpdata.com>
	<AANLkTimJ=WwnCtUNzQcxwHgHZp_bqQwt8YfiXm=g0gv-@mail.gmail.com>
In-Reply-To: <AANLkTimJ=WwnCtUNzQcxwHgHZp_bqQwt8YfiXm=g0gv-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Prasad Joshi <prasadjoshi124@gmail.com>
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On Tue, Jan 11, 2011 at 11:58 AM, Prasad Joshi <prasadjoshi124@gmail.com> w=
rote:
> On Mon, Jan 10, 2011 at 8:24 PM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>>> AMD chipset.
>>
>> They don't seem to have have any errata's for this GFX business.
>> But they do have a passthrough mode - hopefull that is not what you have
>> passed in?
>>
>>> > Since you mentioned that you were able to passthrough other PCI devic=
es
>>> > that means the IOMMU is working. This narrows it down.
>>>
>>> Yes I could pass-through a network card to VM. I also tried passing
>>> through a old Sound Card to Windows 7 machine. It did not work as
>>> expected, Windows 7 does not have the old drivers.
>>
>> Heh.
>>>
>>> >
>>> > The big difference between other PCI devices and the graphics card
>>> > is that the graphic card has its own VMM and "radeon_gart_bind" ends
>>> > up programming the bus address (so virt_to_phys of the pages, and
>>> > you could put in a printk there to see what it is) in the graphic
>>> > VMM. This means that when the graphic card is told to fetch the
>>> > writeback data it ends up using the address that was programmed
>>> > in there to look. Here the IOMMU should step in and see "oh, this
>>> > DMA address is for this guest, let me patch it up and actually
>>> > look where this would fall in the guest space. Oh OK, let me use
>>> > this value real value which correspond the guests real value."
>>>
>>> It will take some time for me to understand every thing you have writte=
n :)
>>
>> Ok. Ping me if you have some questions. Reading this might
>> help (or confuse you more): http://wiki.xensource.com/xenwiki/XenPVOPSDRM
>>
>>>
>>> >
>>> > But the IOMMU has a couple of knobs. One of those is the passthrough
>>> > code and the GFX mapping code. The first should be easy to spot (shou=
ld
>>> > tell you on bootup whether you got that enabled or not), while the ot=
her
>>> > looks to be a bunch of workarounds when passing in GFX cards b/c they=
 ..
>>> > well, not sure what, but they look to not work correctly with the IOM=
MU.
>>>
>>> By GFX Mapping,
>>> Do you mean the code that maps VGA frame-buffers to Guest OS?
>>
>> No. It is the IOMMU kernel code that checks to see if this is a GFX
>> card and if so does something fancy. But the workarounds for this appear
>> to be exclusive to Intel chipset so you shouldn't hit any.
>>
>>>
>>> One more silly question on the frame-buffer mapping.
>>>
>>> I was reading a paper on xen vga pass-though. It says "When applying
>>> PCI pass-through, certain memory areas of the physical machine are
>>> mapped to the VM. When the guest OS writes to one of those memory
>>> addresses, Xen will make sure it is actually written at the
>>> appropriate address. This implicates that no other VM is able to make
>>> use of that device. The frame-buffer is mapped to the machine's main
>>> memory at address 0xA0000 to 0xC0000. This memory range must be mapped
>>> to the VM's memory in order for the OS to address the video adapter."
>> <nods>
>>>
>>> My question is....
>>> In my case, the host machine is using Nvidia graphics card, so the
>>> host frame-buffer memory 0xA0000 to 0xC0000 is being actively used by
>>> host. Now if the ATI card maps it's framebuffer to this same address
>>> wouldn't it cause any problem.
>>
>> Ah, but it does not. The first card that is called by the BIOS (so your
>> motherboard BIOS) sets itself up to use that memory. The other card has
>> to wait. Keep in mind that the A0000 to C0000 is the old style VGA
>> framebuffer (80x25) or if you program the card properly it can do
>> VESA graphics, but nothing else. Usually the guest gets a Cirrus Logic
>> video card passed in which sets this device up (and touching that
>> area in the guest ends up in VNC window or SDL window).
>>
>> Anyhow back to your host..
>> If you grep in your kernel log you should see something like:
>> [drm] fb mappable at 0xE0142000
>>
>> This is the framebuffer address.
>>>
>>> If the the machine has only 1 graphics card those statement make
>>> sense, but I could not understand what will happen when there are two
>>> graphics cards, each connected to different monitor and assigned to
>>> different VM, where would each machines frame-buffer reside in the
>>> host memory.
>>
>> Check the kernel log. Usually it is also the first BAR in the pci device.
>>
>>>
>>> Does Xen allow passing-though multiple graphics cards, each to differen=
t VM?
>>
>> Yes (with some patches posted by the AMD and Intel folks)..
>> (look for threads that have some GFX or Radeon or something like that in=
 its title).
>>>
>>> >
>>> > If you see 'identity map for device' where the device is your GFX
>>> > then that looks to be the bug. It shouldn't set the identity mapping =
on it.
>>> >
>>>
>>> I guess the identity map is used only on the Intel chipset. Here are
>>> msgs on host machine when addition debugging parameter
>>> (amd_iommu_dump) was added.
>>>
>>> prasad@prasad-kvm:~$ dmesg | grep -i -e iommu -e dmar -e amd
>>> [ =A0 =A00.000000] Command line: BOOT_IMAGE=3D/vmlinuz-2.6.37-rc6+
>>> root=3D/dev/sda1 ro iommu=3D1 amd_iommu_dump
>>> [ =A0 =A00.000000] ACPI: SRAT 00000000bfe9f8b0 00108 (v01 AMD =A0 =A0FA=
M_F_10
>>> 00000002 AMD =A000000001)
>>> [ =A0 =A00.000000] ACPI: IVRS 00000000bfe9fa00 000D8 (v01 =A0AMD =A0 =
=A0 RD890S
>>> 00202031 AMD =A000000000)
>>> [ =A0 =A00.000000] ACPI: SSDT 00000000bfe9fae0 00DA4 (v01 A M I =A0POWE=
RNOW
>>> 00000001 AMD =A000000001)
>>> [ =A0 =A00.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-2.6.37-rc=
6+
>>> root=3D/dev/sda1 ro iommu=3D1 amd_iommu_dump
>>> [ =A0 =A00.000000] Please enable the IOMMU option in the BIOS setup
>>> [ =A0 =A00.012918] Performance Events: AMD PMU driver.
>>> [ =A0 =A00.137960] CPU0: AMD Phenom(tm) II X6 1090T Processor stepping =
00
>>> [ =A0 =A00.300011] System has AMD C1E enabled
>>> [ =A0 =A02.680386] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e i=
nfo 1300
>>> [ =A0 =A02.680441] AMD-Vi: =A0 =A0 =A0 =A0mmio-addr: 00000000f6000000
>>> [ =A0 =A02.680670] AMD-Vi: =A0 DEV_SELECT_RANGE_START =A0 =A0 =A0 =A0de=
vid: 00:00.0 flags: 00
>>> [ =A0 =A02.680726] AMD-Vi: =A0 DEV_RANGE_END =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 devid: 00:00.2
>>> [ =A0 =A02.680776] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:02.0 flags: 00
>>> [ =A0 =A02.680827] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 07:00.0 flags: 00
>>> [ =A0 =A02.680883] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:04.0 flags: 00
>>> [ =A0 =A02.680934] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 06:00.0 flags: 00
>>> [ =A0 =A02.680984] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:05.0 flags: 00
>>> [ =A0 =A02.681035] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 05:00.0 flags: 00
>>> [ =A0 =A02.681086] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:06.0 flags: 00
>>> [ =A0 =A02.681137] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 04:00.0 flags: 00
>>> [ =A0 =A02.681187] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:07.0 flags: 00
>>> [ =A0 =A02.681238] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 03:00.0 flags: 00
>>> [ =A0 =A02.681289] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:0b.0 flags: 00
>>> [ =A0 =A02.681340] AMD-Vi: =A0 DEV_SELECT_RANGE_START =A0 =A0 =A0 =A0de=
vid: 02:00.0 flags: 00
>>> [ =A0 =A02.681391] AMD-Vi: =A0 DEV_RANGE_END =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 devid: 02:00.1
>>> [ =A0 =A02.681441] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:11.0 flags: 00
>>> [ =A0 =A02.681492] AMD-Vi: =A0 DEV_SELECT_RANGE_START =A0 =A0 =A0 =A0de=
vid: 00:12.0 flags: 00
>>> [ =A0 =A02.681543] AMD-Vi: =A0 DEV_RANGE_END =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 devid: 00:12.2
>>> [ =A0 =A02.681594] AMD-Vi: =A0 DEV_SELECT_RANGE_START =A0 =A0 =A0 =A0de=
vid: 00:13.0 flags: 00
>>> [ =A0 =A02.681645] AMD-Vi: =A0 DEV_RANGE_END =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 devid: 00:13.2
>>> [ =A0 =A02.681695] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:14.0 flags: d7
>>> [ =A0 =A02.681746] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:14.1 flags: 00
>>> [ =A0 =A02.681797] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:14.2 flags: 00
>>> [ =A0 =A02.681847] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:14.3 flags: 00
>>> [ =A0 =A02.681898] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:14.4 flags: 00
>>> [ =A0 =A02.681949] AMD-Vi: =A0 DEV_ALIAS_RANGE =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 devid: 01:00.0 flags: 00
>>> devid_to: 00:14.4
>>> [ =A0 =A02.682010] AMD-Vi: =A0 DEV_RANGE_END =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 devid: 01:1f.7
>>> [ =A0 =A02.682855] AMD-Vi: =A0 DEV_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0devid: 00:14.5 flags: 00
>>> [ =A0 =A02.682906] AMD-Vi: =A0 DEV_SELECT_RANGE_START =A0 =A0 =A0 =A0de=
vid: 00:16.0 flags: 00
>>> [ =A0 =A02.682957] AMD-Vi: =A0 DEV_RANGE_END =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 devid: 00:16.2
>>> [ =A0 =A02.683234] AMD-Vi: Enabling IOMMU at 0000:00:00.2 cap 0x40
>>> [ =A0 =A02.692043] AMD-Vi: Lazy IO/TLB flushing enabled
>>> [ =A0 =A04.360112] ehci_hcd 0000:00:12.2: applying AMD
>>> SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>>> [ =A0 =A04.380635] ehci_hcd 0000:00:13.2: applying AMD
>>> SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>>> [ =A0 =A04.400658] ehci_hcd 0000:00:16.2: applying AMD
>>> SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
>>> [ =A0 =A04.811320] powernow-k8: Found 1 AMD Phenom(tm) II X6 1090T
>>> Processor (6 cpu cores) (version 2.20.00)
>>> [ =A0 12.349919] EDAC amd64_edac: =A0Ver: 3.3.0 Dec 21 2010
>>> [ =A0 12.350018] EDAC amd64: This node reports that Memory ECC is
>>> currently disabled, set F3x44[22] (0000:00:18.3).
>>> [ =A0 12.350030] EDAC amd64: ECC disabled in the BIOS or no ECC
>>> capability, module will not load.
>>> [ =A0 12.350044] amd64_edac: probe of 0000:00:18.2 failed with error -22
>>
>> What motherboard is this?
>
> ASUS M4A89TD Pro/USB3, it is mentioned on the link
> http://wiki.xensource.com/xenwiki/VTdHowTo
>
>>>
>>> prasad@prasad-kvm:~$ lspci | grep -i RV
>>> 02:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B64
>>> [FireGL V3100 (PCIE)] (rev 80)
>>> 02:00.1 Display controller: ATI Technologies Inc RV370 5B64 [FireGL
>>> V3100 (PCIE)] (Secondary) (rev 80)
>>
>> So, how come you aren't passing in 02:00.1?
>
> I tried passing through 02.00.1 as well. When I pass it to a Linux
> machine I do not see the device bind to a driver, I don't see the drm
> logs in the dmsg. So I thought I am not supposed to pass the 02:00:1.
>
> Should I be passing 02.00.1 instead of 02.00.0?

02:00.0 is the actual device.  02:00.1 is just a placeholder for
supporting dualhead certain other OSes.

Alex

>
>>>
>>> > Look for 'DMAR GFX' on Google. Might shed some more light.
>>> >
>>>
>>> No DMAR for AMD. I think I should have a look at DMAR GFX.
>>>
>>> I am really thankful to you for your support.
>>
>> Hopefully I haven't confused you any further :-)
>>>
>>> Thanks and Regards,
>>> Prasad
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
