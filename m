From: James Simmons <jsimmons@infradead.org>
Subject: Re: which's the max resolution of the logo ?
Date: Thu, 22 Aug 2002 12:28:07 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208221227320.9077-100000@maxwell.earthlink.net>
References: <20020822191430.GA18054@debian>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hxhn-00010Q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 12:33:19 -0700
In-Reply-To: <20020822191430.GA18054@debian>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Frame Buffer Devel Mailing List <linux-fbdev-devel@lists.sourceforge.net>


> ok, i understood the problem with my patch of the logo.

I patched fbcon.c to deal with displays with dimensions smaller than the
logo.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
