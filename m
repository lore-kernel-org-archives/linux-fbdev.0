From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 12:03:45 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFD2@pdsmsx403>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S270330AbUJUEPW@vger.kernel.org>
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>
Cc: Kendall Bennett <kendallb@scitechsoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

It is hard to use native VGA for s3 debugging.=20
I don know if serial console or net console=20
can help s3 debugging.=20

Thanks
Luming=20

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org=20
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Pavel Machek
>Sent: 2004=C4=EA10=D4=C220=C8=D5 5:09
>To: Jon Smirl
>Cc: Kendall Bennett; Alan Cox; Linux Kernel Mailing List; fbdev
>Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
>
>Hi!
>
>> > What about non-x86 platforms such as PowerPC and MIPS=20
>embedded devices
>> > that want video (TiVo type platforms, media players etc).=20
>How would these
>> > fit into the picture? Would this require the boot loader=20
>(ie: U-Boot or
>> > whatever) to have the ability to POST the card?
>>=20
>> There is the assumption that whatever BIOS the device has=20
>can get up a
>> very early console that can output critical error messages before th=
e
>> kernel and early user space is loaded. For example the "I can't find
>> the kernel" or  "initramfs is missing" error message. This also
>> assumes that the BIOS can post whatever display it is using.
>>=20
>> I'm not trying to fix the problem of getting early boot messages out
>> of a Mac with an x86 card plugged into it. The card will work after
>> early user space initializes. The right way to fix that would be to
>> switch to something like LinuxBIOS and build the x86 emulator into
>> it.
>
>That still does not solve resume from suspend-to-RAM. We need to post
>VGA there. We probably could do it late in userspace... but it makes
>debugging resume pretty hard.
>								Pavel
>--=20
>People were complaining that M$ turns users into beta-testers...
>...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
>-
>To unsubscribe from this list: send the line "unsubscribe=20
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
