From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: /usr/src/linux/Documentation/fb/aty128fb.txt (fwd)
Date: Tue, 5 Oct 2004 11:01:01 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410051101.01409.adaplas@hotpop.com>
References: <Pine.GSO.4.61.0410042119240.19047@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEfaP-00047c-BS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 20:01:57 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEfaK-0003aj-3v
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 20:01:56 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 70C458B3BBF
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  5 Oct 2004 03:00:58 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.61.0410042119240.19047@waterleaf.sonytel.be>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eric Pretorious <eric@pretorious.net>

On Tuesday 05 October 2004 03:19, Geert Uytterhoeven wrote:
> ---------- Forwarded message ----------
> Date: Mon, 4 Oct 2004 11:59:47 -0700
> From: Eric Pretorious <eric@pretorious.net>
> To: Brad Douglas <brad@neruo.com>
> Cc: geert@linux-m68k.org
> Subject: /usr/src/linux/Documentation/fb/aty128fb.txt
>
> Hi, Brad:
>
> One other nitpick: In the "Configuration" section you wrote...
>
> >Accepted options:
> >
> ><XxX@X>  - selects startup videomode. See modedb.txt for detailed
> >           explanation. Default is 640x480x8bpp.
>
> Should the values be enclosed - as illustrated - in brackets? (I've been

No. Parameters in brackets are meant to be optional.

> passing the value using the "vga=0x317".) The framebuffer.txt file
> describes it like this...

The option "vga=xxx" is only for drivers that lets the BIOS do the mode
setup for them.  Some of these drivers are vesafb and matroxfb.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
