From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Implementing new fb driver
Date: Tue, 16 Sep 2008 15:58:53 -0700
Message-ID: <48D03A2D.3020608@manoweb.com>
References: <20080731081154.57D5320B413@f26.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KfjV8-00033t-2o for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Sep 2008 15:58:30 -0700
Received: from moutng.kundenserver.de ([212.227.126.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KfjV6-0008Tt-Hs
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Sep 2008 15:58:30 -0700
In-Reply-To: <20080731081154.57D5320B413@f26.poczta.interia.pl>
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
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net

krzysztof.h1@poczta.fm wrote:

>> Hi there, I will be implementing a framebuffer driver for an
>> internally developed video adapter.

> There is a driver template called skeletonfb.c. It has extensive
> comments. Please use it as your template and report any problem (it
> should be up to date with API but something maybe missing).
> 
> A good example of working ARM fb driver is s3c2410fb driver.


I have a question; this hardware supports (only) true color cursors. Is
the fb API unable to deal with this? I have read only 1-bit cursor
images are supported.

This said, I ma confused by the hw cursors calls, and I am not sure how
to proceed. Basically my hardware can store a number of cursor images,
enable or disable the cursor, and move the cursor at a specified
position. How do I implement that?

Thank you!
Alessio



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
