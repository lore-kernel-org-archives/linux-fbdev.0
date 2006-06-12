From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Twister savagefb doesn't sync (resolved for
	640x480@64K)
Date: Mon, 12 Jun 2006 10:37:43 -0400
Message-ID: <a728f9f90606120737x41f3ae1en60acaa8f16a319f5@mail.gmail.com>
References: <44698356.80806@iit.demokritos.gr>
	<447AF58E.3050803@iit.demokritos.gr> <447B60D7.8020204@gmail.com>
	<44845DEC.1000608@iit.demokritos.gr>
	<a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com>
	<44855197.7040801@iit.demokritos.gr>
	<a728f9f90606060743t7fd6dfdfia3e2a050ff954e06@mail.gmail.com>
	<448C067B.3040404@iit.demokritos.gr>
	<a728f9f90606110803v10ca364xf3e32e4a40f4bbfa@mail.gmail.com>
	<448D05EA.8060501@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpnYA-0001CL-K5 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 07:37:54 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FpnYA-0007UI-Ad for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 07:37:54 -0700
Received: from ug-out-1314.google.com ([66.249.92.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpnY7-0002PM-Nn
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 07:37:54 -0700
Received: by ug-out-1314.google.com with SMTP id k3so2485201ugf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 12 Jun 2006 07:37:43 -0700 (PDT)
In-Reply-To: <448D05EA.8060501@iit.demokritos.gr>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: vasvir@iit.demokritos.gr
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

On 6/12/06, Vassilis Virvilis <vasvir@iit.demokritos.gr> wrote:
> Alex Deucher wrote:
>
> >
> > I'm not sure I understand your question.
>
> That is because it wasn't a brilliant question and when I say screen
> I mean monitor. Sorry for the confusion. I was trying to figure out
> if the thing was external to the PCI card (i.e. in the monitor) or internal
> (i.e. DAC). But since I am not familiar with the domain I don't know
> how to ask the questions properly.
>
> Anyway is there a way to probe for that FP thing? or to distinguish
> between them?

about they most you can get on the savage is detecting whether or not
there is a panel attached and what size the panel is.  AFAIK, there's
no way to detect the panel specifics.  However, if we got some more
datapoints and found that most panels need the plls tweaked to a
certain range we could probably handle it more gracefully.  You could
probably even get it working now if you used a special modeline.

Alex

>
>
> > Perhaps if we had a few more testers we
> > could figure out a pattern for common panels and put in some sort of
> > generic fix.
> >
>
> I don't mind produce more data or test things as long as I have the
> equipment...
>
>
>        .bill
>
