From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Tue, 6 May 2003 20:03:38 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305061957430.14356-100000@phoenix.infradead.org>
References: <20030501140415.A4518@heavens.murgatroid.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19D7ja-0001t9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 May 2003 12:04:15 -0700
In-Reply-To: <20030501140415.A4518@heavens.murgatroid.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christopher Hoover <ch@murgatroid.com>
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net


> Here's a patch, close to a complete rewrite, that makes the Epson
> 1355/SED355/S1D1305 work under 2.5.  I tested it thoroughly in 5/6/5
> truecolor mode on a Ceiva.
> 
> N.B., I hacked cfb* a bit so that I could use that code with my own
> versions of fb_{read|write}*.  This was necessary as this controller
> only supports 16-bit accesses (at least on ARM ep7212-based Ceiva
> platform).

Your patched bombed on epson1355fb.c. Could you send me your file you are 
using for it. Also please don't modify the cfb_* functions. I'm familiar 
with the epson chipsets and the 16 bit access issue. I recommend you write
your own acceleration functions. In fact I really recommend you use the 
hardware acceleration. I know thw epson 1385 chip I worked on had 
acceleration. 




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
