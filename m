From: James Simmons <jsimmons@infradead.org>
Subject: Re: Vertical retrace interrupts?
Date: Wed, 12 Feb 2003 20:21:42 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122019331.31435-100000@phoenix.infradead.org>
References: <1044118163.3906.29.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j3Oc-00026f-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 12:22:19 -0800
In-Reply-To: <1044118163.3906.29.camel@localhost.localdomain>
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
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > I wonder if people will like having to build the DRM for a framebuffer
> > device... a solution where one component uses the other if it's there,
> > but works without it otherwise, might be better.
> > 
> Yes, your suggestion is better.  I did browse the dri code, and my
> feeling is drm is coded for userspace clients without any usable hooks
> for clients residing in kernel space. I'm still wondering how to access
> DRM services from kernel space.  

I have to agree. For most platforms fbdev is a needed. You could view DRM 
as a power extenstion to fbdev. Well that is how I view it. If we have DRM 
enabled we can enable more features in fbdev.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
