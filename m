From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Thu, 9 Dec 2004 23:46:18 -0200
Message-ID: <200412092346.19189.lucasvr@gobolinux.org>
References: <200412072347.23194.lucasvr@gobolinux.org> <200412082034.08852.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcZrN-0003LZ-O1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 17:46:17 -0800
Received: from loncoche.terra.com.br ([200.154.55.229])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CcZrM-00012a-M5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Dec 2004 17:46:17 -0800
Received: from merida.terra.com.br (merida.terra.com.br [200.154.55.132])
	by loncoche.terra.com.br (Postfix) with ESMTP id A5819E7A95E
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Dec 2004 23:46:12 -0200 (BRST)
Received: from ummagumma.ozzmosis.net (200-102-085-101.nhoce7002.dsl.brasiltelecom.net.br [200.102.85.101])
	(authenticated user lucasvr)
	by merida.terra.com.br (Postfix) with ESMTP id 6BEDE3C062
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Dec 2004 23:46:12 -0200 (BRST)
In-Reply-To: <200412082034.08852.adaplas@hotpop.com>
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

On Wednesday 08 December 2004 10:34, Antonino A. Daplas wrote:
> On Wednesday 08 December 2004 09:47, Lucas Correia Villa Real wrote:
> > Hi,
> >
> > I was trying to figure out why my GeForce FX 5200 wasn't being recognized
> > by rivafb, when I saw that its ID was not being included by the driver.
> >
> > The following patch (against 2.6.10-rc3) allows it to compile and switch
> > to graphics mode successfully.
>
> We haven't included the id's for NV30 chipsets and newer since the rivafb
> code was made for NV20 and older cards.  So we add the id's only if users
> report that it works.
>
> > Just a note: the README file shipped with the NVIDIA driver has a
> > complete list of device ID's. While it's easy to add them all into riva.c
> > and pci_ids.h, I'm not very sure if it's okay to flood them with #defines
> > and by increasing heavily the rivafb_pci_tbl table.
> >
> > Is it ok to do that, or were you waiting to get a feedback from users
> > from those cards first? I can provide a patch to include all the missing
> > cards if there's no problem on doing that.
>
> Actually, I'm planning to replace/supplement the rivafb driver with
> nvidiafb which will support NV30 and NV40 chipsets, including full
> acceleration as well as better display detection.  If you don't mind, I'm
> going to attach the patch for testing.  Usage is:
>
> video=nvidiafb:<options>
>
> where options are quite similar to rivafb's.
>
> Patch should apply against recent 2.6 kernels, but it might choke on
> include/linux/pci_ids.h. Let me know if it works for you.

Hi Tony,

It worked perfectly fine here (after some adjusts on pci_ids.h):

nvidiafb: nVidia device/chipset 10DE0322
nvidiafb: nVidia Corporation NV34 [GeForce FX 5200]
nvidiafb: CRTC0 found
nvidiafb: CRTC1 not found
nvidiafb: EDID found from BUS1
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 90x25
nvidiafb: PCI nVidia NV32 framebuffer (128MB @ 0xF0000000)

Just let me know if you want to test something special on this driver (I'm 
already subscribed to the mailing list) -- I volunteer to do that.

Cheers, and thanks for the good work :-)
Lucas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
