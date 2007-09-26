From: Jerald Fitzjerald <jfj@freemail.gr>
Subject: Re: Plans for 2D acceleration
Date: Wed, 26 Sep 2007 07:29:52 -0700
Message-ID: <46FA6CE0.8050004@freemail.gr>
References: <46FA4579.6040905@freemail.gr>
	<1190807127.27064.2.camel@tveimo-laptop>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaXt9-0004bH-7v for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 07:29:19 -0700
Received: from rosebud.otenet.gr ([195.170.0.94] ident=OTEnet-mail-system)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaXt7-0000nI-EG
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 07:29:19 -0700
Received: from [85.75.213.93] (athedsl-171455.home.otenet.gr [85.75.213.93])
	by rosebud.otenet.gr (8.13.8/8.13.8/Debian-3) with ESMTP id
	l8QETEeC021812 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 26 Sep 2007 17:29:14 +0300
In-Reply-To: <1190807127.27064.2.camel@tveimo-laptop>
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

Torgeir Veimo wrote:

>On Wed, 2007-09-26 at 04:41 -0700, Jerald Fitzjerald wrote:
>  
>
>>Is there a reason we _don't_ want these exposed to userland or
>>just nobody has taken the time to do it? 
>>    
>>
>
>You can do all of these using DirectFB. Is that not an option for you?
>
>  
>
Well, the code is already in the kernel for various cards as far as I 
can tell.
It's just a matter of exposing the functionality through some ioctl.

Won't even DirectFB benefit from that? (not to mention it'll be able to use
the features without iopl)


jf


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
