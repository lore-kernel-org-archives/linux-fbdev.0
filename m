From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: intelfb driver on 945GM chipset
Date: Tue, 2 Jan 2007 16:21:22 -0500
Message-ID: <250898A7-50FD-4F98-BB33-B02150A34803@cecropia.com>
References: <20061228135302.52101.qmail@web90402.mail.mud.yahoo.com>
	<21d7e9970701011827q714656belf91904fa9ebd63c6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1r4w-0001Os-NB for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 13:21:50 -0800
Received: from mail7.sea5.speakeasy.net ([69.17.117.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1r4v-0003ad-Dv
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 13:21:50 -0800
Received: from rrcs-24-39-225-185.nys.biz.rr.com (HELO [172.16.0.117])
	(dmunsie@cecropia.com@[24.39.225.185])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES128-SHA encrypted
	SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 2 Jan 2007 21:21:43 -0000
In-Reply-To: <21d7e9970701011827q714656belf91904fa9ebd63c6@mail.gmail.com>
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

Dave is correct -- the intelfb driver doesn't support mode changing.   
I had worked on this for a bit, and had moved Dave's Xorg code over.   
I believe it was mostly working when I had to set it aside.

I'll try to get all the code that I had together again, and submit a  
patch if I can.

dennis

On Jan 1, 2007, at 9:27 PM, Dave Airlie wrote:

> On 12/29/06, rami jiossy <sramij@yahoo.com> wrote:
>>
>> Hi;
>> here is my dmesg output.
>> as you can see below intelfb claims no video mode configured at  
>> boot time
>> inspit is does.
>>
>
> Intelfb doesn't support mode switching on non-CRT devices, I've
> contemplated doing the work, but I really don't have a requirement for
> it and it is a lot of work..


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
