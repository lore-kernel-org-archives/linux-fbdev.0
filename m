From: Eric Pretorious <eric@pretorious.net>
Subject: Re: /usr/src/linux/Documentation/fb/aty128fb.txt (fwd)
Date: Mon, 4 Oct 2004 23:57:19 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410042357.20226.eric@pretorious.net>
References: <Pine.GSO.4.61.0410042119240.19047@waterleaf.sonytel.be> <200410051101.01409.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEjON-0007tG-34
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 00:05:47 -0700
Received: from he.net ([216.218.186.2])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CEjOM-0001Wu-0t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 05 Oct 2004 00:05:46 -0700
Received: from localhost ([216.218.186.2]) by he.net for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 5 Oct 2004 00:05:41 -0700
In-Reply-To: <200410051101.01409.adaplas@hotpop.com>
Content-Disposition: inline
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

On Monday 04 October 2004 08:01 pm, Antonino A. Daplas wrote:
>On Tuesday 05 October 2004 03:19, Geert Uytterhoeven wrote:
>> ---------- Forwarded message ----------
>> Date: Mon, 4 Oct 2004 11:59:47 -0700
>> From: Eric Pretorious <eric@pretorious.net>
>> Subject: /usr/src/linux/Documentation/fb/aty128fb.txt
>>
>> >Accepted options:
>> >
>> ><XxX@X>  - selects startup videomode. See modedb.txt for detailed
>> >           explanation. Default is 640x480x8bpp.
>>
>> Should the values be enclosed - as illustrated - in brackets? (I've been
>
>No. Parameters in brackets are meant to be optional.

1. *All* of the options are optional but they aren't enclosed in < or >.
2. Those aren't the usual "this-is-optional" kind of brackets - i.e., [ and ] 
- but I do see your point. From /usr/src/linux/Documentation/fb/modedb.txt:

  To specify a video mode at bootup, use the following boot options:
    video=<driver>:<xres>x<yres>[-<bpp>][@refresh]

>> passing the value using the "vga=0x317".) The framebuffer.txt file
>> describes it like this...
>
>The option "vga=xxx" is only for drivers that lets the BIOS do the mode
>setup for them.  Some of these drivers are vesafb and matroxfb.

I dont' know if it's *supposed*to* but the "vga=xxx" works with aty128fb. 
(It's the only way that I've gotten it to work so far. I'll retest *without* 
the <...> and report back later.

Thanks for the clarification!  :^)

-- 
Eric P.,
Sunnyvale, CA


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
