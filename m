From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fb modules and taking over console after boot
Date: Wed, 16 Jun 2004 04:05:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406160405.49808.adaplas@hotpop.com>
References: <20040615184322.GA9338@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaKBy-00034O-De
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 13:05:58 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BaKBx-0001eP-Uu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 13:05:58 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 9B36E7395C
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Jun 2004 19:05:44 +0000 (UTC)
In-Reply-To: <20040615184322.GA9338@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net

On Wednesday 16 June 2004 02:43, David Eger wrote:
> In Linux 2.6 -- It seems as though, for fbcon to take over the console,
> the relevant fb driver has to be built in to the kernel and the card
> detected during the boot sequence..  does anyone ever insert an fb driver
> as a module?  If so, which fb driver, and what do you do with it?  Just
> curious...
>

fbcon must be compiled as a module.  Then load the driver, followed by fbcon. 
fbcon cannot be unloaded (or rather, must not be unloaded).

I have loaded vga16fb, i810fb, rivafb successfully as modules.  Also, rivafb and 
i810fb can be unloaded since they have state save/restore functionality.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
