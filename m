From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch] Add w100 framebuffer driver
Date: Wed, 5 Jan 2005 00:38:11 -0000
Message-ID: <034f01c4f2be$d7c29c60$0f01a8c0@max>
References: <200501031947.33925.rpurdie@rpsys.net> <Pine.GSO.4.61.0501041029390.27452@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ClzFN-0007CG-7S
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Jan 2005 16:41:57 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1ClzFH-0000od-Aw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Jan 2005 16:41:56 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: adaplas@hotpop.com, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven:
>
> If your driver doesn't support panning, just don't fill in .fb_pan_display
>
>> +static void w100_vsync()
>                          ^
>   void


Thanks for the comments. I've changed the driver accordingly and sent a 
revised version to Tony. I've not cc'd the list as the patch is large and 
the only changes are those mentioned above. (Remove the panning function and 
its reference, add void to the w100_vsync function declaration.)

Richard 



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.298 / Virus Database: 265.6.7 - Release Date: 30/12/2004



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
