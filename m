From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] radeonfb: mode switch work around
Date: Sun, 4 Jul 2004 09:00:41 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407040900.41880.adaplas@hotpop.com>
References: <200406301047.57423.adaplas@hotpop.com> <20040704000518.GA14801@havoc.gtf.org> <20040704004627.GA17768@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgvM6-0006wa-Ip
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:59:42 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BgvM6-0001Rx-95
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 17:59:42 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id B0DE4FDCED6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  4 Jul 2004 00:40:25 +0000 (UTC)
In-Reply-To: <20040704004627.GA17768@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Sunday 04 July 2004 08:46, David Eger wrote:
> On Sat, Jul 03, 2004 at 08:05:18PM -0400, David Eger wrote:
> > Here's the fix for radeonfb for use with your patch.
> >
> > -dte
>
> On second look, strike that.  I have general badness trying to
> switch out of X in recent kernels to radeonfb.  Grr..  I'm not
> having luck pinpointing what went wrong just yet.
>

Maybe your hardware is one that requires a set_par() in both fbcon_blank()
and fbcon_switch(), the worst case scenario....?  If that's the case, we need
another flag (and another ugyly workaround).

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
