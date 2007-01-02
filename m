From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: intelfb driver on 945GM chipset
Date: Tue, 2 Jan 2007 13:27:57 +1100
Message-ID: <21d7e9970701011827q714656belf91904fa9ebd63c6@mail.gmail.com>
References: <20061228135302.52101.qmail@web90402.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1ZNg-0000zL-8U for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 18:28:00 -0800
Received: from ug-out-1314.google.com ([66.249.92.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H1ZNe-0003UD-Rx
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 18:28:00 -0800
Received: by ug-out-1314.google.com with SMTP id z38so4766922ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Jan 2007 18:27:57 -0800 (PST)
In-Reply-To: <20061228135302.52101.qmail@web90402.mail.mud.yahoo.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On 12/29/06, rami jiossy <sramij@yahoo.com> wrote:
>
> Hi;
> here is my dmesg output.
> as you can see below intelfb claims no video mode configured at boot time
> inspit is does.
>

Intelfb doesn't support mode switching on non-CRT devices, I've
contemplated doing the work, but I really don't have a requirement for
it and it is a lot of work..

I'm not sure how you can get the mode set to 1024x768 before intelfb runs..

Dave.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
