From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: [PATCH] fb: add support for handoff from
	firmware to hw framebuffers
Date: Thu, 4 Jun 2009 09:17:22 +0200
Message-ID: <10f740e80906040017v56d17ff5sbb3b0aa1298440b0@mail.gmail.com>
References: <1244090788-31645-1-git-send-email-airlied@gmail.com>
	<21d7e9970906032150w7a159b7bgaa9fa3c0c17eadb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1MC7CX-0005FZ-JO
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 07:17:25 +0000
Received: from mail-bw0-f218.google.com ([209.85.218.218])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MC7CW-0006zs-LM for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 07:17:25 +0000
In-Reply-To: <21d7e9970906032150w7a159b7bgaa9fa3c0c17eadb6@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev-devel@lists.sf.net

On Thu, Jun 4, 2009 at 06:50, Dave Airlie <airlied@gmail.com> wrote:
> On Thu, Jun 4, 2009 at 2:46 PM, Dave Airlie <airlied@gmail.com> wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> With KMS we have ran into an issue where we really want the KMS fb driver
>> to be the one running the console, so panics etc can be shown by switching
>> out of X etc.
>
> btw so far this is just an RFC.

But if it's accepted, you also want to add this support to offb.c, and
probably even macfb.c (dupes with valkyriefb.c).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
