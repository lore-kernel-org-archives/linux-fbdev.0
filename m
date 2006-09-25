From: jfj <jfj@freemail.gr>
Subject: Re: Status of WAITFORVSYNC (waitretrace)
Date: Mon, 25 Sep 2006 06:23:44 -0700
Message-ID: <4517D860.8080603@freemail.gr>
References: <45165586.2@freemail.gr>
	<96AEB292-5B41-4436-80C4-104EE418556C@pobox.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRqPf-00074V-RU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 06:22:24 -0700
Received: from rosebud.otenet.gr ([195.170.0.94] ident=OTEnet-mail-system)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRqPf-0006nn-5U
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 06:22:23 -0700
Received: from [85.75.141.31] (athedsl-152961.otenet.gr [85.75.141.31])
	by rosebud.otenet.gr (8.13.4.20060308/8.13.4/Debian-9) with ESMTP id
	k8PDMG4S010370 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 25 Sep 2006 16:22:16 +0300
In-Reply-To: <96AEB292-5B41-4436-80C4-104EE418556C@pobox.com>
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

Torgeir Veimo wrote:

>My patch for radeonfb was turned down since using that ioctl might  
>freeze kernel if the drm kernel module is active and is using the  
>same interrupt. I think an alternative option would be to disable it  
>by default unless a kernel module param is set when loading radeonfb,  
>since it's currently a bit difficult to get inter module  
>communication between the drm and radeonfb modules. I never got  
>around to resubmit a modified patch though.
>
>  
>

Wow. What a mess.  If two different subsystems (fb and drm) implement
access to the same hardware, serious problems like this can happen
(at least if one is using X and fb programs at the same time), as
well as duplicate work, increasing size of the kernel, maintenance
troubles, etc.

The right way to solve this, would be a common sub-subsystem which
should be shared between drm and fb, but that's very hairy and
nobody is going to do it.

It's a pity though because WAITFORVSYNC is an important function
to do nice stuff with the framebuffer, there is interest from people
to implement this for the various cards, there is interest from the
userspace to use it, it adds very little code to the kernel and it
improves the overall functionallity of the framebuffer system :(

(and even the polling & watchdog method would be acceptable, because
that's what people do in the end from userland, with iopl() and inb()).

jf


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
