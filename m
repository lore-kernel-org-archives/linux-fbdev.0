From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Linux 2.5.19
Date: Wed, 29 May 2002 13:44:12 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com>
References: <20020529211702.E30585@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DAIz-0002ol-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 13:44:25 -0700
In-Reply-To: <20020529211702.E30585@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> This is completely wrong - the driver has been tested NOT to work on
> the Integraphics 1682.  As such, please do uncomment these lines.

Due to a error with merging some stuff from a older DJ tree. I fixed it
in the fbdev BK repository.

> In addition, I'm disappointed that no one forwarded the patch for
> maintainer approval PRIOR to submitting it to Linus.

I'm even more disappointed that some people DONT test my patches especially
when I announce them and usually wait about 5 days before pushing them to 
Linus. Some of the changes I have done have been sitting around for months
in the DJ tree. The good news is that people can now look at skeletonfb.c
to see how to port the fbdev drivers to the new api. Of course I have a
feeling most will not bother so I will have to do it for them.



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
