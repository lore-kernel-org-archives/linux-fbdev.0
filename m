From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7 fbcon: set_con2fb on current console = crash
Date: Sat, 19 Jun 2004 14:13:44 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406191413.44439.adaplas@hotpop.com>
References: <20040618215047.GA4723@satan.blackhosts>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbZ8y-0005xw-Ht
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 23:16:00 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbZ8y-00020F-30
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 23:16:00 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id D454E62283B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 05:37:13 +0000 (UTC)
In-Reply-To: <20040618215047.GA4723@satan.blackhosts>
Content-Disposition: inline
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
To: Jakub Bogusz <qboosh@pld-linux.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Cc: pld-kernel@pld-linux.org

On Saturday 19 June 2004 05:50, Jakub Bogusz wrote:
> After upgrade from 2.6.4 to 2.6.7 I noticed that calling set_con2fb
> (through FBIOPUT_CON2FBMAP ioctl) on current console (already attached
> to fb using this ioctl) causes crash (oops and then recursive oops when
> trying to printk on console) and makes console unusable.
>
> That's because take_over_console() calls fbcon_deinit(vc_num)
> (which calls fbcon_free_font() on that console display) and then
> fbcon_init(vc_num, ...), which copies font data from current fb console.
> If current console was just deinit()ed, its fontdata is NULL - and this
> pointer is "copied" to the same place, leaving current console with
> fontdata==NULL (which leads to oops on nearest putc/putcs).
>
> Attached patch restores 2.6.4 behaviour on set_con2fb (to set font if
> it's not set already) - but it's not perfect solution as user font is
> still lost (unline on 2.4.x kernels).
> Any idea how to preserve user font on set_con2fb() called on current
> console?

Thanks.  Actually there's still a critical flaw in the set_con2fbmap code.  
For one, con2fb_map is never initialized.  It's just fortunate that this 
array happens to be  filled with zeroes so con2fb_map[n] will always return 
zero and registered_fb[0] happens to contain a valid info.  So it works, by 
accident. 

Secondly, if you load fbdev1, load fbdev2, unload fbdev1, load fbcon, the 
console will freeze. This is because fbdev1, which is originally in 
registered_fb[0], is now unloaded, and fbdev2, which is in registered_fb[1] 
is still loaded.  However, fbcon looks at registered_fb[0] during init.

Also, I really don't like the take_over_console part in set_con2fbmap.  Too 
many unknowns. 

There are still lot more problems which I won't mention. I'll try to fix some 
of them over this weekend.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
