From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Question] sumbit VIAFB driver
Date: Wed, 7 May 2008 02:08:04 -0700
Message-ID: <20080507020804.980c85bb.akpm@linux-foundation.org>
References: <20080506114450.8be56880.akpm@linux-foundation.org>
	<C80EF34A3D2E494DBAF9AC29C7AE4EB806F6751F@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtfdQ-0002wB-WE for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 02:08:25 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtfdP-0000Hy-Ld
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 02:08:24 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6751F@exchtp03.taipei.via.com.tw>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: JosephChan@via.com.tw
Cc: linux-fbdev-devel@lists.sourceforge.net, geert@linux-m68k.org

On Wed, 7 May 2008 16:52:41 +0800 <JosephChan@via.com.tw> wrote:

> Hi Andrew,
> 
> I've tried to split the patch into parts and sent to linux-fbdev-devel.
> But I got returned mail, it seems to be my patch was banned by
> linux-fbdev-devel.
> I'm not sure it is caused by the large splitted patch (1400~1700 lines
> per patch).
> Would you please tell me how to solve this issue? Thanks.
> 
> In addition, may I send you the "BIG" one patch directly?

I'd suggest that you send the 11 patches and cc
linux-kernel@vger.kernel.org instead.  You might as well cc
linux-fbdev-devel as well.  The patches will get lost but at least the
resulting discussion will be archived.

But first please fix your email client!  The patch you just sent was
workwrapped.  Email the patches to yourself first, make sure that they all
apply OK.



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
