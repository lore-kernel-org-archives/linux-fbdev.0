From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: Re: [PATCH] - video/tridentfb.c warning fix.
Date: Wed, 14 Apr 2004 15:21:16 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040414152116.0ac5139c.lcapitulino@prefeitura.sp.gov.br>
References: <20040413164729.2eba2e6e.lcapitulino@prefeitura.sp.gov.br>
	<Pine.LNX.4.44.0404141905520.13481-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDp0i-00057P-OE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:21:20 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDp0i-0005sk-CQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:21:20 -0700
In-Reply-To: <Pine.LNX.4.44.0404141905520.13481-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sf.net


Hi James,

Em Wed, 14 Apr 2004 19:06:00 +0100 (BST)
James Simmons <jsimmons@infradead.org> escreveu:


| ANyone want to test this?

 I will speak in the name of all patches. :-)

 I think you (yes, I'm not a video card hacker, so was a bad
idea try to remove the code) have 3 choices:

1- comment the unsed code with #if 0 / #endif (and think in it
later);
2- use the accel functions and make a call for tests in lkm;
3- make a new compilation flag which can be enable in configuration
file. That flag could enable the use of accel function.

 I think the option 3 could be good, if there is no people to code it,
I can try.

PS: I'm not subscribed in fbdev-devel.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
