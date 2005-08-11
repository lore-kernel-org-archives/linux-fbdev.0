From: James Simmons <jsimmons@infradead.org>
Subject: Re: cursor maddnes and a solution
Date: Thu, 11 Aug 2005 23:37:32 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508112201210.9641@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>
 <42F99B5E.1070309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3LgC-00012N-9H
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 15:37:40 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E3LgB-0001lB-S0
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 15:37:40 -0700
In-Reply-To: <42F99B5E.1070309@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> In the end, it seems that you, me and Jon have the same goal in mind. I don't
> see any disagreement here.

I like to see it broken up into smaller pieces. 

> And how do you propose to implement a softcursor that is not a wrapper to
> imageblit?  Using fillrect?  That's fine with me. Just take into consideration
> that an XOR Rop needs to read the contents of the framebuffer first before
> writing.  And READS are slow on most PCI cards.
> 
> What I cannot understand is your aversion against softcursor.  For fbcon,
> it works 100% of the time, guaranteed, for any kind of driver, fictional or
> otherwise.

I'm talking about if fillrect is hardware accelerated and imageblit is 
not. In this case we want to use the fillrect.

> ===========================================================================
> Anyway, I really don't have a strong argument against adding FB_ACCEL_HWCUR
> flag to fbdev.  What I'm against is the overloading of info->fbops->fb_cursor
> for userspace. I'll try to clarify:

> Now, our info->fbops->fb_cursor() accepts a parameter struct fb_cursor which is
> more than 100 bytes in size.  It has everything there in order to have a fully
> functional cursor.  But, that's a lot of bytes to move.  This is probably okay
> for the text cursor because the text cursor characteristics are usually in a
> state of flux. For the mouse cursor, on the other hand, only the position is
> usually changing.
>
> So that's why I don't want info->fbops->fb_cursor to be used in user space.  It
> is inefficient.  Why move 100 bytes of data to move the cursor to x,y? And then
> you have to take into consideration that the rate of change is very rapid.

Who said you have to move all that data at one time. We can have a struct 
fb_cursor in struct fb_info like we have for fb_cmap. Fill in default 
data. Fill in the values you want to change. Call fb_cursor fbops when you 
want the changes to take affect. Its not that hard to do.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
