From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 18:55:01 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051853060.27760-100000@phoenix.infradead.org>
References: <1046877877.1291.186.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qe3E-0006bX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 10:55:37 -0800
In-Reply-To: <1046877877.1291.186.camel@localhost.localdomain>
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


> > > Fbcon needs to be cleaned up, a lot. It still implements the "current
> > > console or foreground console" concept (only one console active at a
> > > time).  Also, this is more of a job for linuxconsole than fbdev.  I may
> > > be wrong though.
> > 
> > Mmm, do you know who is working on linuxconsole, and what their plan are ?
> 
> James also. I think the site is http://linuxconsole.sourceforge.net.

Its me. I have been so busy with fbdev tho I haven't worked on the console 
project. Plus other events in my life (joblessness) has been keeping me 
busy doing other things. I have the old ruby code that worked. So it is a 
matter of porting it over to 2.6 when it comes out. I have been keeping it 
up to date pretty much (2.5.59). 



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
