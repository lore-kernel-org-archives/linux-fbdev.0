From: Bernie Thompson <bernie@plugable.com>
Date: Sat, 18 Jun 2011 00:18:37 +0000
Subject: Re: Framebuffer driver for controller with indirect addressing?
Message-Id: <BANLkTikZjs=RScURA=Nmo0v63hBC8+MARA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0LlUqt-1Pye1R36EZ-00bCDF@mrelay.perfora.net>
In-Reply-To: <0LlUqt-1Pye1R36EZ-00bCDF@mrelay.perfora.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, Jun 17, 2011 at 4:10 PM, Steve Strobel
<steve.strobel@link-comm.com> wrote:
> It does not have address lines, so the framebuffer memory
> is not directly accessible
>
> If someone could point me to a driver that works in a similar way, it wou=
ld
> help me out a lot. =C2=A0Thanks.

Hi Steve - there are several drivers that handle this kind of case,
including the udlfb driver for DisplayLink USB graphics chips (in the
kernel tree /drivers/video/udlfb.c)

The main unsolved challenge is fbdev (in the memory mapped framebuffer
case) assumes writes to the framebuffer take effect immediately.  For
hardware in which this isn't true (e.g. USB, eink controllers, etc.),
there are two common solutions. However both have problems:

1) Use of /driver/video/fb_defio.c to use the MMU to trigger fault
handlers on framebuffer writes, and transmit to hardware via delayed
processing of the dirty pages. However, this implementation still
appears to have some race conditions which can result in difficult to
debug problems.  It's also a bit of MMU/cache load.

2) Use of an ioctl to allow the user mode client to inform the
framebuffer of changed pixels (usually xorg forwarding X DAMAGE
notifications, which are well matched for this purpose).  This works
well and is simple, however we don't yet have a standardized ioctl, so
several drivers have different ioctls and thus custom x servers,
instead of being supported by the standard xf86-video-fbdev driver.

#2 would be the quickest way to give Linux a clean way of handling
remote (non-directly-addressable) framebuffers.

Others may have some additional suggestions.

Hope that helps. Best wishes,
Bernie
http://plugable.com/
