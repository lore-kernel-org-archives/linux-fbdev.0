From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add damage support
Date: Fri, 30 Jan 2009 20:01:42 +0900
Message-ID: <aec7e5c30901300301o74937c9fvb8c59bb6739a84d6@mail.gmail.com>
References: <12328857453626-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LSr86-0002mu-KE
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jan 2009 11:01:46 +0000
Received: from fg-out-1718.google.com ([72.14.220.156])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LSr84-0002qY-HI for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jan 2009 11:01:46 +0000
Received: by fg-out-1718.google.com with SMTP id 16so293058fgg.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 Jan 2009 03:01:42 -0800 (PST)
In-Reply-To: <12328857453626-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Sun, Jan 25, 2009 at 9:15 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> This is version 2 of an idea about allowing userspace to provide damage
> information to drivers. Thanks to Magnus, Tomi, and others for discussion
> and ideas.

...

> This patch adds the ability for userspace applications to provide damage
> information to the underlying driver. This is useful in scenarios where the
> underlying driver can perform transfer optimizations based on knowing
> exactly which framebuffer areas that were updated. This functionality is
> exposed by using a simple x,y,w,h bounding box structure. Userspace is
> expected to perform its damage and then perform the ioctl. The underlying
> driver is free to use this information as it sees fit including ignoring it
> if it chooses to. An example use case will be provided in the case of
> broadsheetfb.c where the damage information is aggregated for deferred use.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Cc: armbru@redhat.com
> Cc: lethal@linux-sh.org
> Cc: adaplas@gmail.com
> Cc: linux-fbdev-devel@lists.sourceforge.net
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

Looking good except that the patch doesn't apply on new kernels.

Acked-by: Magnus Damm <damm@igel.co.jp>

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
