From: "Christopher Hoover" <ch@murgatroid.com>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Wed, 7 May 2003 01:33:05 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <006801c31473$47bd51d0$7900000a@bergamot>
References: <Pine.LNX.4.44.0305070546590.2974-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139] helo=heavens.murgatroid.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DKMc-0004SX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 01:33:22 -0700
In-Reply-To: <Pine.LNX.4.44.0305070546590.2974-100000@phoenix.infradead.org>
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
To: 'James Simmons' <jsimmons@infradead.org>
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net


The cfb generic code works wonderfully well on the EP7212 CPU/EPSON 1355
because the processor can do the math in 32-bits just fine, it just
needs to issue 16-bit reads and writes to the framebuffer memory.  Since
you had that nice FB{READ|WRITE} abstraction in there, it was easy to
make a small tweak to be able to use my own FB{READ|WRITE} routines that
break each (aligned) FB{READ|WRITE} into two 16-bit reads/writes.
That's all that has to happen.  I inlined the speical fb{read|write}
routines and got good code with decent performance.

What I'm hearing is that you woud prefer that I include my own routines
over the pre-processor hackery.  Be warned that it is mostly going to be
a cut-n-paste job -- even if I wrote the routines totally from scratch I
would handle 32-bits of pixel(s) at a time.

I shall plow forward ...

-ch



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
