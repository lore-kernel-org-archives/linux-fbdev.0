From: Sven Luther <sven.luther@wanadoo.fr>
Subject: radeonfb on linuxppc_2_4 tree ...
Date: Mon, 16 Jun 2003 18:55:34 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030616165534.GA6319@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp8.wanadoo.fr ([193.252.22.30] helo=mwinf0102.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19RxGn-00077r-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Jun 2003 09:55:49 -0700
Received: from iliana (unknown [81.50.248.12])
	by mwinf0102.wanadoo.fr (SMTP Server) with ESMTP id 9994B1BE7BB5
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Jun 2003 18:55:42 +0200 (CEST)
Received: from luther by iliana with local (Exim 3.36 #1 (Debian))
	id 19RxGZ-0001eO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Jun 2003 18:55:35 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Hello,=20

I am trying to build a linuxppc_2_4 bk tree checked out with the 2.4.21
tag. But i get this error :

radeonfb.c: Dans la fonction =AB radeonfb_pci_register =BB:
radeonfb.c:1004: error: `PCI_DEVICE_ID_RADEON_LY' undeclared (first use in =
this function)
radeonfb.c:1004: error: (Each undeclared identifier is reported only once
radeonfb.c:1004: error: for each function it appears in.)
radeonfb.c:1005: error: `PCI_DEVICE_ID_RADEON_LZ' undeclared (first use in =
this function)
radeonfb.c: Hors de toute fonction :
radeonfb.c:820: attention : `OUTMC' declared `static' but never defined
radeonfb.c:821: attention : `INMC' declared `static' but never defined
radeonfb.c:822: attention : `radeon_pm_disable_dynamic_mode' declared `stat=
ic' but never defined
radeonfb.c:823: attention : `radeon_pm_enable_dynamic_mode' declared `stati=
c' but never defined
radeonfb.c:824: attention : `radeon_pm_yclk_mclk_sync' declared `static' bu=
t never defined
radeonfb.c:825: attention : `radeon_pm_program_mode_reg' declared `static' =
but never defined
radeonfb.c:826: attention : `radeon_pm_enable_dll' declared `static' but ne=
ver defined
radeonfb.c:827: attention : `radeon_pm_full_reset_sdram' declared `static' =
but never defined
make[4]: *** [radeonfb.o] Erreur 1

Is this an error of my checkout, or a problem with the 2.4.21 tag of the
linuxppc_2_4 tree ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
