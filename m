From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Fri, 30 Apr 2004 17:05:09 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404301703340.12865-100000@phoenix.infradead.org>
References: <1083275931.20091.150.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJaVr-0003GX-1B
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 09:05:19 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BJaVq-0007FN-5n
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 09:05:18 -0700
In-Reply-To: <1083275931.20091.150.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



> > > On your monitor... then most TFT owners will curse you :)
> > 
> > As we move from ioctls to sysfs we will also move from using 
> > fb_var_screeninfo as the userland interface to using mode strings.
> > That means when someone creates a string  like
> > 
> > 834x721@81 
> > 
> > then for non TFT monitors it should fail. For TFT monitors it will work.
> > If someoone using stty ask for exotic mode then if the monitor is TFT then 
> > it should work. Else it should fail. 
> 
> Maybe... though for a TFT, you
> 
> 1) need more infos than that to set a proper mode

What do I need? I like to see this idea work.

> 2) don't care bout the refresh rate once you have that proper mode set
> since you use the HW scaler

Okay. You don't have to pass in a mode string with a refresh rate anyways.
If it's not a tft then we can pick one basded on user preference.





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
