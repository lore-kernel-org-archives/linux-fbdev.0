From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] cg*: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 15:46:03 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030916134603.GA1209@dreamland.darkstar.lan>
References: <20030915194259.GG16370@dreamland.darkstar.lan> <20030915162705.24913719.davem@redhat.com>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zGAJ-0005xM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 06:46:47 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zGAI-0007LY-Gq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 06:46:46 -0700
Content-Disposition: inline
In-Reply-To: <20030915162705.24913719.davem@redhat.com>
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
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

Il Mon, Sep 15, 2003 at 04:27:05PM -0700, David S. Miller ha scritto: 
> > this patch converts driver/video/cg*.c to framebuffer_alloc:
> 
> This patch also does not apply cleanly to current 2.6.x sources.
> 
> Are these patches against some special set of framebuffer changes
> that are not in 2.6.x yet?

They are against James Simmons bk tree. You can find core changes on
fbdev or here:

http://web.tiscali.it/kronoz/linux/fbdev-class_dev-fbmem.c.diff

> If so, could you _PLEASE_ indicate this when you send patches
> directly to me?  

Yes sorry. Mails were created by a script, I've been too vague.

Btw, how do the patches look?

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
