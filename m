From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: how to activate X with famebuffer
Date: Mon, 27 Sep 2004 20:11:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040927181102.GA32549@epio.fluido.as>
References: <4EE0CBA31942E547B99B3D4BFAB34811107FD3@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBzxq-00010i-Df
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 11:11:06 -0700
Received: from a205017.upc-a.chello.nl
	([62.163.205.17] helo=casa.fluido.as ident=Debian-exim)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41)
	id 1CBzxp-0000Fh-DR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 11:11:06 -0700
Received: from fluido by casa.fluido.as with local (Exim 4.34)
	id 1CBzxm-00006n-7G
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 20:11:02 +0200
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811107FD3@mail.esn.co.in>
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
	Date: lun, set 27, 2004 at 07:06:59 +0530

Quoting Mukund JB. (mukundjb@esntechnologies.co.in):

> I get the error message saying :-
> (EE) Screen(s) found, but none have a usable configuration.

<cut>
 
> Section "Screen"
> 	Identifier "Screen0"
> 	Device "Linux Frame Buffer"
> 	Monitor "COMPAQ S510"
> 	DefaultDepth 8
> 	Subsection "Display"
> 		Depth 8
> 	#	Modes "1024x768"
> 	EndSubSection
> EndSection

Why did you comment out the "modes" line??

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
