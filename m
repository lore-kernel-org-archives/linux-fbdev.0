From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: Re: FBdev updates.
Date: Sun, 16 Mar 2003 17:10:56 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E74F670.4020609@netscape.net>
References: <20030309212903.GC16578@vana.vc.cvut.cz> <Pine.LNX.4.44.0303111527500.23668-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from imo-m01.mx.aol.com ([64.12.136.4])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ugNU-0007yz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Mar 2003 14:13:12 -0800
Received: from nwourms@netscape.net
	by imo-m01.mx.aol.com (mail_out_v34.21.) id 6.13a.66355cc (22681)
	 for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Mar 2003 17:13:03 -0500 (EST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
>>Hi James,
>>  I tried to use fb_cursor and I have quite a lot problems with
>>it:
> 
> 
> I'm working on the code today. I just finished the final touchs on the 
> pixmap buffer code. The next step is to make the pixmaps have flag for 
> static data versus dynamic data. You can then use fastfonst with static 
> buffer. This comes with the tile code. But first the cursor code today.
> 
> P.S
>   You can grab my latest work on the matroxfb driver at 
> 
> http://phoenix.infradead.org/~jsimmons/matroxfb.diff.gz
> 

James (or anyone),

Do you have something which might apply at least 
semi-cleanly to fbdev-2.5 current?  The reason I ask is 
because I have to use 2.5.64-ac4 or else my system won't 
boot.  The problem is that Alan has already applied your 
latest BK patch which kills your matroxfb diff against 
fbcon.c.  Alan has also modified your changes, thus making 
backing it out quite difficult and prone to error...  Thanks 
in advance :-).

Cheers,
Nicholas



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
