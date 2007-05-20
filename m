From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] pm2fb: white spaces clean up
Date: Sun, 20 May 2007 14:32:23 +0000 (UTC)
Message-ID: <4651AFD4.6020904@wp.pl>
References: <46508634.9030000@wp.pl> <1179662478.15182.1.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HpmSI-0000rY-NQ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 May 2007 07:32:18 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HpmSI-00088j-0U
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 May 2007 07:32:18 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	20 May 2007 16:32:14 +0200
Date: Mon, 21 May 2007 16:42:28 +0200
In-Reply-To: <1179662478.15182.1.camel@daplas>
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

Antonino A. Daplas wrote:
> On Sun, 2007-05-20 at 19:32 +0200, Krzysztof Helt wrote:
>> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>>
>> This patches kills spaces before tabs, spaces and tabs at line ends and replaces multiple 
>> spaces with tabs.
>>
>> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> I'm getting this:
> 
> 26 out of 26 hunks FAILED -- saving rejects to file
> drivers/video/pm2fb.c.rej
> 
> Let's just wait for the next mm release and rebase from that.
> (I usually strip white space from patches before sending to akpm, maybe
> that's the reason).
> 

I have to send it as attachment. I don't know what is wrong. Now, I use mozilla 
(seamonkey) and it was ok when I sent it to myself directly. It is corrupted all other 
when I got it through mailing list.

I'll fall back to both attachments and inlines to keep everybody happy.

Anyway, let's wait for the -mm patch.

Regards,
Krzysztof

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
