From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: =?gb2312?B?u9i4tDpSZTogUHJvYmxlbSBhYm91dCBGQiBvbiBhbiBpQm9vayBHNA==?=
Date: Thu, 30 Sep 2004 17:44:44 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0409301743180.9524@waterleaf.sonytel.be>
References: <87dca6df.a6df87dc@huawei.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CD372-0007bG-R9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Sep 2004 08:44:56 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CD371-00078X-NL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Sep 2004 08:44:56 -0700
In-Reply-To: <87dca6df.a6df87dc@huawei.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jiangning 39481 <jiangnuts@huawei.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 30 Sep 2004, jiangning 39481 wrote:
> > That's offb, the Open Firmware Frame Buffer device, which is used 
> > as a fallback
> > for unsupported graphics cards.
> > 
> > What kernel version does Yellow Dog Linux 3.01 use? Does it 
> > include radeonfb?
> > Recent versions of radeonfb should recognize your Mobility Radeon 
> > 9200.
> 
> The kernel version of YDL3.01 is 2.4.22,I want to know the video command format like "video=xxx:xxxxxxx".Can you give me the detail info?

The radeonfb in that kernel may be too old for your Radeon. What does `lspci
-v' say?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
