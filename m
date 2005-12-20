From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1: 2.6.15-rc6] Fix clearing of vertical margins
Date: Tue, 20 Dec 2005 20:02:57 +0800
Message-ID: <43A7F2F1.2050900@gmail.com>
References: <43A7D7B3.6000907@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EogDm-0004f0-0q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 04:03:58 -0800
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EogDk-0007P1-Du
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 04:03:58 -0800
Received: by zproxy.gmail.com with SMTP id z3so1325245nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 04:03:54 -0800 (PST)
In-Reply-To: <43A7D7B3.6000907@t-online.de>
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
Content-Type: text/plain; charset="us-ascii"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Whenever the font width does not divide the x resolution, the remainder
> of this division is a vertical margin at right of the screen. Whatever the
> video memory contains in that margin is displayed.
> 
> This patch corrects this behaviour. There is no performance impact
> as long as there is no vertical margin as fbcon_clear_margins() and
> bit_clear_margins() only execute additional code if really necessary.
> 
> I think this patch should be applied before 2.6.15-final.
> 
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

NAK.  The right margin is cleared just once on an fbcon_switch (entire
yres_virtual). The right margin should remain cleared until another
fbcon_switch happens so it's not necessary to clear the right margins again.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
