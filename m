From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH]: rivafb, use framebuffer_alloc
Date: Mon, 27 Sep 2004 08:10:40 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409270810.40336.adaplas@hotpop.com>
References: <20040926092750.GA3936@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBj75-0002qe-3Y
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 17:11:31 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CBj74-00074X-Ky
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 17:11:31 -0700
In-Reply-To: <20040926092750.GA3936@bogon.ms20.nix>
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
To: linux-fbdev-devel@lists.sourceforge.net, Guido Guenther <agx@sigxcpu.org>
Cc: linux-fbdev-devel@lists.sf.net

On Sunday 26 September 2004 17:27, Guido Guenther wrote:
> Hi,
> attached patch against 2.6.9-rc2 converts rivafb to use
> framebuffer_alloc and tries to be more specific about the errors that
> occure during init. Please apply.

rivafb in Andrew's tree is already converted to framebuffer_alloc/release.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
