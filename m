From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb: blanking patch done
Date: Sun, 25 Apr 2004 04:58:05 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404250445200.24252-100000@phoenix.infradead.org>
References: <20040424073934.GA23738@foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHamO-00075K-JR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 20:58:08 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BHamO-0004s2-80
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 20:58:08 -0700
In-Reply-To: <20040424073934.GA23738@foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


I merged your changes. The latest patch is here:

http://phoenix.infradead.org:~/jsimmons/neofb-4.1.diff.gz


On Sat, 24 Apr 2004, Alex Stewart wrote:

> Ok, I sorted out the issues with the blanking patch, fixed it up to use the new
> vga core routines, and did a little bit of miscellaneous cleanup.  It works for
> me; feedback is welcome.
> 
> Patch is attached, and also available at http://www.foogod.com/~alex/neofb
> 
> (this patch is against James' latest driver patch)
> 
> -alex
> 




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
