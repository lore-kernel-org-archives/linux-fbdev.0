From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Re: Questions about fbdriver integration
Date: Sat, 24 Nov 2007 23:14:47 +0100
Message-ID: <20071124221447.GF3183@pruts.nl>
References: <20071124214325.GD3183@pruts.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iw3H8-00089L-VO for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Nov 2007 14:14:59 -0800
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iw3H8-0004AR-JU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Nov 2007 14:14:58 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pruts.nl (Postfix) with ESMTP id 9385F12E425
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Nov 2007 23:14:57 +0100 (CET)
Received: from iron.pruts.nl ([127.0.0.1])
	by localhost (iron.pruts.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZGfjJJcRkei
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Nov 2007 23:14:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071124214325.GD3183@pruts.nl>
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
To: linux-fbdev-devel@lists.sourceforge.net


(Sorry for replying to my own post this soon) 
 
* On 2007-11-24 Ico Doornekamp <fbdev@zevv.nl> wrote : 
 
> It's very similar to the hecubafb driver, and uses deferred IO. 
 
Anyway, it is *supposed* to use deferred IO, but I suspect this is where 
my problem is. If I understand right, the fb_defio code should handle 
the mmap()ing of the framebuffer device for me, and run my callback 
whenever a write occured to the fb memory. I guess something is not 
right here, since the callback never gets to run when doing mmap() from 
userspace, or when using the fbcon module. 
 
Is the deferred IO code currently known to work properly ? 
 
Thanks again, 
 
Ico 

-- 
:wq
^X^Cy^K^X^C^C^C^C

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
