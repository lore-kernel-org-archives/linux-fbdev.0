From: xcsnake@free.fr
Subject: 8 words bursts for fbdev driver
Date: Mon, 28 May 2007 17:25:59 +0200
Message-ID: <1180365959.465af4876a6a8@imp.free.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsgAc-0006MU-JC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 07:26:02 -0700
Received: from smtp8-g19.free.fr ([212.27.42.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsgAb-0003SZ-Vn
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 07:26:02 -0700
Received: from imp6-g19.free.fr (imp6-g19.free.fr [212.27.42.6])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 9156D1B61F
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 28 May 2007 16:25:59 +0200 (CEST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

I have posted this message on the linux-kernel mailing list, but I think it
could be more appropriate here.
I'm working on a FPGA vga controller, with an arm cpu (at91rm9200). My FPGA=
 is
plugged on a 16 bits data bus. I'm trying to develop the framebuffer driver,
from the epson s1d13xxxfb driver to use my controller. I have a first driver
which works well. To accelerate my controller, I would like to read and wri=
te in
my video memory (controlled by the FPGA) by 8 words bursts. Is it possible =
to
tell the kernel that the memory must be accessed only by 8 words bursts ??
My driver is available on http://xcsnake.free.fr/driver

Thanks a lot

Micka=EBl

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
