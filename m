From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Fri, 23 Apr 2004 17:07:33 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404231707040.3463-100000@phoenix.infradead.org>
References: <20040423040313.GA4403@foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH3DF-0003uI-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:07:37 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH3DF-00020p-G4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 09:07:37 -0700
In-Reply-To: <20040423040313.GA4403@foogod.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>


Applied. I wonder if this means that the neofb can go back and forth to 
vga text mode :-)

On Thu, 22 Apr 2004, Alex Stewart wrote:

> Well, I downloaded your diff for the neofb driver and tried it out.  I did
> notice there appears to be a slight bug in it.  Whenever anything (such as
> fbset) closes /dev/fb0, the driver clobbers the device registers (resulting in
> a blank screen).
> 
> I'm assuming the attached correction is more what was intended..
> 
> I'm currently merging our two sets of patches into one driver.  I do note that
> patch gets a little confused when trying to do it itself and places a couple of
> bits of code in really odd places, which might have been part of why it didn't
> work for you.  I think I should have an updated patchset ready to post later
> tonight..
> 
> -alex
> 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
