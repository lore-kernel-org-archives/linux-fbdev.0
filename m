From: James Simmons <jsimmons@infradead.org>
Subject: fbdev and power management
Date: Wed, 9 Jul 2003 00:25:28 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
References: <20030704042052.GL4359@himi.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19a1qY-0004mP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 08 Jul 2003 16:26:06 -0700
In-Reply-To: <20030704042052.GL4359@himi.org>
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I'm trying to get the radeon M6 in my new Fujitsu Lifebook to handle
> ACPI S3 suspend and resume properly - at the moment, on resume it
> fails to do anything. Looking at the driver, the reason is quite
> obvious (no .suspend and .resume functions defined), but the driver
> file has code to handle these (apparently only for the PowerBooks,
> since it's wrapped in a #ifdef CONIG_PMAC_PBOOK). My Lifebook P2120
> is a Crusoe 5800 based setup, with a PCI M6, so it's not even being
> built, let alone enabled and used. 
> 
> As far as I can tell, if I removed the #ifdef CONFIG_PMAC_PBOOK and
> split the current radeon_set_suspend up into suspend and resume
> functions to fit the current power management stuff, it might have
> some chance of working. Can you tell me if this is a reasonable
> first step?
> 
> Alternatively, if you have patches that I could test, I'd be quite
> happy to give them a go - being a guinea pig sounds like fun ;-)

No patches at this time. I need to learn the new power management code. 
Where are the docs for them ? 




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
