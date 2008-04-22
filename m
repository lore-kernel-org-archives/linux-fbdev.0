From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources on 32 bits archs
Date: Tue, 22 Apr 2008 17:55:00 +0200
Message-ID: <480E0A54.9010203@linux.vnet.ibm.com>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761826AbYDVPy3@vger.kernel.org>
In-Reply-To: <20080422012723.BA9F2DE13F@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, adaplas@gmail.com, Hollis Blanchard <hollisb@us.ibm.com>, Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>

Benjamin Herrenschmidt wrote:
> This fixes radeonfb to not truncate 64 bits resources on 32 bits
> platforms. Unfortunately, there are still issues with addresses
> returned to userspace via struct fb_fix_screeninfo. This will
> have to be dealt with separately.

Thanks for this patch Benjamin, I use it together with what we have dis=
cussed in the "pci issue - wrong detection of pci ressources" thread.
Unfortunately I now hit exactly that issue with fb_fix_screeninfo you d=
escribe.

=46or everyone the fb_fix_screeninfo has two "unsigned long" vars that =
need to strore a IO address.
This fails in my case with a 32bit powerpc system (=3Dsizeof(long)=3D4)=
 which has paddr >4Gb and actually it should affect any 32bit platform =
with paddr>4Gb.
You see it e.g. when you try to initialize X11, the x11 radeon driver i=
ssues a FBIOGET_FSCREENINFO ioctl and because our address is >4Gb it ge=
t's clobbered by that unsigned long in the fb_fix_screeninfo structure =
(the value comes from a resource_size_t variable which has the correct =
64bit).

struct fb_fix_screeninfo {
        char id[16];                    /* identification string eg "TT=
 Builtin" */
        unsigned long smem_start;     /* Start of frame buffer mem */
[...]
        unsigned long mmio_start;     /* Start of Memory Mapped I/O   *=
/
[...]

I tried the stupid solution to just change the fb_fix_screeninfo struct=
ure to resource_size_t, but that changes the size ioctl transports and =
would require awareness in the userspace applications using that ioctl.
The X11 & Framebuffer driver work on 64bit systems, so I think it's jus=
t an issue of not cutting that data down to 32bit when transporting it =
(has anyone already checked the x11 drivers, I hope they don't use unsi=
gned long too).

I wanted to ask if there are any known workarounds atm that would allow=
 me to use my X11 for now?

--=20

Gr=FCsse / regards,=20
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
