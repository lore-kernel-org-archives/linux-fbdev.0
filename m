From: andrew may <acmay@acmay.homeip.net>
Subject: Re: Radeon video in PowerBook G4 800
Date: Thu, 6 Jun 2002 13:31:30 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020606133130.A28991@ecam.san.rr.com>
References: <20020605160346.B25385@ecam.san.rr.com> <20020605221731.23001@smtp.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 24-25-196-177.san.rr.com ([24.25.196.177] helo=acmay.homeip.net)
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17G3uv-0000U0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Jun 2002 13:31:33 -0700
In-Reply-To: <20020605221731.23001@smtp.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: andrew may <acmay@acmay.homeip.net>, ajoshi@unixbox.com, Linux fbdev <linux-fbdev-devel@lists.sourceforge.net>, "May, Andrew" <amay@viasat.com>

On Thu, Jun 06, 2002 at 12:17:31AM +0200, Benjamin Herrenschmidt wrote:
> >----- Forwarded message from andrew may <acmay@acmay.homeip.net> -----
> >
> >Date: Wed, 5 Jun 2002 15:55:04 -0700
> >From: andrew may <acmay@acmay.homeip.net>
> >To: bh40@calva.net
> >Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
> >  Linux fbdev <linux-fbdev-devel@lists.sourceforge.net>
> >Subject: Radeon video in PowerBook G4 800
> >
> >I am having problems with the radeon fb driver in BenH's 2.4.19-pre10
> >kernel. When it boots I get a strange grayish red blob that covers most
> >of the screen starting from the bottom right side.
> >
> >I tried Xfree 4.20 and saw a similar effect.
> >
> >Here is a dump from the init with DEBUG turned on in the driver.
> >
> >The BenH kernel has some fixes from the 0.1.4 radeon driver and
> >I have not been able to get the 0.1.5 patch from the archieves 
> >to try.
> 
> Hrm, weird. Some users are running it without problem. 
> 
> Ani, any clue ?

Well I did get the 0.1.5 patch and I applied it. It did not seem
to help any. I had to merge things by hand at some parts since
the benh kernel did already have some stuff in there. 

Can I get a copy of the 0.1.5 instead of a patch so we can be sure
we are on the same page.

Ben, do you have any an email of someone that has it working
so we can try to compare some things?

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
