From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 17:38:43 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404281733170.1187-100000@phoenix.infradead.org>
References: <408F0225.4000408@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIs5U-0000GO-PY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 09:39:08 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIs5T-0006I6-1P
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 09:39:08 -0700
In-Reply-To: <408F0225.4000408@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Zielinski <grim@undead.cc>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >No. Look the logic should go from the upper VT layer to the lower driver 
> >to accomplish something. Not the reverse.
> >
> >struct vc_data -> native console driver structure --> fbdev
> >
> >  
> >
> The problem with that is how would something like fbset work in that 
> situation?   The current way of selecing number of rows/columns through 
> the vt layer and hoping for the best in what mode you actually get is 
> way too limited to be the only mechanism.
> 
> Don't misunderstand me here.  I do want to be able to tell the vt to 
> switch to 1024x768@85-32 and have it propagate down and set the right 
> mode.  This shouldn't be a problem once we get a mechanism in place to 
> load a user's mode database into the kernel at run time.  Then the 
> timings will be exactly what I want when I say 1024x768@85-32.

But we do have that mechanism. Its call modedb. The only thing missing in 
the VT layer is the depth value whcich we should have anyways. BTW VT220 
did support different depths. I have t find out what the esc code was for 
that. I have the manual here. The other piece of data is the frequency. 
That is harder to deal with.I have to talk to a friend who use to program 
Vt220 about this. 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
