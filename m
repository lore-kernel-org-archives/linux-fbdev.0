From: Richard Wolf <rwolf@cardaccess.com.au>
Subject: Re: Driver for Sharp LH155BA
Date: Wed, 2 Aug 2006 11:00:42 +1000
Message-ID: <170385E48B041543AC99CCD09E325AD1952C32@mail.elevenonline.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G84ph-00046l-IY for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Aug 2006 17:43:33 -0700
Received: from [203.166.87.76] (helo=mail1.cardaccess.com.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G84pg-0003Op-5s
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 01 Aug 2006 17:43:33 -0700
Received: from MAIL.cardaccess.com.au (mail.fivestarstudios.com.au
	[203.41.80.28])
	by mail1.cardaccess.com.au (Postfix) with ESMTP id A4836D3437
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed,  2 Aug 2006 10:42:39 +1000 (EST)
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

 

> -----Original Message-----
> From: linux-fbdev-devel-bounces@lists.sourceforge.net 
> [mailto:linux-fbdev-devel-bounces@lists.sourceforge.net] On 
> Behalf Of Markus Schorer
> Sent: Tuesday, 1 August 2006 4:58 PM
> To: linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: [Linux-fbdev-devel] Driver for Sharp LH155BA
> 
> Antonino A. Daplas wrote:
> > Richard Wolf wrote:
> >> Presumably if I take the shadow buffer route then I could maintain 
> >> _two_ shadow buffers.  This would allow me to detect 
> whether the user 
> >> accessible buffer had been changed and update the display 
> only when necessary.
> > 
> > Yes, that will work too.
> > 
> 
> check for the epson SED15xx (not sure) driver. sounds like 
> similar hardware, same approach.
> 
> markus
> --

Excellent, thanks.

Richard

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
