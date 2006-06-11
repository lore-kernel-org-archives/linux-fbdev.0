From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Mon, 12 Jun 2006 04:57:17 +0800
Message-ID: <448C83AD.9060200@gmail.com>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpY2i-0007Nt-RI for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 15:04:24 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpY2i-00067o-FG
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 15:04:24 -0700
Received: by py-out-1112.google.com with SMTP id x31so1502527pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 Jun 2006 15:04:24 -0700 (PDT)
In-Reply-To: <448C19D7.5010706@t-online.de>
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
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Knut Petersen wrote:
> Antonino A. Daplas wrote:
> =

>> Overall, this feature is a great help for developers working in the
>> framebuffer or console layer.  =

>>
> Well, it has long been possible to load / unload framebuffer hardware
> drivers using the vfb module as an intermediate step. It even has been
> possible to load both vesafb and another framebuffer driver for the same
> hardware, to assign vesafb to tty{a,b,c..}, the other framebuffer driver
> to tty{m,n,o...} and to switch between those drivers using the usual
> keyboard hotkeys.
> =

> So the main addition of your patchset is the possibility to replace
> fbcon and helper modules, a nice feature I missed in the past.
> =

> But should a framebuffer driver terminate and leave the hardware in
> graphics mode or in text mode? Up to now that was not a real question,
> as we all knew that another framebuffer driver would take over control.
> With your patches it is possible that a user really wants to switch to te=
xt
> mode and to remove the complete fbcon layer. So should we switch the
> hardware to text mode upon unloading a framebuffer driver?
> =

> Maybe unbinding of the framebuffer console is not followed by an
> unloading of the framebuffer module. You tell us that an
> "echo 1 > /sys/class/graphics/fbcon/detach" has the simple effect of a
> corrupt display unless vbetools is used. No, that=B4s not ok.
> =

> Think about an echo 1 > /sys/class/graphics/fbcon/detach inside of an
> xterm session.
> =

> I think we need new fbops, eg.
> =

>     int fb_fbcon_unbind(...)
>     int fb_fbcon_bind(...)
> =

> If these are not implemented, unbinding is not allowed. Any requests to do
> so will be ignored.

We'll use fb_restore_state and fb_save_state if available, yes, but I don't
think we need to implement unbind and bind.  For one, as Jon and Andrew
has pointed out, drivers should have no concept of binding. (That's why the
patch has escalated to VT binding).

And why force drivers to have an fb_restore_state/fb_save_state just to
unbind/bind?  This is going to penalize 10's of drivers that don't need
it.  Just make this feature an experimental kconfig option, or make this
available as a boot option.

This feature is in a state of flux, so this is definitely not its final
form, nor the last one in a series.  The main goal here is to make the fbdev
system synchronize with other tools/modules whether it be for state
preservation, assistance on mode setting, etc. We need this if we are going
to make the different architectures work together.

Tony
