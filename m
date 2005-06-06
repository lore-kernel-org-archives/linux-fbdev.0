From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: fbdev hardware cursor support
Date: Mon, 6 Jun 2005 19:42:26 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506061940550.16950@pentafluge.infradead.org>
References: <9e473391050524224063df2372@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfMYY-00015R-NB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 11:42:38 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DfMYX-0007Y0-8O
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 11:42:38 -0700
In-Reply-To: <9e473391050524224063df2372@mail.gmail.com>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>



On Wed, 25 May 2005, Jon Smirl wrote:

> What is the status of fbdev hardware cursor support? I see the ioctl
> is disabled in the driver.
> 
> If a driver is using the softcursor support would the ioctl control that cursor?
> Does softcursor work in a bitmap graphics mode?
> 
> The EGL based 

Some time ago we had userland cursor support but it was removed :-( Now 
that we have sysfs it could make a come back. The software cursor code 
doesn't behave proprely from userlane. It was design to work with the 
console system only. 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
