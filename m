From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch] Add w100 framebuffer driver
Date: Sat, 8 Jan 2005 18:32:47 -0000
Message-ID: <00c201c4f5b0$7689ad40$0f01a8c0@max>
References: <200501031947.33925.rpurdie@rpsys.net> <20050106180511.GA8050@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnLOR-0003IW-NG
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Jan 2005 10:32:55 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CnLOQ-00036o-02
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Jan 2005 10:32:55 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, kronos@people.it
Cc: adaplas@hotpop.com

Kronos:
> Il Mon, Jan 03, 2005 at 07:47:33PM +0000, Richard Purdie ha scritto:
>> Add a framebuffer driver for the ATI w100 as found on several Sharp PDAs
>
> Some minor comments:

Thanks for the comments. I've made the suggested changes and will post an 
updated patch shortly.

> Are you sure that the compiler does the right thing? Don't you need
> __attribute__((packed)) for this and the following structures?

It works without it but adding it doesn't hurt so I have. I've also killed 
off all the typedefs as they hindered readability.

Cheers,

Richard



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.300 / Virus Database: 265.6.9 - Release Date: 06/01/2005



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
