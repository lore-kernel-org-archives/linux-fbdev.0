From: James Simmons <jsimmons@infradead.org>
Subject: Re: console_struct.h:97: `MAX_NR_CONSOLES' undeclared here
Date: Wed, 4 Dec 2002 09:17:48 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212040917020.18551-100000@maxwell.earthlink.net>
References: <3DED8815.8000408@attbi.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18JcKm-0001sa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Dec 2002 08:25:12 -0800
In-Reply-To: <3DED8815.8000408@attbi.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I applied the patch from tonight to 2.5.50 and got this build error:
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> <http://phoenix.infradead.org/%7Ejsimmons/fbdev.diff.gz>

Okay. I found the problem. tty.h was missing in this file. I will post
another patch soon.




-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
