From: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: Radeon video in PowerBook G4 800
Date: Wed, 5 Jun 2002 17:39:34 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0206051737470.99874-100000@shell.unixbox.com>
References: <20020605155504.A26280@ecam.san.rr.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from shell.unixbox.com ([207.211.45.65])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17FlAe-0005r8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Jun 2002 17:30:32 -0700
In-Reply-To: <20020605155504.A26280@ecam.san.rr.com>
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
To: andrew may <acmay@acmay.homeip.net>
Cc: bh40@calva.net, Linux fbdev <linux-fbdev-devel@lists.sourceforge.net>


You may wish to try http://www.unixbox.com/~ajoshi/radeon_drv.o.gz, unzip
and replace your /usr/X11R6/lib/modules/drivers/radeon_drv.o with it.
That should get X working.  If you cannot get the 0.1.5 patch from the
archives still, let me know and i'll send u a copy.


ani

On Wed, 5 Jun 2002, andrew may wrote:

> I am having problems with the radeon fb driver in BenH's 2.4.19-pre10
> kernel. When it boots I get a strange grayish red blob that covers most
> of the screen starting from the bottom right side.
>
> I tried Xfree 4.20 and saw a similar effect.
>
> Here is a dump from the init with DEBUG turned on in the driver.
>
> The BenH kernel has some fixes from the 0.1.4 radeon driver and
> I have not been able to get the 0.1.5 patch from the archieves
> to try.
>




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
