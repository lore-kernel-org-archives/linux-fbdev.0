From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: vesafb with special resolution?
Date: Fri, 15 Oct 2004 21:06:06 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041015190606.GN30583@charite.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIXP4-0001Av-SJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 12:06:14 -0700
Received: from mail.charite.de ([160.45.207.131])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CIXOz-0003Yz-8r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 12:06:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.charite.de (Postfix) with ESMTP id 5E7482208A8
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Oct 2004 21:06:07 +0200 (CEST)
Received: from postamt1.charite.de (postamt1.charite.de [193.175.66.246])
	by mail.charite.de (Postfix) with ESMTP id A286A220834
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Oct 2004 21:06:06 +0200 (CEST)
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

I have a 16:10 screen on my laptop (1280x768). vesafb runs OK with a
1024x768 resolution, but is 1280x768 also possible?

$ dmesg|grep vesa
Kernel command line: BOOT_IMAGE=3DLinuxOLD ro root=3D303 noapic
video=3Dvesafb:ywrap,mtrr
vesafb: framebuffer at 0xf8000000, mapped to 0xe0880000, size 6144k
vesafb: mode is 1024x768x32, linelength=3D4096, pages=3D1
vesafb: protected mode interface info at c000:e9b0
vesafb: pmi: set display start =3D c00ce9e6, set palette =3D c00cea50
vesafb: pmi: ports =3D 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3c=
e 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da=20
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=3D1=
536
vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0

--=20
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.=
de
Charite - Universit=E4tsmedizin Berlin            Tel.  +49 (0)30-450 570=
-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-8445-4447
IT-Zentrum Standort CBF                                   AIM.  ralfpostf=
ix


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
