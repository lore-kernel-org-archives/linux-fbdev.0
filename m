From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 12:41:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066300892.646.134.camel@gaston>
References: <20031015162056.018737f1.akpm@osdl.org>
	 <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org>
	 <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
	 <20031016101905.GA7454@casa.fluido.as>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA5ei-0004Op-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 03:46:56 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AA5dN-00006l-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 03:45:33 -0700
In-Reply-To: <20031016101905.GA7454@casa.fluido.as>
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
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, 2003-10-16 at 12:19, Carlo E. Prelz wrote:
> 	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
> 	Date: gio, ott 16, 2003 at 12:00:32 +0200
> 
> Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):
> 
> > My new driver (bk://ppc.bkbits.net/linuxppc-2.5-benh) now uses a copy
> > of XFree PCI IDs list, making it much easier to keep in sync. It should
> > also support the 9200.
> 
> The latest (*NON*bk) patch distributed by James appears to include your
> new driver. The header from radeon_base.c  reads:

I think it's an older version that James included as the current one
has support for the 9200. I'm still updating it very regulary as it's
not considered as "finished" work yet :) Though testing is welcome,
I try to keep it working at any stage.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
