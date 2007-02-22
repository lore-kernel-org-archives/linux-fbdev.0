From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: bug in intelfbhw.c
Date: Thu, 22 Feb 2007 17:02:28 +0800
Message-ID: <1172134948.4086.14.camel@daplas>
References: <3E56BFF2E134A44A98D9FFDB710688DF011D3DF7@ERLD151A.ww004.siemens.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK9nn-00056n-8Z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 00:59:47 -0800
Received: from nz-out-0506.google.com ([64.233.162.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK9nm-0000Y9-1f
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 00:59:47 -0800
Received: by nz-out-0506.google.com with SMTP id i11so157908nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Feb 2007 00:59:43 -0800 (PST)
In-Reply-To: <3E56BFF2E134A44A98D9FFDB710688DF011D3DF7@ERLD151A.ww004.siemens.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Orczykowski, Juergen" <juergen.orczykowski@siemens.com>

On Thu, 2007-02-22 at 09:14 +0100, Orczykowski, Juergen wrote:
> Hello,
> 
> we would like to use your drivers in our software. While debugging we
> found a bug in calculating the ring_space.
> 
> If there is less then RING_MIN_FREE available in the ring buffer,
> dinfo->ring_space is set to a big value forcing wait_ring to return.
> 
> We have attached a possible solution to solve this bug.

Okay, I see the problem too, and your solution looks sane.  I'll make a
patch out of this, and send it to the intelfb maintainer.

Thanks.

Tony
	



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
