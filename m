From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kyrofb support
Date: Tue, 13 Jan 2004 17:49:08 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040113174908.487893c7.akpm@osdl.org>
References: <20040114013306.GB9515@linux-sh.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aga9K-0003es-AT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 17:48:50 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aga9J-0007jG-Tg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 17:48:50 -0800
In-Reply-To: <20040114013306.GB9515@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

Paul Mundt <lethal@linux-sh.org> wrote:
>
> This patch adds support for the Kyro graphics boards (STG4000/PowerVR 3/etc.)
>  to 2.6.1. This is a direct port and substantial cleanup / rewrite of the 2.4
>  driver that's available in the sh64 tree at linux-sh.bkbits.net. Some of the
>  overlay code and the STG4000 bits are still a bit ugly, so be forewarned.

OK.  Problem is that the fbdev guys seem to be cooking up an internal API
change.  I guess we may as well merge this driver up now and modify it if
and when that API change hits the tree.



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
