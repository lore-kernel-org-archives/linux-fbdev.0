From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: monitor detection through ddc/edid stuff.
Date: Mon, 13 Sep 2004 05:16:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409130516.55866.adaplas@hotpop.com>
References: <20040910111627.GA14811@pegasos> <200409121811.01426.adaplas@hotpop.com> <20040912143632.GA31746@pegasos>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6bia-0007d1-Bj
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 14:17:04 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6biZ-0004ZX-Hw
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 14:17:04 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BE46B7E3555
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Sep 2004 21:16:42 +0000 (UTC)
In-Reply-To: <20040912143632.GA31746@pegasos>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Sven Luther <sven.luther@wanadoo.fr>, adaplas@pol.net

On Sunday 12 September 2004 22:36, Sven Luther wrote:
> if (fix->visual == FB_VISUAL_TRUECOLOR || fix->visual ==
> FB_VISUAL_DIRECTCOLOR) depth = var->green.length + var->red.length +
> var->blue.length;
> else
> 	depth = var->green.length
>
> instead. Hope this is ok.
>

Yes, that should cover most of the visuals.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
