From: Jani Monoses <jani@iv.ro>
Subject: Re: tridentfb in 2.5.70 broken
Date: Tue, 10 Jun 2003 12:04:20 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030610120420.715bbad5.jani@iv.ro>
References: <20030608212435.17118c5b.b.stolk@chello.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iv.ro ([194.105.28.94])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Pet8-0003d0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 01:53:55 -0700
In-Reply-To: <20030608212435.17118c5b.b.stolk@chello.nl>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net


> Hi there,
> 
> 
> tridentfb 0.7.8-NEWAPI, as shipping with linux-2.5.70 is broken.
> in tridentfb_check_var(), the check for nativex should read:
> 
>         if (flatpanel && nativex && var->xres > nativex)
> 
> instead of:
> 
> 	if (var->xres > nativex)
> 
> otherwise all modes are rejected on a non FP.

Feel free to send a patch, I don't have time right now, in fact I
haven't used 2.5 for a long time. In 2.5 all fbdevs now have the fb
suffix for consistency in boot args but the docs for trident were not
updated.
You can send the patch to this list hopefully it will be picked up by
somebody. If not I'll send it eventually .
thanks
Jani


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
