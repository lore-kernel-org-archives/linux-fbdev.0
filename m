From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Sun, 11 Jun 2006 15:25:43 +0200
Message-ID: <448C19D7.5010706@t-online.de>
References: <44856223.9010606@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpPvY-0003hS-M7 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 06:24:28 -0700
Received: from mailout08.sul.t-online.com ([194.25.134.20])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpPvV-0007R7-28
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Jun 2006 06:24:25 -0700
In-Reply-To: <44856223.9010606@gmail.com>
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

Antonino A. Daplas wrote:

>Overall, this feature is a great help for developers working in the
>framebuffer or console layer.  =

>
Well, it has long been possible to load / unload framebuffer hardware
drivers using the vfb module as an intermediate step. It even has been
possible to load both vesafb and another framebuffer driver for the same
hardware, to assign vesafb to tty{a,b,c..}, the other framebuffer driver
to tty{m,n,o...} and to switch between those drivers using the usual
keyboard hotkeys.

So the main addition of your patchset is the possibility to replace
fbcon and helper modules, a nice feature I missed in the past.

But should a framebuffer driver terminate and leave the hardware in
graphics mode or in text mode? Up to now that was not a real question,
as we all knew that another framebuffer driver would take over control.
With your patches it is possible that a user really wants to switch to text
mode and to remove the complete fbcon layer. So should we switch the
hardware to text mode upon unloading a framebuffer driver?

Maybe unbinding of the framebuffer console is not followed by an
unloading of the framebuffer module. You tell us that an
"echo 1 > /sys/class/graphics/fbcon/detach" has the simple effect of a
corrupt display unless vbetools is used. No, that=B4s not ok.

Think about an echo 1 > /sys/class/graphics/fbcon/detach inside of an
xterm session.

I think we need new fbops, eg.

    int fb_fbcon_unbind(...)
    int fb_fbcon_bind(...)

If these are not implemented, unbinding is not allowed. Any requests to do
so will be ignored.

If these are implemented the fbcon_unbind() function of the framebuffer
driver is called first. If it does not return an error, unbinding can =

continue,
otherwise it fails.

With implemented fb_restore_state() and fb_save_state() fbops the =

framebuffer
driver knows best about the current hardware state and can act in a way that
there is no need for vbetools & friends as well as no possibility of fatal
interactions with X.

Unbinding requests should only be honored if the framebuffer driver decides
that it is safe. Don=B4t enable it by default.

cu,
 knut
