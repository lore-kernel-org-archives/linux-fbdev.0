From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: Radeon X300, radeonfb, dual head
Date: Thu, 19 Apr 2007 10:35:11 +0200
Message-ID: <462729BF.5020502@gmx.net>
References: <200704181409.51475.hjk@linutronix.de>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HeS7J-00087C-VV for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Apr 2007 01:35:50 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HeS7J-0002HU-8t
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Apr 2007 01:35:49 -0700
In-Reply-To: <200704181409.51475.hjk@linutronix.de>
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
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Hans-J=FCrgen Koch a =E9crit :
> I've got a Radeon X300 (MSI RX300HM) PCIE card. The card has a =

> VGA and a DVI-I output. I connect two LCD monitors (1680x1050 each)
> using VGA outputs (DVI-VGA adapter for one monitor).
>
> I'd like to run xserver-xorg with KDE from Debian unstable in =

> mergedfb mode showing a 3360x1050 desktop across the two monitors.
>
> I'm running a vanilla 2.6.21-rc7. Now I've got two problems that
> might or might not be related:
>
> 1.) I compiled radeonfb statically into my kernel and booted with
> video=3Dradeonfb:1280x1024-32@60. This works fine, the framebuffer
> console works as expected. But the X server doesn't come up
> properly. Xorg.0.log ends like this:
>
> [...]
> (**) RADEON(0): RADEONSaveScreen(2)
> (**) RADEON(0): FIFO timed out: 2 entries, stat=3D0x80026102
> (EE) RADEON(0): FIFO timed out, resetting engine...
> (**) RADEON(0): EngineRestore (32/32)
> (**) RADEON(0): FIFO timed out: 31 entries, stat=3D0x8002611f
> (EE) RADEON(0): FIFO timed out, resetting engine...
> (**) RADEON(0): EngineRestore (32/32)
> (**) RADEON(0): FIFO timed out: 15 entries, stat=3D0x8002610f
> (EE) RADEON(0): FIFO timed out, resetting engine...
> (**) RADEON(0): EngineRestore (32/32)
> (**) RADEON(0): FIFO timed out: 15 entries, stat=3D0x8002610f
> (EE) RADEON(0): FIFO timed out, resetting engine...
> (**) RADEON(0): EngineRestore (32/32)
> (**) RADEON(0): FIFO timed out: 31 entries, stat=3D0x8002611f
> (EE) RADEON(0): FIFO timed out, resetting engine...
> (**) RADEON(0): EngineRestore (32/32)
> (**) RADEON(0): FIFO timed out: 3 entries, stat=3D0x80026103
> (EE) RADEON(0): FIFO timed out, resetting engine...
> (**) RADEON(0): EngineRestore (32/32)
> (**) RADEON(0): FIFO timed out: 6 entries, stat=3D0x80026106
> (EE) RADEON(0): FIFO timed out, resetting engine...
> (**) RADEON(0): EngineRestore (32/32)
> (**) RADEON(0): RADEONCloseScreen
> (**) RADEON(0): RADEONDRIStop
> (**) RADEON(0): RADEONDisplayPowerManagementSet(0,0x0)
> (**) RADEON(0): RADEONRestore
> (**) RADEON(0): RADEONRestoreMode()
> (**) RADEON(0): RADEONRestoreMode(0x8202e40)
> (**) RADEON(0): RADEONRestoreMemMapRegisters() :
> (**) RADEON(0):   MC_FB_LOCATION   : 0x1fff0000
> (**) RADEON(0):   MC_AGP_LOCATION  : 0x27ff2000
> (**) RADEON(0):   Map Changed ! Applying ...
> (**) RADEON(0):   Map applied, resetting engine ...
> (**) RADEON(0): Updating display base addresses...
> (**) RADEON(0): Memory map updated.
> (**) RADEON(0): Programming CRTC2, offset: 0x00000000
> (**) RADEON(0): Wrote: 0x00000000 0x00000000 0x00000000 (0x0000a400)
> (**) RADEON(0): Wrote: rd=3D0, fd=3D0, pd=3D0
> (**) RADEON(0): Programming CRTC1, offset: 0x00000000
> (**) RADEON(0): Wrote: 0x0030000c 0x00010060 0x00000000 (0x0000a700)
> (**) RADEON(0): Wrote: rd=3D12, fd=3D96, pd=3D1
> (**) RADEON(0): Disposing accel...
> (**) RADEON(0): Disposing cusor info
> (**) RADEON(0): Disposing DGA
> (**) RADEON(0): Unmapping memory
> FreeFontPath: FPE "unix/:7100" refcount is 2, should be 1; fixing.
>   =



Hello,

i had the same issue about fifo timeout. You certainly get a very random
refresh of your screen too if you activate dri. That is not a Xorg bug
but rather a radeonfb one. It comes from radeonfb_accel.c, if i remember
well. Just try and read the patch i send to the list (thread "radeonfb
doesn't work with an ati X800 pcie", file: radeon_accel.c.2.6.20.diff)
Also, you will certainly need all the xxx.c.2.6.20.diff as well. You
will find them in the april archive. If that doesn't help you can try
luca'sone + aty.patch (same thread) In that case you are integrating a
bunch of xorg code in radeonfb :). Luca's patch isn't compatible with
mine except when applied with aty.patch. I need it for my card,
otherwise it doesn't work. But it could be incompatible with your card.
Luca's patch still generates 2 *.rej file. You can install them manually
and very easily byreading the rej file.

If nothing works for you , you have certainly a legacy instead an atom
bios. In that case most of the patches won't help you except perhaps
radeon_accel . But keep trying.
I get finally my x800  working with them. xorg and radeonfb work now
together without a problem. Indeed, i don't have black screens or screen
corruptions any more and dri is now working ;)

Good luck.


Jj

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
