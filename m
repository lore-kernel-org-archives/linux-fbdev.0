From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbcon & resize
Date: Mon, 24 May 2004 12:44:43 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085366682.24948.22.camel@gaston>
References: <1085360912.15281.7.camel@gaston>  <40B159B1.9050108@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BS5Ud-00044H-Od
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 19:47:11 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BS5Ud-0000VA-7i
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 19:47:11 -0700
In-Reply-To: <40B159B1.9050108@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >We need to cleanup and generalize a function for matching a mode to
> >the mode list to be used by drivers for validation in check_var() too,
> >my current algorithm in radeonfb is a bit broken for CRTs for example,
> >and has the nasty habit of refusing modes rather than "adapting" them.
> >  
> >
> I'm curious as to what you mean by "adapting" them.

Well, I'm getting complaints regulary when radeonfb refuses a mode
(via set_var) that has out of range timings instead of picking a
closer one. I'm not fully sure this is the right way to do though...

Ben.
 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
