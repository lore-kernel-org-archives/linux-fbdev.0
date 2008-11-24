From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Radeon framebuffer not working on MSI
	K9A2VM-FD
Date: Mon, 24 Nov 2008 12:56:01 -0500
Message-ID: <a728f9f90811240956u117633adq491ec67481066269@mail.gmail.com>
References: <Pine.LNX.4.61.0811240942470.21079@jericho.melzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alexdeucher@gmail.com>) id 1L4ffK-0004Z4-MY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 17:56:06 +0000
Received: from ey-out-1920.google.com ([74.125.78.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L4ffH-0007eR-6A for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 17:56:06 +0000
Received: by ey-out-1920.google.com with SMTP id 4so893310eyk.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 24 Nov 2008 09:56:01 -0800 (PST)
In-Reply-To: <Pine.LNX.4.61.0811240942470.21079@jericho.melzone.de>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Karim 'Kasi Mir' Senoucci <lists@tvetc.de>
Cc: Linux-fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Nov 24, 2008 at 3:59 AM, Karim 'Kasi Mir' Senoucci
<lists@tvetc.de> wrote:
> Hello all,
> I cannot get the Radeon kernel framebuffer to work with the above MSI
> mainboard which uses a AMD780V chipset featuring what the call Radeon
> HD 3100 on-board graphics.
>
> I'm running a Ubuntu server 8.04.1 on the machine and have tried the
> kernel image supplied with the distibution, a self-compiled kernel based
> on the Ubuntu sources (both 2.6.24) and a current kernel.org version
> (2.6.27.7). I tried to compile the Radeon framebuffer into the kernel as
> well as compiling it as a module. I can use the vesafb frame buffer
> (which is slow as hell) but the radeon framebuffer driver does not work
> in any of the settings. I don't get any output whatsoever when I load
> the module, not a single line in syslog or via dmesg. I fact, I only
> know the module is loaded becaus it is listed with lsmod.

radeonfb does not support your chip.  if you want an fb console you'll
either have to use vesa or the new drm modesetting stuff.

Alex

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
