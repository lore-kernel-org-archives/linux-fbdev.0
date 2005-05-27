From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/1] intelfb-voffset
Date: Fri, 27 May 2005 15:50:51 -0700
Message-ID: <20050527155051.5e0fe177.akpm@osdl.org>
References: <20050527220932.865B91C00449@mwinf0201.wanadoo.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dbneg-0005aF-0d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 15:50:14 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Dbnef-0001po-9Q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 27 May 2005 15:50:13 -0700
In-Reply-To: <20050527220932.865B91C00449@mwinf0201.wanadoo.fr>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, sylvain.meyer@worldonline.fr

sylvain.meyer@worldonline.fr wrote:
>
> - Add voffset option to avoid conficts with Xorg i810 driver

Please provide more info.

- How does it "avoid conflicts"?

- How is the user to know that he needs to provide this module parameter?

- Is it not possible to prevent these "conflicts" without the use of a
  module parameter?


IOW: it's really a cop-out to require that the user know about some obscure
module parameter to be able to amke their system work correctly.  We
really, really want these things to "just work".



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
