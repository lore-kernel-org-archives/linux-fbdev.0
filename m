From: David Vrabel <dvrabel@arcom.com>
Subject: Re: geodefb issues, possible patch
Date: Mon, 14 Nov 2005 13:52:00 +0000
Message-ID: <43789680.4030703@arcom.com>
References: <eb77d7060511110405i13b8bc8aw335147185398cd22@mail.gmail.com>	 <43749BC7.8030705@arcom.com> <eb77d7060511111730o1edcb19fqf60c98e76098c6c3@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ebekk-0002XF-98
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 05:52:10 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ebekj-0003Kq-4f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 05:52:10 -0800
In-Reply-To: <eb77d7060511111730o1edcb19fqf60c98e76098c6c3@mail.gmail.com>
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

Jorge Luis Zapata Muga wrote:
> 
> ok here it is (i have manually copy it from the screen)
> 
> 00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video
> [Kahlua] (prog-if 00 [VGA])
> Subsystem: Cyrix Corporation Unknown device 0001
> Control: I/0+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=mdeium >TAbort-
> <Tabort- <MAbort< >SERR- <PERR-
> Region 0: Memory at 408000000 (32-bit, non-prefetchable) [size=8M]
> Expansion ROM at <unassigned> [dissabled]

Okay, this is wrong. It should have a 4 KiB region for the video device
registers.  For example:

00:12.4 VGA compatible controller: Cyrix Corporation 5530 Video [Kahlua]
(prog-if 00 [VGA])
	[...]
        Region 0: Memory at 40800000 (32-bit, non-prefetchable) [size=8M]
        Region 1: Memory at 40010000 (32-bit, non-prefetchable) [size=4K]
	[...]

Your BIOS isn't properly initializing the device resources and I'm
rather surprised it ever worked...

Now I thought the kernel was supposed to fix-up problems with PCI
resources and I'm not sure why it isn't doing it in this case.

Perhaps you could try a PCI fixup to straighten out the BARs/resources?

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
