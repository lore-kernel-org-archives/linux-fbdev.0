From: "Christopher Hoover" <ch@murgatroid.com>
Subject: RE: [PATCH 2.5.68] Epson 1355 Rewrite for 2.5
Date: Wed, 7 May 2003 16:10:17 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <000601c314ed$d37e2490$675f040f@bergamot>
References: <Pine.LNX.4.44.0305072107440.6566-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139] helo=heavens.murgatroid.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DY3O-00084A-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 16:10:26 -0700
In-Reply-To: <Pine.LNX.4.44.0305072107440.6566-100000@phoenix.infradead.org>
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
To: 'James Simmons' <jsimmons@infradead.org>, 'Geert Uytterhoeven' <geert@linux-m68k.org>
Cc: 'Linux Frame Buffer Device Development' <linux-fbdev-devel@lists.sourceforge.net>


> I just reworked cfbimgblt.c to use struct pixmap and I am in 
> the process of of working on the other cfb_* functions. Would you be 
> willing to test this out? In theory one would only have to 
> place in there 
> own FB_WRITE[READ] function. 

I'd be glad to test it out.  

-ch

P.s. 
I'm at 2.5.68 because that's the latest "rmk" arm kernel.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
