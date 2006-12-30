From: Robert de Bath <robert$@debath.co.uk>
Subject: Re: Bug#389433: Probable fix for fbdev shadow
	framebuffer issues
Date: Sat, 30 Dec 2006 13:58:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0612301330450.27246@mayday.local>
References: <Pine.LNX.4.61.0612211543030.27246@mayday.local> 
	<1166770773.4504.358.camel@thor.sulgenrain.local> 
	<Pine.LNX.4.61.0612242224030.27246@mayday.local> 
	<1167222340.16632.188.camel@thor.sulgenrain.local>
	<4593C572.8030703@ens-lyon.org>
	<Pine.LNX.4.61.0612282051281.27246@mayday.local> 
	<1167388994.2750.66.camel@thor.sulgenrain.local>
	<Pine.LNX.4.61.0612291148580.27246@mayday.local>
	<1167482042.6321.64.camel@thor.sulgenrain.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H0ejr-0007jk-3D for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Dec 2006 05:59:07 -0800
Received: from cpc2-alde1-0-0-cust820.glfd.cable.ntl.com ([86.16.135.53]
	helo=mayday.local)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H0ejp-0006tN-3B
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Dec 2006 05:59:07 -0800
In-Reply-To: <1167482042.6321.64.camel@thor.sulgenrain.local>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
Cc: linux-fbdev-devel@lists.sf.net

> I don't understand what you're saying here, please elaborate.

Okay, I was looking at an older kernel source; some of the fb drivers
were _modifying_ the hardware state in the _check_ function.

This time I looked at a more recent kernel source (it has finished
downloading) and it appears these bugs have now all been fixed; I can't
find one anyway. So it's safe to ignore the problem; it's gone away :-)

-- 
Rob.                          (Robert de Bath <robert$ @ debath.co.uk>)
                                              <http://www.debath.co.uk/>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
