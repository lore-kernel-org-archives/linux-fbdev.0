From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][FBDEV] Fix copy_to/from_user in fbmem.c:fb_read/write
Date: Mon, 30 Aug 2004 19:58:56 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408301958.56449.adaplas@hotpop.com>
References: <200408301047.28117.adaplas@hotpop.com> <Pine.GSO.4.58.0408301107430.3353@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1koB-0005H9-Mj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 04:58:47 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C1koA-0004Uo-MS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 04:58:47 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 813F57C01CA
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 30 Aug 2004 11:58:30 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0408301107430.3353@waterleaf.sonytel.be>
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
Cc: Andrew Morton <akpm@osdl.org>, "David S.Miller" <davem@redhat.com>

On Monday 30 August 2004 17:10, Geert Uytterhoeven wrote:
>
> I don't expect the penalty for always using a buffer of PAGE_SIZE to be
> very large. Or am I missing something?
>

You're absolutely correct, there is no significant performance penalty whether
using a small or large-sized buffer.

Will resubmit a patch.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
