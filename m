From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] fix mach64_gx.c
Date: Sat, 3 May 2003 08:09:14 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <16050.60554.651489.795368@argo.ozlabs.ibm.com>
References: <16050.3732.615164.697680@argo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0305022106110.15173-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Biix-0002uO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 02 May 2003 15:09:47 -0700
In-Reply-To: <Pine.LNX.4.44.0305022106110.15173-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

James Simmons writes:

>    Has anyone tested this chipset on a PPC 64?

There aren't any PPC64 boxes with this chipset (ATI Mach64 GX), since
all past and current PPC64 boxes are IBM servers.  I suppose one could
find an old ATI Mach64 PCI card and put it in a PPC64 box, but I don't
know why you would do that instead of putting in a PCI radeon or
something. :)

Regards,
Paul.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
