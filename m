From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: Radeon X300, radeonfb, dual head - conclusion
Date: Fri, 20 Apr 2007 23:54:41 +0200
Message-ID: <200704202354.42019.hjk@linutronix.de>
References: <200704181409.51475.hjk@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <200704181409.51475.hjk@linutronix.de>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: xorg@lists.freedesktop.org
Cc: linux-fbdev-devel@lists.sourceforge.net

I'd like to bring this thread to a preliminary conclusion. Today I experimented a little more,
with the following results:

Short summary:

We're talking about this card:

01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)]

This is a MSI RX300HM, with an X300SE and 128MB RAM. The card has one DVI-I, one VGA, and
one S-Video connector. I have two NEC MultiSync LCD2070WNX 20" monitors (1680x1050 each).
The monitors have both VGA and DVI-D inputs. Computer has a Core2Duo@1.86GHz, Intel ICH8
chipset, 1GB RAM.

X server is xserver-xorg from Debian unstable. Kernel is vanilla 2.6.21-rc7.
X server is configured for mergedfb to achieve a 3360x1050 desktop across the two monitors.
All tests were performed with KDE 3.5.5 from Debian unstable.

Results:

1.) The monitor connected to the DVI port MUST use a DVI cable. Connecting it with a
DVI-VGA adapter does not work. Using an adapter causes the same picture being displayed
on both monitors. This might only happen with this special card.

2.) Using DRM does NOT work. Compiling radeon drm as a kernel module and configuring
dri in xorg.conf leads to fine 3D acceleration (glxgears -printfps says 1400fps), but
only on the first monitor. The second monitor always shows a black image. It is probably
a correct 1680x1050 video signal (monitor doesn't complain), but only black.
If I compile the kernel without drm support, and delete the dri lines in xorg.conf,
I have a working dual head setup with Pseudo-Xinerama. 

3.) Using radeonfb does NOT work. I tried to compile it into the kernel to have a 
framebuffer console at boot time, but that's not possible. I noticed two effects:
3.1.) if drm is also enabled, the X server hangs at 100% CPU with black screens on both
      monitors. Framebuffer console before X starts is OK.
3.2.) if drm is not enabled, the X server starts, but with a garbled screen that is
      hardly useable. Framebuffer console before X starts is fine.

4.) Using vesafb instead of radeonfb works. I have a framebuffer console, and X works 
as expected. No DRI, of course (glxgears -printfps says 900fps).


I'd really like to see these issues fixed. I'm willing and able to help on the kernel
side of the story, although I never looked into fb or drm code yet. I won't compile
X servers, though.

Any comments?
Any ideas how we could proceed?

Thanks,

Hans
