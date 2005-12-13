From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Waiting for patches in main line
Date: Tue, 13 Dec 2005 08:28:58 +0800
Message-ID: <439E15CA.4070904@gmail.com>
References: <439DBC27.8050909@t-online.de> <20051212121528.5391efc6.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ely2W-0004MP-Uc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 16:29:08 -0800
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ely2V-0007GH-8t
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 16:29:08 -0800
Received: by zproxy.gmail.com with SMTP id z3so1535333nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Dec 2005 16:29:06 -0800 (PST)
In-Reply-To: <20051212121528.5391efc6.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Knut Petersen <Knut_Petersen@t-online.de>, linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> Knut Petersen <Knut_Petersen@t-online.de> wrote:
>> It would be nice if the patches of Antonino A. Daplas could be integrated
>> into main line code soon. At least those patches that fix problems in
>> console rotation, panning and scrolling, and the patch that introduces the
>> save_state() and restore_state() framebuffer operations.
>>
> 
> Well it's getting rather late, but if we can identify specifically which
> patches are needed we can perhaps do something.
> 

> fbdev-fix-incorrect-unaligned-access-in-little-endian-machines.patch

This one is a real bug fix.

> fbcon-add-ability-to-save-restore-graphics-state.patch

This one adds functionality.  But none currently uses it except for
Knut's revised driver (to be submitted?), and perhaps by savagefb in
the future)  If Knut's driver is going to mainline, this needs to go
in too.

It should not introduce regressions.

> fbdev-pan-display-fixes.patch

This is a bug fix for drivers that does YWRAP scrolling.

> fbcon-avoid-illegal-display-panning.patch

This is a real bug fix.

> fbdev-fixing-switch-to-kd_text-enhanced-version.patch

Again, none uses this currently, but Knut's revised driver will.
This should not introduce regressions.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
