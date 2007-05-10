From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Blitter speed tests (was: smart blitter usage
	for scrolling)
Date: Thu, 10 May 2007 18:48:30 +0200
Message-ID: <46434cdea1ce4@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmBoi-0003Ww-CJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 09:48:36 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HmBog-0007lK-S4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 09:48:36 -0700
Received: from poczta-8.free.wp-sa.pl (HELO localhost) ([10.1.1.19])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	10 May 2007 18:48:30 +0200
Content-Disposition: inline
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Below are tests of different scrolling methods for cards I have.

All tested drivers use SCROLL_REDRAW method. I forced SCROLL_MOVE =

method by adding flag FB_READS_FAST. =


Here are some conclusions:
Comparing two new methods: smart blitting and smart blitting with =

merge, the merge of blits gives some speed up at lower bit =

depths, but it is usually lost at higher ones. So we can choose =

both ways (with or without the merge).

The smart blitting is so much faster in many cases comparing to =

the current dump SCROLL_MOVE, that it can replace the current =

method. For some cards it is even faster than SCROLL_REDRAW with =

accelerated fb_imageblit().

The drivers tdfxfb and nvidiafb will benefit from switching to =

SCROLL_MOVE method if the smart blitting is added (the tdfxfb  =

even without it). I wonder if Geforce cards also shows this speed =

up if switched to the SCROLL_MOVE method but I have no card to =

test.

The mach64 case is strange: it gives upper hand to smart blitting =

but not at 32-bit depth.

I will prepare a patch with drop-in replacement for current =

SCROLL_MOVE method without blits merging (it is the cleanest =

solution).

Regards,
Krzysztof

Test results:
test machine: dual Pentium 3 866MHz, 512 MB RDRAM, AGP 4x

The columns contains results for different depths and resolutions =

(in this order):

1024x768-75 depth 8
1024x768-75 depth 16
1024x768-75 depth 32
1600x1200-60 depth 8

*for 2MB cards it was 1024x512-75 depth 32 instead of 1024x768-75

Permedia 2 AGP (Fire GL 1000 Pro 8MB)
redraw		 3.611	--.----	15.290	 6.258
smart move	 3,700	 6.317	 9.829	 6.553
smart merge	 3.952	 6.731	10.504	 6.968
move		 11.428	--.----	29.527	31.258

Permedia 2V PCI (EONtronic/3dlabs reference board 8MB)
redraw		 2.631	--.----	 7.411	 4.364
smart move	 2.375	--.----	 4.846	 3.986
smart merge	--.----	--.----	--.----	--.----
move		  4.025	--.----	13.895	18.881

ATI Mach64 PCI (recognized as mach64 GU 4MB EDO)
redraw		 2.460	 2.456	 3.403	 3.891
smart move	 0.930	 1.703	 5.904	 1.717
smart merge	 0.820	 1.656	 6.102	 1.552
move		 1.757	 4.073	16.010	 5.084

MGA 2064W PCI (Millenium I 2MB*)
redraw		 0.565	 0.792	 0.918	 0.972
smart move	 0.894	 1.469	 1.930	 1.505
smart merge	 0.828	 1.454	 2.007	 1.429
move		 1.743	 3.600	 5.390	 3.858

MGA 1064SG PCI (Mystique I 2MB*)
redraw		 0.621	 0.981	 1.440	 1.121
smart move	 1.170	 2.040	 3.367	 2.052
smart merge	 1.052	 2.000	 3.519	 1.887
move		 2.056	 4.747	 9.461	 5.418

MGA G200 AGP (Milenium G200 8MB SDRAM)
redraw		 0.480	 0.632	 1.271	 0.800
smart move	 0.438	 0.750	 1.751	 0.813
smart merge	 0.393	 0.700	 1.770	 0.758
move		 0.692	 1.524	 3.837	 1.738

TNT 16MB AGP (16MB SDRAM)
redraw		 1.992	 1.708	 2.116	 2.475
smart move	 0.271	 0.644	 0.736	 1.905
smart merge	 0.252	 0.261	 1.990	 0.657
move		 0.493	 1.736	 4.793	 2.080

Savage4 8MB AGP (Number Nine SR9)
redraw		 0.382	 0.429	 0.926	 0.637
smart move	 0.356	 0.892	 1.990	 0.642
smart merge	 0.371	 0.948	 2.124	 0.689
move		 1.036	 2.675	 5.729	 2.914

Voodoo3 16MB PCI (2000 version)
redraw		 0.611	 0.615	 0.621	 0.998
smart move	 0.143	 0.240	 0.524	 0.256
smart merge	 0.134	 0.249	 0.555	 0.242
move		 0.292	 0.640	 1.528	 0.772


----------------------------------------------------
Juwenalia Krakowskie 2007. Hey, Coma, Myslovitz, =

Vavamuffin. Kabaretony i wielki korow=F3d
7-13 maja Klub =AFaczek, Studio, Rotunda i Stadion Wis=B3y
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fjuwenaliakra=
kow.html&sid=3D1136



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
