From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Three fbdev bug fixes
Date: Fri, 29 Apr 2005 09:57:02 +0800
Message-ID: <200504290957.03448.adaplas@hotpop.com>
References: <9e47339105042810025d35a2ad@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRKkf-0005Cc-7C
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 18:57:09 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DRKkd-0001Tx-OJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 18:57:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5B90A1106317
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Apr 2005 01:56:59 +0000 (UTC)
In-Reply-To: <9e47339105042810025d35a2ad@mail.gmail.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>

On Friday 29 April 2005 01:02, Jon Smirl wrote:
> #1) fbdev is missing unregister_chrdev(FB_MAJOR, "fb");
> #2) rounding issues can make an acceptable mode fail
> added  hfreq = (hfreq + 500) / 1000 * 1000;

I already picked up 1 and 2.

Tony




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
