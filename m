From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 19:31:21 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051931070.27760-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0303051638000.23176-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qecS-00088z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 11:32:01 -0800
In-Reply-To: <Pine.GSO.4.21.0303051638000.23176-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Indeed, accel_clear_margins() calculates the margins as
> 
>     unsigned int cw = vc->vc_font.width;
>     unsigned int ch = vc->vc_font.height;
>     unsigned int rw = info->var.xres % cw;
>     unsigned int bh = info->var.yres % ch;
> 
> However, if it would use
> 
>     unsigned int rw = info->var.xres - (vc->vc_cols*cw);
>     unsigned int bh = info->var.yres - (vc->vc_rows*ch);
> 
> it would work with higher differences, too. And it would be a bit faster
> (multiply and subtract vs. modulo).

Applied.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
