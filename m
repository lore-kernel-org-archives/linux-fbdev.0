From: James Simmons <jsimmons@infradead.org>
Subject: Re: Fix softcursor in 2.6.X
Date: Thu, 8 Jan 2004 01:13:39 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401072045500.31020-100000@phoenix.infradead.org>
References: <20040103153310.GA617@elf.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeOkB-0002OT-Lh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 17:13:51 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AeOkB-0003nr-3p
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 17:13:51 -0800
In-Reply-To: <20040103153310.GA617@elf.ucw.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>, Andrew Morton <akpm@zip.com.au>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Hi!
> 
> Softcursor was broken for half of 2.5 series. This fixes it by first
> hiding cursor _then_ hiding softcursor. Very simple mistake... Please
> apply,

Just tested with vgacon, fbcon with software cursor and hardware cursor. 
It worked!!!!! 

Thank you, Thank you.



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
