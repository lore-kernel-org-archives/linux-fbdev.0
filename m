From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer updates.
Date: Tue, 25 Mar 2003 20:50:47 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303252049550.6228-100000@phoenix.infradead.org>
References: <20030325182746.GA8769@iucha.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xvOH-00064d-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 12:51:26 -0800
In-Reply-To: <20030325182746.GA8769@iucha.net>
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
To: Florin Iucha <florin@iucha.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Where can I find working "modelines" for Radeon 8500?
> 
> I have a 
>    radeonfb: ATI Radeon 8500 QL DDR SGRAM 64 MB
> 
> I am interested in 1024x768 and 1152x864. I have tried the defaults
> that come with Debian fbset (2.1-8) but I get garbled screen upon
> changing the video mode. I can 'clear' the console and work more or
> less normally but the viewport will be just a part of the whole
> screen.

Try using stty. I see most people will continue to use fbset so I guess I 
need to patch it up to do the right thing.




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
