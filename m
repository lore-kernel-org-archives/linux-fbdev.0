From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Radeonfb hsync fudge factor?
Date: Wed, 24 Dec 2003 12:42:13 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072230132.699.22.camel@gaston>
References: <3FE8D315.1000904@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYy2s-00062r-TI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 17:42:42 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AYy2s-0007bQ-D9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Dec 2003 17:42:42 -0800
In-Reply-To: <3FE8D315.1000904@undead.cc>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-12-24 at 10:43, John Zielinski wrote:
> What's the hsync fudge factor used for?
> 
> I noticed that the left edged of my screen moved a bit when I was 
> switching between 32/16/8 bpp modes and tracked it down to this.
> 
> John
> 
> p.s.  I have this urge to giggle every time I type in the words "fudge 
> factor" for some reason.  :)

I'm not too sure about why it's there, it comes from ATI code in
the first place.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
