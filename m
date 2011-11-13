From: David J Ring Jr <n1ea@arrl.net>
Date: Sun, 13 Nov 2011 22:50:58 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <alpine.DEB.2.00.1111132249090.2152@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-121701759-1321242607=:2152"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-121701759-1321242607=:2152
Content-Type: TEXT/PLAIN; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Bruno,

Here is lspci:

00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Contr=
oller Hub (rev 07)
00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipse=
t Integrated Graphics Controller (rev 07)
00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset Integ=
rated Graphics Controller (rev 07)
00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #4 (rev 03)
00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #5 (rev 03)
00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #6 (rev 03)
00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Co=
ntroller #2 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Contr=
oller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 2 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 3 (rev 03)
00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 4 (rev 03)
00:1c.5 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 6 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Co=
ntroller #1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
00:1f.0 ISA bridge: Intel Corporation ICH9M LPC Interface Controller (rev 0=
3)
00:1f.2 SATA controller: Intel Corporation ICH9M/M-E SATA AHCI Controller (=
rev 03)
00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev=
 03)
02:00.0 System peripheral: JMicron Technology Corp. SD/MMC Host Controller
02:00.2 SD Host controller: JMicron Technology Corp. Standard SD Host Contr=
oller
02:00.3 System peripheral: JMicron Technology Corp. MS Host Controller
04:00.0 Network controller: Broadcom Corporation BCM4312 802.11b/g LP-PHY (=
rev 01)
07:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5906M Fast Eth=
ernet PCI Express (rev 02)

Thank you again,

I don't see anything with video in it.

David

On Sun, 13 Nov 2011, Bruno Pr=E9mont wrote:

> On Sun, 13 November 2011 Anatolij Gustschin <agust@denx.de> wrote:
>> On Sun, 13 Nov 2011 21:16:52 -0500 (EST)
>> David J Ring Jr <n1ea@arrl.net> wrote:
>>
>>> OK so how do I get a frame buffer driver loaded?
>>
>> Check if some frame buffer drivers are installed
>> in your system, so e.g. run
>>
>> ls /lib/modules/`uname -r`/kernel/drivers/video
>>
>> to see if there are any frame buffer driver modules
>> installed.
>>
>> Then you have to select the suitable driver for your
>> graphic card and load it by running
>>
>> modprobe drivername
>>
>>> I don't have any backlisted framebuffer drivers, what is stopping me fr=
om
>>> loading a frame buffer driver?
>>>
>>> Does anyone know what I have to do?
>>
>>
>> Usually the driver should be loaded automatically if
>> it is installed. Maybe some error happened while loading
>> the driver. Dump the kernel log messages by running dmesg
>> and check if there was an attempt to load the driver for
>> your graphic card.
>
> The other case might be a mainsteam GPU (radeon, nouveau, intel) and
> KMS support built in (or available as module) but disabled by "nomodeset"
> cmdline option that did show up in a previous post.
>
> Just booting with "vga=3D0x31a" (or another value more appropriate for
> attached screen -- see Documentation/fb/vesafb.txt for list) might
> provide a basic framebuffer device.
>
> lspci for the affected system will certainly help at least indicating
> which driver would be the right one.
>
> Bruno
>
--8323328-121701759-1321242607=:2152--
