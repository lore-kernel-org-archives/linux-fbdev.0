From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: printk change in 2.6.18?
Date: Wed, 19 Jul 2006 11:38:35 -0400
Message-ID: <8FFCA31D-B54F-4686-A5B0-0D9F7B2B9C20@cecropia.com>
References: <1756A939-0BF4-48F1-9CEC-DB468306073C@cecropia.com>
	<44BD72BB.2090000@gmail.com>
	<93DE4F1B-CF8B-4E72-8323-7869C9098728@cecropia.com>
	<44BE1E32.9060407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G3E6k-0002S7-LC for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Jul 2006 08:37:06 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G3E6j-00039B-CY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Jul 2006 08:37:06 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.132])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	19 Jul 2006 15:36:59 -0000
In-Reply-To: <44BE1E32.9060407@gmail.com>
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
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


On Jul 19, 2006, at 7:57 AM, Antonino A. Daplas wrote:

> You mean, if you type 'dmesg', you don't see the printk's? All  
> printk's
> should at least reach the logbuffer, but if it doesn't even reach the
> logbuffer level, then the problem is very high up.

ok, i just took a look at dmesg -- i had to expand the buffer for  
dmesg, but the printk's are showing up there.  So, something is  
causing them to not be sent to earlyprintk (i don't have any kernel  
output going to the console).

either way, i'm okay for now -- i'll take a look at this again once I  
have some spare cycles.

dennis

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
