From: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] cg*: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 16:27:05 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915162705.24913719.davem@redhat.com>
References: <20030915194259.GG16370@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z2vd-0005n3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 16:38:45 -0700
Received: from pizda.ninka.net ([216.101.162.242] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z2vc-0000PV-Hg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 16:38:44 -0700
In-Reply-To: <20030915194259.GG16370@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: kronos@kronoz.cjb.net
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

On Mon, 15 Sep 2003 21:42:59 +0200
Kronos <kronos@kronoz.cjb.net> wrote:

> this patch converts driver/video/cg*.c to framebuffer_alloc:

This patch also does not apply cleanly to current 2.6.x sources.

Are these patches against some special set of framebuffer changes
that are not in 2.6.x yet?

If so, could you _PLEASE_ indicate this when you send patches
directly to me?  When I see a patch that I'm sent directly, I
expect that this means I should apply it to my tree and that the
patch works with current vanilla sources.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
