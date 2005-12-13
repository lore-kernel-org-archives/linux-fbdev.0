From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: Waiting for patches in main line
Date: Tue, 13 Dec 2005 17:30:59 +0100
Message-ID: <439EF743.7000400@t-online.de>
References: <439DBC27.8050909@t-online.de>	<20051212121528.5391efc6.akpm@osdl.org>	<439E15CA.4070904@gmail.com> <20051212170854.7bb9f75c.akpm@osdl.org> <439E22B3.3080200@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmDOR-00081T-Pj
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 08:52:47 -0800
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EmDON-0004gu-J4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Dec 2005 08:52:45 -0800
In-Reply-To: <439E22B3.3080200@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net


>>So to confirm, after a compile test I'll send the following along to Linus
>>for 2.6.15:
>>
>>fbcon-add-ability-to-save-restore-graphics-state.patch
>>fbdev-pan-display-fixes.patch
>>fbcon-avoid-illegal-display-panning.patch
>>fbdev-fixing-switch-to-kd_text-enhanced-version.patch
>>fbdev-shift-pixel-value-before-entering-loop-in-cfbimageblit.patch
>>fbdev-fix-incorrect-unaligned-access-in-little-endian-machines.patch
>>    
>>
>
>  
>
Thanks for the quick reaction. All the patches cyblafb needs to compile 
and work are
included in git3 now.

A test showed that minor errors that were corrected by the patches I 
received from
Antonino remain in git3 --- bitstream font 16x30 is broken a bit, as 
well as rotation 2.
But these cases are not as broken as without the patches ;-)

I have no time left today and will sort out things tomorrow.

cu,
 Knut




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
