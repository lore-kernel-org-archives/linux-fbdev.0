From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Matrox G550, dual head, 1680x1050
Date: Fri, 2 Mar 2007 00:25:12 +0100
Message-ID: <200703020025.13174.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMueE-0002dJ-KS for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 15:25:18 -0800
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMueD-0007S2-Vv
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 15:25:18 -0800
Received: from hanslin.local.208.168.192.in-addr.arpa
	(HSI-KBW-085-216-099-221.hsi.kabelbw.de [85.216.99.221])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.tglx.de (Postfix) with ESMTP id B180065C3D9
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  2 Mar 2007 00:25:14 +0100 (CET)
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
I'm the proud owner of two NEC MultiSync 2070WNX monitors (1680x1050) and a 
Matrox G550 dual DVI card. I'm now trying to set up a dual head configuration 
with this equipment.

I'm booting with video=matroxfb:vesa:0x1BB, as there is no 1680x1050 vesa 
mode. This works, both monitors show the same and complain about the wrong 
resolution.

Now I start my X server (xorg.conf below) and wish to get a xinerama setup. 
Monitor 1 switches to 1680x1050 and shows a nice clean screen. Monitor 2 
seems to have problems, though. I guess the card still outputs the 1280x1024 
set up at boot time. Colours are correct, but the image is heavily distorted.
It looks like the X server thinks it's 1680x1050 but in fact it's still 
1280x1024.

I spent some time googling, but to no avail. Now my questions:

Is this a known limitation of matroxfb?
If yes, is it considered a bug? I could spend some time looking into the code.
Do I have any chance to get this working in a reasonable dual head 
configuration? Any hints?

TIA,
Hans

Here's my xorg.conf:

# /etc/X11/xorg.conf (xorg X Window System server configuration file)

Section "Files"
	FontPath	"unix/:7100"	# local font server
	FontPath	"unix/:7101"	# local ttf-font server
	# path to defoma fonts
	FontPath	"/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType"
EndSection

Section "Module"
	Load	"i2c"
	Load	"bitmap"
	Load	"ddc"
	Load	"dri"
	Load	"extmod"
	Load	"freetype"
	Load	"glx"
	Load	"int10"
	Load	"type1"
	Load	"vbe"
EndSection

Section "InputDevice"
	Identifier	"Generic Keyboard"
	Driver		"kbd"
	Option		"CoreKeyboard"
	Option		"XkbRules"	"xorg"
	Option		"XkbModel"	"pc105"
	Option		"XkbLayout"	"de"
	Option		"XkbVariant"	"nodeadkeys"
EndSection

Section "InputDevice"
	Identifier	"Configured Mouse"
	Driver		"mouse"
	Option		"CorePointer"
	Option		"Device"		"/dev/input/mice"
	Option		"Protocol"		"ExplorerPS/2"
	Option		"Emulate3Buttons"	"true"
EndSection

Section "Device"
	Identifier	"MatroxG550_1"
	Driver		"mga"
	BusID		"PCI:1:0:0"
	Option 		"OldDmaInit" "True"
	Screen		0
EndSection

Section "Device"
	Identifier	"MatroxG550_2"
	Driver		"mga"
	BusID		"PCI:1:0:0"
	Option 		"OldDmaInit" "True"
	Screen		1
EndSection

Section "Monitor"
	Identifier	"NECMonitor1"
	Option		"DPMS"
	HorizSync	32-82
	VertRefresh	56-75
	Modeline "1680x1050@60" 154.20 1680 1712 2296 2328 1050 1071 1081 1103
EndSection

Section "Monitor"
	Identifier	"NECMonitor2"
	Option		"DPMS"
	HorizSync	32-82
	VertRefresh	56-75
	Modeline "1680x1050@60" 154.20 1680 1712 2296 2328 1050 1071 1081 1103
EndSection

Section "Screen"
	Identifier	"LeftScreen"
	Device		"MatroxG550_1"
	Monitor		"NECMonitor1"
	DefaultDepth	24
	SubSection "Display"
		Depth		24
		Modes		"1680x1050" "1280x1024" 
	EndSubSection
EndSection

Section "Screen"
	Identifier	"RightScreen"
	Device		"MatroxG550_2"
	Monitor		"NECMonitor2"
	DefaultDepth	24
	SubSection "Display"
		Depth		24
		Modes		"1680x1050" "1280x1024" 
	EndSubSection
EndSection

Section "ServerLayout"
	Identifier	"Default Layout"
	Screen		0 "LeftScreen" 0 0
	Screen  	1 "RightScreen" RightOf "LeftScreen"
	Option 		"Xinerama" "On"
	InputDevice	"Generic Keyboard"
	InputDevice	"Configured Mouse"
EndSection

Section "DRI"
	Mode	0666
EndSection



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
