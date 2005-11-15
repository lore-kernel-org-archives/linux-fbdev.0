From: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>
Subject: Re: geodefb issues, possible patch
Date: Tue, 15 Nov 2005 03:23:24 +0100
Message-ID: <eb77d7060511141823i4fe961d7y8f947e9e37523a8f@mail.gmail.com>
References: <eb77d7060511110405i13b8bc8aw335147185398cd22@mail.gmail.com>
	 <43749BC7.8030705@arcom.com>
	 <eb77d7060511111730o1edcb19fqf60c98e76098c6c3@mail.gmail.com>
	 <43789680.4030703@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbqTp-0004Ec-OU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 18:23:29 -0800
Received: from nproxy.gmail.com ([64.233.182.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EbqTn-0004mU-Aj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 18:23:29 -0800
Received: by nproxy.gmail.com with SMTP id o60so260667nfa
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 18:23:24 -0800 (PST)
In-Reply-To: <43789680.4030703@arcom.com>
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

On 11/14/05, David Vrabel <dvrabel@arcom.com> wrote:
> Jorge Luis Zapata Muga wrote:
> >
> > ok here it is (i have manually copy it from the screen)
> >
> > 00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video
> > [Kahlua] (prog-if 00 [VGA])
> > Subsystem: Cyrix Corporation Unknown device 0001
> > Control: I/0+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B-
> > Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmdeium >TAbort-
> > <Tabort- <MAbort< >SERR- <PERR-
> > Region 0: Memory at 408000000 (32-bit, non-prefetchable) [size=3D8M]
> > Expansion ROM at <unassigned> [dissabled]
>
> Okay, this is wrong. It should have a 4 KiB region for the video device
> registers.  For example:
>
> 00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]
> (prog-if 00 [VGA])
>         [...]
>         Region 0: Memory at 40800000 (32-bit, non-prefetchable) [size=3D8=
M]
>         Region 1: Memory at 40010000 (32-bit, non-prefetchable) [size=3D4=
K]
>         [...]
>
> Your BIOS isn't properly initializing the device resources and I'm
> rather surprised it ever worked...
>

Well, with the previous driver (2.4) it worked because it mapped the
registers without depending on the pci bus. :)

> Now I thought the kernel was supposed to fix-up problems with PCI
> resources and I'm not sure why it isn't doing it in this case.
>
> Perhaps you could try a PCI fixup to straighten out the BARs/resources?

i am confused, maybe you can explain me a little here, i am not used
to code drivers, sorry if i am totally wrong with this assumptions.

the thing is that checking the datasheets it looks that in my case the
pci driver is only allocating the first and only region the pci device
has. looking at the datasheets it says that the 10h-13h offset of the
pci header references the base address of the memory mapped video
controller registers, in my case looking at the lspci -xx it is in
fact the frame buffer memory instead of the graphics controller
registers.

Also looking in the durango (i know its old) and in the old driver,
this memory mapped registers (region 1 in your case) reside initially
on the cpu, or at least they took the values from there (from the CCR3
register).

And finally the bios traps the access to the base addres registers and
returns the address of the framebuffer.

any ideas about this? am i correct, or all of this are just some confused i=
deas.


thanks in advance.

Jorge Zapata

>
> David Vrabel
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
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
