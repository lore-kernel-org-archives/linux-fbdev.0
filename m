From: James Simmons <jsimmons@infradead.org>
Subject: Re: video/tdfxfb.c warning fix.
Date: Tue, 27 Apr 2004 21:29:22 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404272129160.21601-100000@phoenix.infradead.org>
References: <20040427171833.4af6c4cd.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIZCn-0004yo-0K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:29:25 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIZCm-0002Zf-D9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 13:29:24 -0700
In-Reply-To: <20040427171833.4af6c4cd.lcapitulino@prefeitura.sp.gov.br>
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
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-fbdev-devel@lists.sourceforge.net


Yes.


On Tue, 27 Apr 2004, Luiz Fernando N. Capitulino wrote:

> 
>  Hi,
> 
> drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not used
> 
>  seems to me that tdfxfb_cursor(), is the one of accelerate functions, which
> is not well tested. I'm wrong ?
> 
>  If not, can I made it avaliable in Kconfig as I did before for the other
> drivers ?
> 
> thanks,
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
