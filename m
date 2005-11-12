From: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>
Subject: Re: geodefb issues, possible patch
Date: Sat, 12 Nov 2005 02:30:40 +0100
Message-ID: <eb77d7060511111730o1edcb19fqf60c98e76098c6c3@mail.gmail.com>
References: <eb77d7060511110405i13b8bc8aw335147185398cd22@mail.gmail.com>
	 <43749BC7.8030705@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EakE8-0005CU-G3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 17:30:44 -0800
Received: from nproxy.gmail.com ([64.233.182.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EakE7-0001rD-4C
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 17:30:44 -0800
Received: by nproxy.gmail.com with SMTP id o60so171469nfa
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Nov 2005 17:30:40 -0800 (PST)
In-Reply-To: <43749BC7.8030705@arcom.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi David, and thanks for your fast answer :)

On 11/11/05, David Vrabel <dvrabel@arcom.com> wrote:
> Jorge Luis Zapata Muga wrote:
> >
> > i am having problems with the geode fb driver in 2.6 kernels. it seems
> > that it cant ioremap the video registers. ive debug a little bit of
> > code and compared it to the
> > previous kernel tree (2.4) geode fb driver amd (i think) provided. the
> > old driver works perfectly on my SBP.
>
> What CPU and companion chip is on this board?  The current 2.6 driver
> only supports the Geode GX1 with CS5530A.
>

as seen on the chip it is a Geode GX1 with CS5530

> What kernel version are you using?

2.6.14

>
> > ok here are the things i found:
> > * when requesting the pci regions all the pci_resource_start,
> > pci_resource_len return 0's
>
> Can you send the output of 'lspci -vvv -x' for the companion chip video
> device?
>

ok here it is (i have manually copy it from the screen)

00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video
[Kahlua] (prog-if 00 [VGA])
Subsystem: Cyrix Corporation Unknown device 0001
Control: I/0+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmdeium >TAbort-
<Tabort- <MAbort< >SERR- <PERR-
Region 0: Memory at 408000000 (32-bit, non-prefetchable) [size=3D8M]
Expansion ROM at <unassigned> [dissabled]
00: 78 10 04 01 03 00 80 02 00 00 00 03 00 00 80 02
10: 00 00 80 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 78 10 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


> > * the hardcoded offsets for mapping are different from what i found in
> > the other driver, ive changed them to the older values. (to map the
> > video reg, display controller reg, and the fb memory)
>
> Er. I doubt this is the correct thing to do since the driver matches the
> GX1 data sheet.
>
> > * the display controller functions to blank the screen, configure
> > display, set clock freq, etc used the vid_regs  for writel readl
> > instead (as seen in the other driver) of the dc_vid (display
> > controller registers).
>
> I don't follow you here. The display controller has nothing to do with
> the DCLK frequency nor blanking the screen -- that's purely a function
> of the video device in the companion chip.
>
> > i have a patch if someone is interested. the problem is that i dont
> > know what else to do, as i cant debug (with printf's) the driver as i
> > dont have a screen, how does a fb driver gets debugged?
>
> I use a serial console.
>
> > does this driver actually works?
>
> It works on the board I have.
>
> > maybe i have an issue with the pci detection?
>
> It's possible that the BIOS not correctly initializing all PCI devices
> correctly.  I don't really know a whole lot about PCI on x86 platforms,
> though.
>
> David Vrabel
>
> ps. I'd suggest ignoring the old 2.4 driver for the most part since it's
> crap and very hard to follow -- refer to the datasheets instead.
> --
> David Vrabel, Design Engineer
>
> Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
> Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
