From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: how to activate X with famebuffer
Date: Tue, 28 Sep 2004 08:54:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040928065431.GA9604@epio.fluido.as>
References: <4EE0CBA31942E547B99B3D4BFAB34811107FFD@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCBsm-0001kw-TG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 23:54:40 -0700
Received: from a205017.upc-a.chello.nl
	([62.163.205.17] helo=casa.fluido.as ident=Debian-exim)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41)
	id 1CCBsk-0008L5-5C
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 23:54:40 -0700
Received: from fluido by casa.fluido.as with local (Exim 4.34)
	id 1CCBse-00040K-2u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Sep 2004 08:54:32 +0200
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811107FFD@mail.esn.co.in>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

	Subject: RE: [Linux-fbdev-devel] how to activate X with famebuffer
	Date: mar, set 28, 2004 at 11:11:37 +0530

Quoting Mukund JB. (mukundjb@esntechnologies.co.in):

> > > I get the error message saying :-
> > > (EE) Screen(s) found, but none have a usable configuration.
> > 
> > <cut>
> > 
> > > Section "Screen"
> > > 	Identifier "Screen0"
> > > 	Device "Linux Frame Buffer"
> > > 	Monitor "COMPAQ S510"
> > > 	DefaultDepth 8
> > > 	Subsection "Display"
> > > 		Depth 8
> > > 	#	Modes "1024x768"
> > > 	EndSubSection
> > > EndSection
> > 
> > Why did you comment out the "modes" line??
> I am defining the mode in the lilo.conf file.

Your error message tells you that the "screen" section is
unusable. So, you are supposed to experiment with modifications on
that section until the error message changes - that is, until your
screen section becomes usable. Focus on the immediate block. When your
screen section is OK. either X will work, or you will have a new error
message pointing to new tests and experiments.

X must be told at what resolution to work, and all framebuffer drivers
but the simple VESA one can change resolution on the fly, so you can
very well have X in one resolution and text mode in one (or more)
other resolutions. 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
