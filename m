From: "Cheshire Cat Fish" <cat_fish@hotmail.com>
Subject: Questions on more than one framebuffer device
Date: Tue, 13 May 2003 16:23:14 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Law15-F5CBlGkVf370S0001c98e@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from f5.law15.hotmail.com ([64.4.23.5] helo=hotmail.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Fj7E-0006zk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 16:23:24 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


I asked some questions about this earlier, and didn't see any replies, but 
maybe I missed them.

Anyway,  I am writing an framebuffer driver for my client's graphics card.  
The driver needs to be able to driver multiple adapters, mapping one to 
/dev/fb0, the next to /dev/fb1, the next to /dev/fb2, etc.

This seems to be working.  I call "register_framebuffer" for each card I 
find in the system, and the proper devices seem to be created.

The problem comes when I run X with two cards in the system.  I can run X on 
either card ok.  When I try to run X on both devices at the same time, some 
things don't get drawn, and the screen doesn't always repaint right.  What 
does get drawn, is drawn to the correct screen, just some drawing operations 
seem to be dropped.

My problem is that I am not sure where to start looking for the problem.  
Since each display works fine by itself, I don't understand why using them 
together would cause some drawing operations not to happen.

I am wondering if I even have X configured right.  I tried setting up X to 
run on one of my cards plus an s3, and that also worked fine, so I think I 
am setting things up right for multiple screens.

Below are the screen and device sections of my XF86Config file:

Section "Device"
	Identifier  "Videocard1"
	Driver      "fbdev"
	Option	    "fbdev" "/dev/fb0"
	VendorName  "Video Card Vender"
	BoardName   "Video Card Board"
	VideoRam    8192
	BusID	    "PCI:0:10:0"
EndSection

Section "Device"
	Identifier  "Videocard2"
	Driver      "fbdev"
	Option      "fbdev" "/dev/fb1"
	VendorName  "Video Card Vendor"
	BoardName   "Video Card Board"
	VideoRam    8192
	BusID	    "PCI:0:11:0"
EndSection

Section "Screen"
	Identifier "ScreenCard1"
	Device     "Videocard1"
	Monitor    "Monitor0"
	DefaultDepth     8
	SubSection "Display"
		Depth     8
		Modes    "1200x1600"
	EndSubSection
EndSection

Section "Screen"
	Identifier "ScreenCard2"
	Device     "Videocard2"
	Monitor    "Monitor0"
	DefaultDepth     8
	SubSection "Display"
		Depth     8
		Modes    "1200x1600"
	EndSubSection
EndSection



Section "ServerLayout"
	Identifier     "Default Layout"

# this works
#	Screen      0  "ScreenCard1"

# this works too.
#             Screen      0  "ScreenCard2"

# This doesn't work
	Option	"Xinerama"  "on"
	Screen	0  "ScreenCard1"
	Screen	1  "ScreenCard2" LeftOf "ScreenCard1"

	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
	InputDevice    "DevInputMice" "AlwaysCore"
EndSection

To summarize:

   X on my S3 - works fine.
   X on my adapter on /dev/fb0 - works fine
   X on my adapter on /dev/fb1 - works fine
   X on S3 + /dev/fb0 - works fine
   X on S3 + /dev/fb1 - works fine

   X on /dev/fb0 + /dev/fb1 - doesn't work
   X on S3 + /dev/db0 + /dev/db1 - doesn't work

If anyone could point me to some resources, or better yet a sample driver 
that supports multiple adapters, that would be great.

Thanks,
Noel.
--
A precariously balanced mixture of myopic optimism and rampant paranoia.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
