From: Steve Strobel <steve.strobel@link-comm.com>
Date: Mon, 20 Jun 2011 21:02:36 +0000
Subject: Re: Framebuffer driver for controller with indirect addressing?
Message-Id: <0Md2yY-1QGglf24oc-00IIFk@mrelay.perfora.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0LlUqt-1Pye1R36EZ-00bCDF@mrelay.perfora.net>
In-Reply-To: <0LlUqt-1Pye1R36EZ-00bCDF@mrelay.perfora.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

At 06:18 PM 6/17/2011, Bernie Thompson wrote:
>On Fri, Jun 17, 2011 at 4:10 PM, Steve Strobel
><steve.strobel@link-comm.com> wrote:
> > It does not have address lines, so the framebuffer memory
> > is not directly accessible
> >
> > If someone could point me to a driver that works in a similar way, it w=
ould
> > help me out a lot. =C2 Thanks.
>
>Hi Steve - there are several drivers that handle this kind of case,
>including the udlfb driver for DisplayLink USB graphics chips (in the
>kernel tree /drivers/video/udlfb.c)

That helps a lot.  I will check it out.  Is there=20
something other than the source code that I=20
should read to get up to speed on it?

>The main unsolved challenge is fbdev (in the memory mapped framebuffer
>case) assumes writes to the framebuffer take effect immediately.  [snip]

If I am understanding you right, the challenge is=20
knowing when to flush the changed framebuffer memory to the graphics hardwa=
re.

>1) Use of /driver/video/fb_defio.c to use the MMU to trigger...

I don't know if a Blackfin system could support=20
that method or not.  It doesn't have a full MMU=20
with virtual memory (it runs uClinux), but it=20
does have a memory protection unit.  I suppose=20
all that would be needed is to be notified when=20
the framebuffer memory is written to;  I think it could do that.

>2) Use of an ioctl to allow the user mode client to inform the
>framebuffer of changed pixels (usually xorg forwarding X DAMAGE
>notifications, which are well matched for this purpose).  This works
>well and is simple, however we don't yet have a standardized ioctl, so
>several drivers have different ioctls and thus custom x servers,
>instead of being supported by the standard xf86-video-fbdev driver.

Since this is a custom embedded system, we are in=20
control of all of the software on it.  So we can=20
just make sure that everything included is set up for the same ioctl.

>#2 would be the quickest way to give Linux a clean way of handling
>remote (non-directly-addressable) framebuffers.
>
>Others may have some additional suggestions.

Someone suggested to me using the double-buffer=20
flipping logic.  Does it get flipped on every=20
screen refresh, or just when the contents of one buffer have been changed?

>Hope that helps. Best wishes,
>Bernie
>http://plugable.com/

Thanks a bunch,
Steve



---
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com

