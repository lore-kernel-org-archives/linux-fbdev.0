From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: 2.5 offb breakage
Date: Wed, 31 Jul 2002 20:07:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020731180708.19824@192.168.4.1>
References: <Pine.LNX.4.44.0207311049150.13905-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [217.167.51.129] (helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Zxs1-0003xO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 Jul 2002 11:06:49 -0700
In-Reply-To: <Pine.LNX.4.44.0207311049150.13905-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

>-	info =
>-	    kmalloc(sizeof(struct fb_info) + sizeof(struct display) +
>-		    sizeof(u32) * 17, GFP_ATOMIC);
>+	size = sizeof(struct fb_info) + sizeof(struct display) + sizeof(u32) * 17;
>+
>+	info = kmalloc(size, GFP_ATOMIC);

Ok, I fixed that in my tree as well, but didn't yet test with
CONFIG_FBCON_ACCEL _and_ that fix. I'll do that now.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
