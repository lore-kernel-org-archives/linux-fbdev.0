From: Romain Dolbeau <dolbeau@irisa.fr>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Mon, 01 Jul 2002 09:57:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D200B7D.7436FF5F@irisa.fr>
References: <20020701073516.GA26755@lambda.u-strasbg.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sky.irisa.fr ([131.254.60.147])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Ow4T-0005Cd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 00:58:05 -0700
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
To: Sven Luther <luther@lambda.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

Sven Luther wrote:

> I have compiled a 2.5.24 kernel and added the few things needed to make
> the pm3fb work (basically, i had to patch Config.in and Config.help so i
> could enable it in the configuration process).

Could you send me the patch please ?

> Is there a reason why it was not enabled previously, or is it just
> forgetting the these two files (which probably did not patch correctly
> due to the Config.in and Config.help location and format change).

I though the old-format drivers wouldn't work so I never bothered
submitting for inclusion.

> Anyway, it works fine (well as good as with the 2.4.x kernel), there
> still is problem with the copying of the text console data at bootup,
> but apart from that everything is fine.
> 
> Should i send over a patch for adding it to the Config.xxx files ?

Please send me the patch, I'll submit them for inclusion

Thanks for the help,

-- 
DOLBEAU Romain           | I witness a time and a place that never dies,
ENS Cachan / Ker Lann    | still frozen in time, this darkness the only 
Thesard IRISA / CAPS     | place that I can hide. I witness, a dream.   
dolbeaur@club-internet.fr|  -- Black Sabbath, 'I Witness'


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
