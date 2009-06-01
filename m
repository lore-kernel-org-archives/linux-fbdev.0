From: Jonathan Nieder <jrnieder@gmail.com>
Subject: aty128fb artifacts
Date: Mon, 1 Jun 2009 02:07:22 -0500
Message-ID: <6f8c04400906010007x160bf846hbd8d8ece0277ea7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jrnieder@gmail.com>) id 1MB1d9-0001TO-Fp
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 07:08:23 +0000
Received: from yx-out-1718.google.com ([74.125.44.154])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MB1cB-000461-Bc for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jun 2009 07:08:23 +0000
Received: by yx-out-1718.google.com with SMTP id 6so3738349yxn.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Jun 2009 00:07:22 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi fbdev developers,

On the laptop I use, the built-in display is a single-resolution
1024x768 TFT, and the imperfect anti-aliasing makes it much harder to
read text in the standard console than in X. I decided to try out
fbcon so the console could have the appropriate resolution. Eventually
I should learn to switch resolutions, but first I would like to report
the quirks I have noticed so far. I am not knowledgeable enough to
know what should trouble me and what is normal.

The laptop is an Inspiron 4000, the video card a Rage Mobility M3 AGP
2x [1002:4c46], and the display a Samsung LT141X8-L02. The kernel is
Linus's v2.6.30-rc7-11-ga0c1af1, plus some wireless fixes.  I tested
by running "modprobe aty128fb" and then "modprobe fbcon" and was
impressed to see the console usable right away. But:

 * A sort of gray stripe with vertical bands of various shades of gray
was present on the bottom quarter-centimeter of the screen.  When I
switched consoles, let the screen blank and wake up, switched to X and
back, and so on, the color of the bands would change (sometimes red or
green, different greys, ...).

 * There were black horizontal stripes through the (gpm) mouse block
cursor whenever I moved it.  They would go away once the mouse stopped
moving.

 * When I tried "fbset -xres 1024 -yres 768 -depth 16" (presumably
this was a bad idea), a few vertical bands covering the entire height
of the screen blinked black, then green, then black, then various
colors. I quickly rebooted after that.

 * After a soft reboot (back to vgacon), the console was mostly back
to normal but something had happened to the cursor. The usual blinking
underline was present until the cursor reached the bottom of the
screen and then it disappeared.  Clearing the screen with ^L resulted
in the cursor appearing approx halfway down.  I needed a cold boot to
get the cursor back to normal. This same effect occurs whenever I load
aty128fb and fbcon and soft reboot.

 * When I tried "fbset 1024x768", a sort of speckled glow appeared in
the middle of the screen and spread out, and I quickly rebooted.

 * With X driver "fbdev", the resolution was still 640x480 (I think),
but the screen looked very strange. The virtual desktop was squished
horizontally to leave about an inch to the right entirely black except
at the bottom.  The grey rectangle at the bottom of approx a half a cm
was still present, covering the entire width of the display. With my X
setup, when X starts there is only a red border surrounding a black
terminal. The grey rectangle appeared to reflect that border, with a
vertical red band 1 pixel to the left of the right edge of the red
rectangle.

 * When switching from VT6 (fbcon) to VT7 (X with fbdev driver) the
text turned blue before the X desktop was shown. It was nice to see
that the switch was smooth aside from that, since there are normally
artifacts when I switch between vgacon and X with the r128 driver.

I had no success unloading the fbcon driver. "vbetool vbestate
restore" with state from the VGA console mangled the screen; switching
to X and back revealed that it had output the text "Function not
supported."

I am interested to hear your thoughts. So far, I have found no
documentation on the Rage M3's internals so I am clueless when faced
with all these symptoms.

Regards,
Jonathan

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
