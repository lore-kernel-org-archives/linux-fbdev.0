From: Karim 'Kasi Mir' Senoucci <lists@tvetc.de>
Subject: Re: Radeon framebuffer not working on MSI
 K9A2VM-FD
Date: Tue, 25 Nov 2008 11:01:56 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811251101210.31185@jericho.melzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1L4uku-0007UU-TF
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 10:02:52 +0000
Received: from mx1.melzone.de ([81.169.156.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L4uks-0002bZ-3P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 10:02:52 +0000
Received: from uucp by mx1.melzone.de with local-rmail (Exim 4.69)
	(envelope-from <lists@tvetc.de>) id 1L4ukp-0001oZ-4a
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 11:02:47 +0100
Received: by jericho.melzone.de with esmtp (Exim 4.62 #1) id 1L4uk0-00087F-0G 
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 11:01:56 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hello again,
On Mon, 24 Nov 2008, Alex Deucher wrote:

> On Mon, Nov 24, 2008 at 3:59 AM, Karim 'Kasi Mir' Senoucci
> <lists@tvetc.de> wrote:
> > Hello all,
> > I cannot get the Radeon kernel framebuffer to work with the above MSI
> > mainboard which uses a AMD780V chipset featuring what the call Radeon
> > HD 3100 on-board graphics.
> >
>
> radeonfb does not support your chip.  if you want an fb console you'll
> either have to use vesa or the new drm modesetting stuff.

Thanks for the info, Alex. As the vesa framebuffer is unusably slow, I'd 
like to try out the drm modesetting option, but I'm having trouble 
finding anything useful as to how to configure this. All the HowTos or 
blog entries I can find are talking about configuring X11 in conjuction 
with drm/dri kernel modules - but I just want to have a framebuffer 
console. Can you give me any pointers to a website or article that 
explains how to do this?

Greetings and Thanks in Advance
Kasi Mir


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
