From: James Simmons <jsimmons@infradead.org>
Subject: Re: Soft cursor woes (?) in fbdev-2.5
Date: Fri, 3 Oct 2003 18:38:12 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310031835530.4484-100000@phoenix.infradead.org>
References: <XFMail.20031002000358.jim.hague@acm.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A5Tsi-0002I0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 03 Oct 2003 10:38:20 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A5Tsh-0005Np-G6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Oct 2003 10:38:19 -0700
In-Reply-To: <XFMail.20031002000358.jim.hague@acm.org>
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
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Q1: Does any other driver that uses the soft cursor routines exhibit similar?
> Graphics mode is 1280x1024@74, depth 8, FWIW.

In Linus tree the cursor code is centered around the soft cursor. In the 
fbdev tree the cursor code is hardware cursor friendly. Unfortunelty it 
breaks the software cursor. You could implement the hardware cursor :-)
I can help you with this!!




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
