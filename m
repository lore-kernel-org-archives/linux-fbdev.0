From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH 0/7] Bunch of patches
Date: Sun, 21 Mar 2004 20:33:39 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403212033.39808.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58hl-0008QN-2F
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:33:53 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B58hi-0005z7-3n
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:33:50 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="utf-8"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: James Simmons <jsimmons@infradead.org>

Hello,

here a seven patches for mach64 fbdev driver.

01_mach64-add.diff
	simple additions, once already send to James

02_mach64-aux.diff
	patch based on patch from Ville Syrj=C3=A4l=C3=A4, use aperture for regist=
er access

03_mach64-chipset2.diff
	reorganize table of chipsets

04_mach64-bios.diff
	let read frequence limits from BIOS

05_mach64-revers-hwtriple.diff
	reverse logic for hardware triple

06_mach64-laterinit.diff
	correct init from BIOS

07_mach64-aux_correct.diff
	free regions, registered for aperture

Summary of patches tested on ARMADA E500 1400x1050

Regards Alex


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
