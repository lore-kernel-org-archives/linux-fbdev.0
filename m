From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.5.19
Date: Wed, 29 May 2002 21:47:39 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020529214739.F30585@flint.arm.linux.org.uk>
References: <20020529211702.E30585@flint.arm.linux.org.uk> <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DAMM-00037n-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 13:47:55 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10205291331500.19493-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, May 29, 2002 at 01:44:12PM -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, May 29, 2002 at 01:44:12PM -0700, James Simmons wrote:
> > This is completely wrong - the driver has been tested NOT to work on
> > the Integraphics 1682.  As such, please do uncomment these lines.
> 
> Due to a error with merging some stuff from a older DJ tree. I fixed it
> in the fbdev BK repository.

They haven't *been* in any DJ tree.

> > In addition, I'm disappointed that no one forwarded the patch for
> > maintainer approval PRIOR to submitting it to Linus.
> 
> I'm even more disappointed that some people DONT test my patches especially
> when I announce them and usually wait about 5 days before pushing them to 
> Linus. Some of the changes I have done have been sitting around for months
> in the DJ tree. The good news is that people can now look at skeletonfb.c
> to see how to port the fbdev drivers to the new api. Of course I have a
> feeling most will not bother so I will have to do it for them.

Why the fuck should I go around finding and testing peoples trees when I
haven't submitted the stuff to them?  *YOU* shouldn't go around randomly
pulling stuff from maintainers trees without first asking them why the
change hasn't been submitted.

I'm not talking about general maintainence of the cyber2000fb driver here,
or general "keep it working" type changes.  I'm talking about a blatent
"take the version from the rmk patch and submit it to Linus without telling
the maintainer of the code you're buggering with" attitude here.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
