From: Observer <observer@moscomono.ath.cx>
Subject: Success reports, and troubles
Date: Tue, 26 Oct 2004 23:07:32 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1098850052.3515.124.camel@angrenost.spidernet>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMf6B-0008Gd-Oo
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 21:07:47 -0700
Received: from [201.128.92.9] (helo=cerberus.spidernet)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CMf6A-00054R-7i
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 21:07:47 -0700
Received: from [192.168.0.128] ([192.168.0.128])
	(authenticated bits=0)
	by cerberus.spidernet (8.12.11/8.12.11) with ESMTP id i9R47eVC004963
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Oct 2004 23:07:51 -0500
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

I've been able to run ruby with kernel 2.6.9 an the following hardware

Intel Corp. 82865G Integrated Graphics Device + Matrox Millenium

Intel Corp. 82865G Integrated Graphics Device + Matrox Millenium II

Intel Corp. 82865G Integrated Graphics Device + pine XP-PCI3800 (sis
315)

Intel Corp. 82865G Integrated Graphics Device + Matrox Millenium + pine
XP-PCI3800 (sis 315)

Intel Corp. 82865G Integrated Graphics Device + Matrox Millenium II +
pine XP-PCI3800 (sis 315)

but i cant run more than 1 card that uses the same XFree driver, when
the second X server using the same driver is launched the system hangs,
i have used both matrox video cards, and two sis 315. Is this a common
trouble?, can anyone help to fix this, or its not possible?

I don't now if this is related but when the system boots i always this
message:

PCI: Cannot allocate resource region X

For both pci buses where the cards are inserted.

Thanks



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
