From: James Simmons <jsimmons@infradead.org>
Subject: Re: HW cursor
Date: Tue, 6 Jan 2004 00:16:16 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401060014490.7347-100000@phoenix.infradead.org>
References: <200312190701.35873.alper@xynth.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdetP-00062a-FD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:16:19 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AdetO-0002dG-Sb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:16:19 -0800
In-Reply-To: <200312190701.35873.alper@xynth.org>
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
To: Alper Akcan <alper@xynth.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Hi all,
> 
> I could not manage to use fb_cursor support of 2.6.0 kernel...
> Is there any sample code that shows how to use hw cursor support of fbdev.
> I have tried so many things, all I have is segfault.
> 
> I have Nvidia TNT2M64

Sorry I haven't written anything yet. I have this card and the problem is 
a endian issue. The cursor data is big endian and the hardware is 16 bit 
little endian. I like to fix it in the next few days.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
