From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Re: Devices don't get linked to
	their class.
Date: Wed, 08 Sep 2004 13:21:38 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1094613697.2805.1.camel@laptop.cunninghams>
References: <1094187751.2979.41.camel@laptop.cunninghams>
	 <1094441896.19674.24.camel@laptop.cunninghams>
	 <20040907195055.GB6021@dreamland.darkstar.lan>
	 <200409080855.34209.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4szM-0000O6-Ne
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 20:19:16 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1C4szJ-0007d2-PS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 20:19:16 -0700
Received: from 147.32.220.203.comindico.com.au
	([203.220.32.147] helo=relay01.kbs.net.au ident=8)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1C4szC-0008H6-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 20:19:08 -0700
In-Reply-To: <200409080855.34209.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Kronos <kronos@people.it>

Thanks!

Nigel

On Wed, 2004-09-08 at 10:55, Antonino A. Daplas wrote:
> > There's framebuffer_alloc for that. I forgot to re-add a struct device *
> > to fb_info after I added the class_simple stuff:
> >
> 
> Hey, nice!
> 
> Nigel, here's an updated patch.  For drivers already using
> framebuffer_alloc(), we let them be.  For the rest, some I updated to use
> framebuffer_alloc(), rivafb and i810fb, and the remainder, set info->device
> during the initialization stage.
> 
> I'll push this to Andrew at the end of the week, I'll just let the previous
> patches I submitted simmer in his tree first.
> 
> You need to reverse the patch I sent you.  You'll probably get offsets.

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
