From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Fri, 30 Apr 2004 07:58:52 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083275931.20091.150.camel@gaston>
References: <Pine.LNX.4.44.0404291848170.1327-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJJg3-0003WO-Bb
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 15:06:43 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BJJg3-0000Lo-0f
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 15:06:43 -0700
In-Reply-To: <Pine.LNX.4.44.0404291848170.1327-100000@phoenix.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2004-04-30 at 04:01, James Simmons wrote:
> > > No we don't. We have the default modedb. I already tested a patch using 
> > > modedb. It works like a charm :-) I can stty all I want!!!! 
> > 
> > On your monitor... then most TFT owners will curse you :)
> 
> As we move from ioctls to sysfs we will also move from using 
> fb_var_screeninfo as the userland interface to using mode strings.
> That means when someone creates a string  like
> 
> 834x721@81 
> 
> then for non TFT monitors it should fail. For TFT monitors it will work.
> If someoone using stty ask for exotic mode then if the monitor is TFT then 
> it should work. Else it should fail. 

Maybe... though for a TFT, you

1) need more infos than that to set a proper mode
2) don't care bout the refresh rate once you have that proper mode set
since you use the HW scaler

Ben.
 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
