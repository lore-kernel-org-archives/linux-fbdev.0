From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Fw: [PATCH 2/3] DEC PMAG BA frame buffer
 update
Date: Mon, 8 Aug 2005 13:18:51 +0100 (BST)
Message-ID: <Pine.LNX.4.61L.0508081312340.29382@blysk.ds.pg.gda.pl>
References: <20050803215954.47d3cfc1.akpm@osdl.org> <42F5E162.4070400@gmail.com>
 <20050808104845.GB5705@linux-mips.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E26am-0002Xw-KA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 05:18:56 -0700
Received: from pollux.ds.pg.gda.pl ([153.19.208.7] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E26al-00041B-7E
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 05:18:56 -0700
In-Reply-To: <20050808104845.GB5705@linux-mips.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>

On Mon, 8 Aug 2005, Ralf Baechle wrote:

> > PS: Is it possible to port this to the driver model?
> 
> Later.  The whole DECstation port is still in the phase of resurrection for
> 2.6.  For now I think other DECstation subsystems will have priority.

 The TURBOchannel layer has to be modernised first.  For the CX frame 
buffer that does not do DMA it may not matter much, but still we need to 
do work in the right order.

  Maciej


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
