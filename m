From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Waiting for patches in main line
Date: Tue, 13 Dec 2005 09:24:03 +0800
Message-ID: <439E22B3.3080200@gmail.com>
References: <439DBC27.8050909@t-online.de>	<20051212121528.5391efc6.akpm@osdl.org>	<439E15CA.4070904@gmail.com> <20051212170854.7bb9f75c.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Elyts-0007ow-3j
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 17:24:16 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Elytq-0007Xy-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 17:24:16 -0800
Received: by zproxy.gmail.com with SMTP id r28so1549676nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Dec 2005 17:24:13 -0800 (PST)
In-Reply-To: <20051212170854.7bb9f75c.akpm@osdl.org>
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
Cc: Knut_Petersen@t-online.de, linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>>> fbdev-fix-incorrect-unaligned-access-in-little-endian-machines.patch
>> This one is a real bug fix.
> 
> OK, this one causes me some grief, because it changes things which aren't
> in Linus's tree yet.
> 
> <looks>
> 
> If I merge
> fbdev-shift-pixel-value-before-entering-loop-in-cfbimageblit.patch as well,
> all is good.

Yes, that's a safe patch to include.
 
> 
> So to confirm, after a compile test I'll send the following along to Linus
> for 2.6.15:
> 
> fbcon-add-ability-to-save-restore-graphics-state.patch
> fbdev-pan-display-fixes.patch
> fbcon-avoid-illegal-display-panning.patch
> fbdev-fixing-switch-to-kd_text-enhanced-version.patch
> fbdev-shift-pixel-value-before-entering-loop-in-cfbimageblit.patch
> fbdev-fix-incorrect-unaligned-access-in-little-endian-machines.patch

Yes.

> 
> There's also
> 
> 	fbcon-fix-complement_mask-with-512-character-map.patch
> 
> which I have yet to test.  I guess we can hold off on that?
> 

Yes, the worst that can happen is a bad gpm cursor.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
