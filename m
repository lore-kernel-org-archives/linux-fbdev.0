From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 16:41:00 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408091641.00570.adaplas@hotpop.com>
References: <200408090944.01414.adaplas@hotpop.com> <Pine.GSO.4.58.0408090920511.14159@waterleaf.sonytel.be> <20040809010326.305620a7.akpm@osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu5iU-0000Rg-Dw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:41:14 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bu5iU-0002wt-3K
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:41:14 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 290A6105E552
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 08:14:36 +0000 (UTC)
In-Reply-To: <20040809010326.305620a7.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Monday 09 August 2004 16:03, Andrew Morton wrote:

> >   - private modedb:
> >       - increase memory footprint by full mode database per driver.
> >       - more complex (and larger) code
> >       - subtle differences with 2.4, because not the whole var is saved
> >         (BTW, which fields do you want to save, and which not, so I can
> > 	 evaluate the impact on some drivers?)
>
> Well gee.  If we're talking about 3k, or even 10k or 30k, let's go with the
> simplest code?
>

The simplest code is adding per-display var and removing stty/resize support.
If stty/resize support is needed, then we need a per-driver mode database.
Using fb_find_mode() + default modedb is no guarantee.

Best to wait for the other developers to respond.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
