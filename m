From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: monitor detection through ddc/edid stuff.
Date: Sun, 12 Sep 2004 17:32:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409121732.45011.adaplas@hotpop.com>
References: <20040910111627.GA14811@pegasos> <20040911153625.GA3507@dreamland.darkstar.lan> <20040912084240.GA21563@pegasos>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6QjA-0006zl-44
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 02:32:56 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6Qj7-0000Wi-Ew
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 02:32:56 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id CE866753B0
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Sep 2004 09:32:33 +0000 (UTC)
In-Reply-To: <20040912084240.GA21563@pegasos>
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
To: linux-fbdev-devel@lists.sourceforge.net, Sven Luther <sven.luther@wanadoo.fr>

On Sunday 12 September 2004 16:42, Sven Luther wrote:
>
> Now, another question which has me baffled. In set_par, i set the video
> mode for the card, but i only seem to have access to the bpp, and not the
> actual depth. Since i can distinguish between depth 15 (5551) and 16
> (5650), as well as between depth 24 (8888) and 30 (AAA2), where do i get
> the information concerning the actual depth used from ?
>

var->green.length

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
