From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Virtual Terminal switching problem with a 2.6.10 kernel with a ruby patch
Date: Thu, 9 Jun 2005 13:51:20 -0400
Message-ID: <9e4733910506091051311d2d47@mail.gmail.com>
References: <396a6e00050608091524b97479@mail.gmail.com>
	 <396a6e000506090749265a5066@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgRBi-0006lT-LF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Jun 2005 10:51:30 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DgRBe-0004rF-Ud
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Jun 2005 10:51:30 -0700
Received: by wproxy.gmail.com with SMTP id 69so192626wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jun 2005 10:51:20 -0700 (PDT)
In-Reply-To: <396a6e000506090749265a5066@mail.gmail.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: kenoti maembe <kenotimaembe@gmail.com>, James Simmons <jsimmons@www.infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 6/9/05, kenoti maembe <kenotimaembe@gmail.com> wrote:
> Am working on a dual head project for my final year project at the
> university of nairobi in kenya and come across a discussion where it
> was stated that the linux kernel (by then 2.4) does not allow for two
> or more virtual terminals to exist concurrently..I have a few
> questions I would like to ask
> 1.  Is this still the case with the 2.6 kernel? Thought of working
> through these by creating a new XFree86 and using the XFree86
> prefbusid patch from.from http://www.ltn.lv/~aivils/ bt still only one
> vt works at a time.
> 2. Have tried to assign devices to the different vts but cant seemt to
> get a way to assign the usb keyboard.All input device modules and usb
> modules are load in the kernel so dont understand what the issue is.

You need the ruby kernel patch set to support multiple VTs.
http://linuxconsole.sourceforge.net/
http://linuxconsole.bkbits.net/

There are also patches for supporting multiple video cards/users from
X but I don't know where they are. Ask on the x.org list or James will
know.

I'm not sure how multiple keyboards are handled in ruby. For Xegl I am
using the new evdev interface.
http://www.frogmouth.net/hid-doco/c537.html for examples.

Dealing with multiple video cards is very challenging especially
without the hardware documentation.

For a different project you might want to try implementing the EGL
interface on a 3D card. Documentation for ATI Rage128 and Mach64 (no
one is working on these) is available so if you could get your hands
on a PCI version (about $30) of one of those you'd be set. You want a
PCI version for target debug, then you run X and your debugger on the
Nvidia AGP card.

http://mesa3d.sf.net
http://lists.freedesktop.org/mailman/listinfo/dri-egl

Implementing EGL is more narrow in scope and should be easier to do.
EGL forms the basis of Xegl which is the new 3D accelerated X server.

> CPU: Athlon 1200+
> RAM: 384Mb
> Videocards: NVIDIA GeForce4 MX 440 (AGP), S3 Tio (PCI)
> Motherboard: Via
> Keyboards: one PS/2 keyboards, one USB keyboard
> Mice: one serial, one USB
> Monitors: 17'', 15''
> on a mandrake 10.0
>=20
> Thank you all.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
