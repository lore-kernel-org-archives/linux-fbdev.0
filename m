From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 18:46:48 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051844560.27760-100000@phoenix.infradead.org>
References: <1046875559.1291.135.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qdvO-0003Hy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 10:47:31 -0800
In-Reply-To: <1046875559.1291.135.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> This was one of the goals of the Ruby project, but I think it's mostly 
> the input layer that got into the kernel. 

Also the new fbdev api was apart of ruby. So all the low level changes 
went in. The upper console layer stuff didn't. This will be for the next 
developement kernel. 

> Fbcon needs to be cleaned up, a lot. It still implements the "current
> console or foreground console" concept (only one console active at a
> time).  Also, this is more of a job for linuxconsole than fbdev.  I may
> be wrong though.

Correct. This is more of a console thing. I do want to fix up fbcon now 
but only for bug fixes.




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
