From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 15:25:51 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303061524480.4540-100000@phoenix.infradead.org>
References: <20030306114009.GA1770@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qxGW-0004Dc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 07:26:36 -0800
In-Reply-To: <20030306114009.GA1770@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Oops, totally missed your question :-)  But yes, I think the EDID block
> > contains information about the monitor type, not sure thogh.
> 
> X finds :
> 
> Digital Display Input
> 
> So, i guess this is it.

Yes the EDID block does have info on the monitor type. It even has the 
vendor name. I wonder if it can detect when you unplug a monitor and plug 
in a new one?



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
