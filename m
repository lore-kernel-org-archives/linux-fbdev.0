From: rwhron@earthlink.net
Subject: Re: Re: 2.6.0-test2 does not boot with matroxfb
Date: Fri, 15 Aug 2003 19:18:34 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030815231834.GA9226@rushmore>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19nnoC-0003NK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Aug 2003 16:16:36 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jsimmons@infradead.org
Cc: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net

>> o graphics in console with "links -g"

> Links ??? the web browser. I tried that option and it complained.

There are two versions of links.  
v0.99.x	The amazing text browser.
2.1.x	Does graphics, javascript, etc in console mode.

http://atrey.karlin.mff.cuni.cz/~clock/twibright/links/download/links-2.1pre11.tar.bz2

I configured links-2.x with:
/configure  --prefix=/usr --enable-graphics --enable-javascript --with-ssl=/usr/lib

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
