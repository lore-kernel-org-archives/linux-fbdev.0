From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 3/3][FBDEV]: Set capabilities flag for vesafb and vga16fb
Date: Tue, 6 Jul 2004 18:30:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407061830.37554.adaplas@hotpop.com>
References: <200407060634.43963.adaplas@hotpop.com> <20040706053545.GA2375@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhnDK-000890-RV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 03:30:14 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BhnDK-0000xV-Fp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 03:30:14 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id DBEDBFE4079
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  6 Jul 2004 10:10:02 +0000 (UTC)
In-Reply-To: <20040706053545.GA2375@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 06 July 2004 13:35, David Eger wrote:
> Thanks for getting these; I've been lazy and not gotten to them.
>

My intent was to demonstrate the PAN_REDRAW patch, and 
FBINFO_HWACCEL_YPAN must be set for that :-) And I chose
vesafb and vga16fb since they're the most commonly used drivers
in the x86 world.

> I do want FBINFO_FLAG_DEFAULT to go away though... it's now

Hmm, okay, I did not know that.

> FBINFO_DEFAULT.  I also don't see anything in vga16fb that precludes
> FBINFO_HWACCEL_XPAN, though I don't see anyone who uses that flag,
> either.  *shrug*

Well, fbcon does not use x-panning at all, so, yes, it's a useless flag, not
just for vga16fb but for all drivrers.  Userspace uses x-panning though, but 
they check xpanstep instead.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
