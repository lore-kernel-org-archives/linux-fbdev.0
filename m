From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fbdev programming info
Date: Tue, 22 Jun 2004 08:13:08 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406220813.08228.adaplas@hotpop.com>
References: <200406220011.51968.andrew@walrond.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BcYt2-0001xU-Ly
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 17:11:40 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BcYt2-0005P6-C3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Jun 2004 17:11:40 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 4202763445A
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Jun 2004 23:32:03 +0000 (UTC)
In-Reply-To: <200406220011.51968.andrew@walrond.org>
Content-Disposition: inline
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
To: Andrew Walrond <andrew@walrond.org>, linux-fbdev-devel@lists.sourceforge.net

On Tuesday 22 June 2004 07:11, Andrew Walrond wrote:
> Where is the best place to look for fbdev programming information/examples?
> A hour's googling didn't bring up much at all :(
>

You can try this.  It's mainly for the 2.6 architecture and also it did not
discuss some of the fb functions (such xxxfb_cursor).  But you should be
okay by combining the above and reading some of the drivers, notably vfb.c
vesafb.c, skeletonfb.c.

http://linux-fbdev.sourceforge.net/HOWTO/index.html

Note, this howto has an old version (for 2.2 kernels which also applies for 2.4)

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
