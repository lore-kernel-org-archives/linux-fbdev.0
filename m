From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Tue, 27 Apr 2004 10:22:45 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083025364.11575.4.camel@gaston>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIGSN-0005lR-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 17:28:15 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIGSM-0000B6-Et
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Apr 2004 17:28:14 -0700
In-Reply-To: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-04-27 at 10:19, James Simmons wrote:
> Okay. This is my first attempt to address this problem. There is not test 
> for accelerated copyarea or image drawing as we lack the flag. I haven't 
> figured where to put it yet. We have 3 choices.
> 
> 
> fb_var_screeninfo
> fb_fix_screeninfo
> fb_info

Well... fix is what gets filled after a mode is set, let's put it in there
along with the linewidth etc...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
