From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: how to activate X with famebuffer
Date: Mon, 27 Sep 2004 07:48:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040927054853.GA17151@epio.fluido.as>
References: <4EE0CBA31942E547B99B3D4BFAB34811107F50@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBoNe-0002bA-Ni
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 22:48:58 -0700
Received: from a205017.upc-a.chello.nl
	([62.163.205.17] helo=casa.fluido.as ident=Debian-exim)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41)
	id 1CBoNd-0006ro-9R
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 22:48:58 -0700
Received: from fluido by casa.fluido.as with local (Exim 4.34)
	id 1CBoNZ-0004sP-PZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Sep 2004 07:48:53 +0200
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811107F50@mail.esn.co.in>
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

	Subject: [Linux-fbdev-devel] how to activate X with famebuffer
	Date: Mon, Sep 27, 2004 at 10:45:25AM +0530

Quoting Mukund JB. (mukundjb@esntechnologies.co.in):

> How to activate X with framebuffer.

I am not much of an expert, but I see noone is answering...
First of all, you must be sure that the framebuffer level is
working. What does  /proc/fb contain? There should be one or more
line. For example, mine has

0 ATI Radeon Yd

which means that I have one framebuffer unit available. 

Then, have a look at man fbdev. Specifically, the Driver line in your
device section should be 
 
Driver "fbdev"
 
There should be another way. Set 

Driver "nv"

(for nvidia cards, including riva ones) and set 

Option "UseFBDev" "on"

I have no clear idea about what the difference is. Anyway, Have a look
at man nv and man fbdevhw. 

ALL THIS IS PURELY THEORETICAL from my point of view!! You need to
experiment a bit. 

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
