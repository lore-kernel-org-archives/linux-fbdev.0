From: "Thibaut VARENE" <varenet@parisc-linux.org>
Subject: Re: Patch to upgrade epson fb driver
Date: Wed, 13 Dec 2006 21:13:04 +0100
Message-ID: <7d01f9f00612131213p588c1a74me94896319b6db770@mail.gmail.com>
References: <BAY109-F146ADCEDD2A216DCA19B07CBD60@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuaTZ-0000g0-1q for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 12:13:13 -0800
Received: from an-out-0708.google.com ([209.85.132.242])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GuaTX-0000oC-Ft
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 12:13:12 -0800
Received: by an-out-0708.google.com with SMTP id d40so102461and
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 13 Dec 2006 12:13:05 -0800 (PST)
In-Reply-To: <BAY109-F146ADCEDD2A216DCA19B07CBD60@phx.gbl>
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
To: Kristoffer Ericson <kristoffer_e1@hotmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi

On 12/13/06, Kristoffer Ericson <kristoffer_e1@hotmail.com> wrote:
> Greetings,
>
> Im maintainer of hp jornada7xx which uses a epson chipset to power its fb.
> We want to make use of your driver and Russell suggested sending patch to
> you directly so you can apply it to git.

Better send it to linux-fbdev since I don't maintain a git repository.
I'm glad to learn that this driver is actually useful on other
platforms than the one it was initially developed for! :)

> Please reply once you get this as I dont know if you are active or not.

I don't have the hardware to develop this driver anymore, so I can
only comment on the code without testing it.

The patch looks ok. For fun and "beauty" you could probably adapt the
other strings that define "S1D13806" on a case by case basis, but
that's really not a big deal.

HTH

Acked-by: Thibaut VARENE <varenet@parisc-linux.org>

-- 
Thibaut VARENE
http://www.parisc-linux.org/~varenet/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
