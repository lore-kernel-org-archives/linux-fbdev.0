From: James Simmons <jsimmons@infradead.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Date: Thu, 23 Oct 2003 23:50:48 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310232343410.21561-100000@phoenix.infradead.org>
References: <20031023144315.GA667@phunnypharm.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACoOy-0005RH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 15:57:56 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1ACoIH-0008NF-6z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Oct 2003 15:51:01 -0700
In-Reply-To: <20031023144315.GA667@phunnypharm.org>
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
To: Ben Collins <bcollins@debian.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> The cursor has changed from a nice underline to a solid white block. 

I seen the problem. Its the wrong color for the background color for the 
cursor. I haven't been able to figure out why it went wrong. The specs are 
not to clear on this.

> Not only that,
> but the block is bigger than the font it is over (if I am on top of
> adjacent letters, it covers the entire letter I am on, plus a couple of
> pixels of the letter to the right).

Ug. That code is straight from the old driver. Will fix.

> In additition, the cursor now disappears while typing, and navigating
> around (on the command line left and right, or even in an editor when
> moving the cursor up and down). This disappearing while typing or
> navigating is _really_ annoying. If I go left or right a lot, I have to
> keep stopping to see where the cursor actually is.

I seen this problem last night with the NVIDIA fbdev driver. I think I 
know what the problem is. I will try a fix tonight. 




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
