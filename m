From: Otto Solares <solca@guug.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 19:07:25 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040429010725.GD24584@guug.org>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org> <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston> <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston> <20040428070832.GA23411@guug.org> <1083147416.18416.24.camel@thor.asgaard.local> <20040428163730.GA24448@guug.org> <1083191201.18413.73.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJ01C-00066B-6D
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:07:14 -0700
Received: from guug.galileo.edu ([168.234.203.30] helo=guug.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BJ01B-0000Pi-PU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:07:13 -0700
Content-Disposition: inline
In-Reply-To: <1083191201.18413.73.camel@thor.asgaard.local>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Apr 29, 2004 at 12:26:41AM +0200, Michel D=E4nzer wrote:
> Why? The purpose of the DRM lock is arbitration and state management
> between DRM clients. It's not necessarily connected to direct hardware
> access.

Agree, fbdev is too low-level to use the lock.

> A small low-level driver could handle this, which both the framebuffer
> device and the DRM use. Linus has proposed this approach, and I must say
> I like it.

That should be fbdev without fbcon.

-otto



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.=20
http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
