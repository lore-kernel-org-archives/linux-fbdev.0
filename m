From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] radeonfb: 16bpp accel broken.  a work-around
Date: Fri, 25 Jun 2004 00:26:56 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040625002656.4d853a90.akpm@osdl.org>
References: <20040616182415.GA8286@middle.of.nowhere>
	<20040617022100.GA11774@havoc.gtf.org>
	<20040617051931.GA1378@middle.of.nowhere>
	<20040617054746.GA24184@havoc.gtf.org>
	<20040618110450.GA2771@middle.of.nowhere>
	<20040625071819.GA12537@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bdl83-0007xn-Ut
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Jun 2004 00:28:07 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bdl83-0008VE-HT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Jun 2004 00:28:07 -0700
In-Reply-To: <20040625071819.GA12537@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: thunder7@xs4all.nl, linux-fbdev-devel@lists.sourceforge.net

David Eger <eger@havoc.gtf.org> wrote:
>
> I've tracked Jurriaan's radeonfb problem down to copyarea() malfunctioning 
>  in 16bpp mode.  Here's a hack to just do a software copyarea() in 16bpp mode.
>  No more screen garbage, but then it's slow :-/
>  for instance, cat' ing the MAINTAINERS file:
>     8bpp -  ~1.5 sec
>    16bpp - ~19 sec  (with yucky fix)
>    32bpp -  ~6 sec
> 
>  -dte
> 
> 
>  radeonfb: 16bpp work-around - copyarea() doesn't work

err, why not fix copyarea()?


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
