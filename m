From: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Video Mode Handling
Date: Sun, 8 Aug 2004 23:04:12 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040808230412.6dc16bf4.akpm@osdl.org>
References: <200408090944.01414.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu3IG-0006mt-68
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 23:06:00 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bu3IF-0005R9-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 23:06:00 -0700
In-Reply-To: <200408090944.01414.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> Most fbdev developers are proposing to bring back the per-display var
>  structures to ease the difficulty of video mode handling.  This proposal
>  is countered by a few (notably James) in that it severely increases the 
>  memory footprint of the kernel.  

Surprised.

By how much does this increase the kernel's memory footprint?

And how much simpler would the code be if we were to bring back the
per-display var structures?

IOW: what's the tradeoff here?


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
