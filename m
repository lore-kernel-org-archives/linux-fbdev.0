From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Fri, 7 Mar 2003 10:31:48 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0303071030590.1781-100000@maxwell.earthlink.net>
References: <3E68B895.2080500@winischhofer.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rLq3-0000tF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 09:40:55 -0800
In-Reply-To: <3E68B895.2080500@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Antonino Daplas <adaplas@pol.net>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Therefore, the calculation of vrows has to take the difference between
> these two into account.
>
> The attached patch fixes this for me but I have no idea if I cought all
> possible itches. It will no apply cleanly, because I had made changes to
> fbcon.c before making a backup copy - but it sure illustrates the problem.
>
> Why you used info->var.yres_virtual (and not the adapted
> var.yres_virtual) in fbcon_resize() is beyond me, BTW.

My mistake. I applied your patch.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
