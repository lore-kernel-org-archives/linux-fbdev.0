From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK FBDEV] String drawing optimizations.
Date: Thu, 15 May 2003 21:27:38 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305152104400.6330-100000@phoenix.infradead.org>
References: <20030513003427.GA19121@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19GPKq-0001U0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 May 2003 13:28:17 -0700
In-Reply-To: <20030513003427.GA19121@vana.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> What about getting rid of one-char putc, implementing it in terms of
> putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
> with current length of {fbcon,accel}_putc{s,} I was not able to find
> measurable speed difference between putc and putc through putcs variants.

Hm. I compressed all the image drawing functions into accel_putcs which is 
used in many places. I then placed accel_putc() into fbcon_putc(). I could 
have accel_putcs() called in fbcon_putc(). The advantage is smaller 
amount of code. The offset is a big more overhead plus a function call. 
What do people think here?




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
